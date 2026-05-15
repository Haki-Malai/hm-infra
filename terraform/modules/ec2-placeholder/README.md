# Future EC2 Module

Keep future EC2 work in a separate module so DNS/GitHub Pages changes stay
small and reviewable.

Initial defaults should favor the AWS free tier:

- `t3.micro` or `t2.micro`, depending on account eligibility and region.
- One security group with explicit inbound rules.
- No public SSH key committed to Git.
- Optional Route 53 record only after the instance is stable.
- `prevent_destroy` on persistent volumes if data is stored.

