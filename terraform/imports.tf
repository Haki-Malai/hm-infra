import {
  to = aws_route53_record.apex_a
  id = "Z1028532234LVOB9E3HEK_hakimalai.com_A"
}

import {
  to = aws_route53_record.apex_aaaa
  id = "Z1028532234LVOB9E3HEK_hakimalai.com_AAAA"
}

import {
  to = aws_route53_record.github_pages_subdomain_a["qr"]
  id = "Z1028532234LVOB9E3HEK_qr.hakimalai.com_A"
}

import {
  to = aws_route53_record.github_pages_subdomain_aaaa["qr"]
  id = "Z1028532234LVOB9E3HEK_qr.hakimalai.com_AAAA"
}

import {
  to = github_repository_ruleset.restrict_branch_writes
  id = "hm-infra:16465508"
}
