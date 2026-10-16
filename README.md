# Personal Website

Source for [harlenbains.com](https://harlenbains.com), built with [Astro](https://astro.build).

## Develop

```sh
npm install
npm run dev      # http://localhost:4321
npm run build    # static output in dist/
```

## Deploy

Pushing to `master` deploys automatically via GitHub Actions (`.github/workflows/deploy.yml`):
build → sync `dist/` to the S3 bucket → invalidate CloudFront.
AWS access uses GitHub OIDC, so no keys are stored in the repo.

Manual deploy (needs local AWS credentials): `npm run deploy`.
