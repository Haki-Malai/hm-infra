# Security Notes

## Repository Access

The repository is public so GitHub Actions and GitHub Pages can stay on the
free public-repo path. Public visibility does not grant write access.

## Main Branch

Terraform creates a repository ruleset for `main` that:

- Requires pull requests.
- Requires the `Terraform Check` status check.
- Requires branches to be up to date.
- Blocks branch deletion and force pushes.
- Requires linear history.
- Does not define bypass actors.

## Branch Creation and Pushes

Terraform also creates an all-branches ruleset that:

- Blocks branch creation unless the actor can bypass as a repository admin.
- Blocks pushes to branches unless the actor can bypass as a repository admin.
- Still leaves `main` protected by the stricter no-bypass PR/status-check ruleset.

For this personal public repo, public users cannot create upstream branches or
push. Only the repo owner/admin can create or update non-main branches. Do not
grant admin access to collaborators unless they should have the same bypass
ability.

## Deployment

The apply workflow only runs when `github.ref` is exactly `refs/heads/main`.
The job also uses the `production` environment, which is restricted to protected
branches by Terraform.

## Secrets

PR workflows do not receive AWS or GitHub administration secrets. The PR
workflow performs only `terraform fmt`, provider init with `-backend=false`,
and `terraform validate`.

## Workflow Backdoors

Terraform also creates a push ruleset that blocks pushes modifying
`.github/workflows/*`, `.env*`, `*.tfstate`, and `*.tfvars` after bootstrap.
Changing workflows later should be treated as a controlled operation through
reviewed Terraform changes.

## Known Limit

GitHub cannot prevent repository admins from changing repository settings.
The design removes ordinary bypass paths, but admin access remains inherently
powerful.
