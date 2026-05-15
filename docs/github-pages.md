# GitHub Pages Sites

This repo manages DNS for the GitHub Pages sites. Application source, build
pipelines, and Pages content stay in their own repositories.

## Sites

- `hakimalai.com`: root CV site.
- `qr.hakimalai.com`: QR project.
- `pacman.hakimalai.com`: Pacman project.

## DNS Model

- Apex `hakimalai.com`: GitHub Pages `A` and `AAAA` records.
- `qr.hakimalai.com`: GitHub Pages `A` and `AAAA` records.
- `pacman.hakimalai.com`: GitHub Pages `A` and `AAAA` records, matching `qr`.

The current configuration intentionally uses GitHub Pages IP records for both
apex and subdomain hosts because that matches the existing Route 53 setup.

## Boundaries

GitHub Pages settings are not managed here yet. Import them only after the
current remote Pages build modes and custom-domain settings are verified.
