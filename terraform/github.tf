resource "github_actions_repository_permissions" "hm_infra" {
  repository      = var.infrastructure_repository
  enabled         = true
  allowed_actions = "selected"

  allowed_actions_config {
    github_owned_allowed = true
    verified_allowed     = true
    patterns_allowed = [
      "hashicorp/setup-terraform@*",
    ]
  }
}

resource "github_repository_environment" "production" {
  repository  = var.infrastructure_repository
  environment = "production"

  deployment_branch_policy {
    protected_branches     = true
    custom_branch_policies = false
  }
}

resource "github_repository_ruleset" "restrict_branch_writes" {
  name        = "restrict-branch-writes"
  repository  = var.infrastructure_repository
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~ALL"]
      exclude = []
    }
  }

  bypass_actors {
    actor_id    = 5
    actor_type  = "RepositoryRole"
    bypass_mode = "always"
  }

  rules {
    creation = true
    update   = true
  }
}

resource "github_repository_ruleset" "protect_main" {
  name        = "protect-main"
  repository  = var.infrastructure_repository
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/heads/main"]
      exclude = []
    }
  }

  rules {
    deletion                = true
    non_fast_forward        = true
    required_linear_history = true

    pull_request {
      allowed_merge_methods             = ["squash"]
      dismiss_stale_reviews_on_push     = true
      require_code_owner_review         = false
      require_last_push_approval        = true
      required_approving_review_count   = 1
      required_review_thread_resolution = true
    }

    required_status_checks {
      strict_required_status_checks_policy = true

      required_check {
        context = var.required_status_check_context
      }
    }
  }
}

resource "github_repository_ruleset" "restrict_sensitive_paths" {
  name        = "restrict-sensitive-paths"
  repository  = var.infrastructure_repository
  target      = "push"
  enforcement = "active"

  rules {
    file_path_restriction {
      restricted_file_paths = [
        ".github/workflows/*",
        ".env*",
        "*.tfstate",
        "*.tfvars",
      ]
    }

    max_file_size {
      max_file_size = 10
    }
  }
}
