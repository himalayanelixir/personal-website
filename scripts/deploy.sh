#!/usr/bin/env bash
# Upload dist/ to the site bucket and invalidate CloudFront.
# Used by CI and runnable locally (`npm run deploy`) with AWS credentials.
set -euo pipefail

BUCKET="${BUCKET:?set BUCKET to the S3 bucket name}"
DISTRIBUTION_ID="${DISTRIBUTION_ID:?set DISTRIBUTION_ID to the CloudFront distribution ID}"

[ -d dist ] || { echo "dist/ not found; run npm run build first" >&2; exit 1; }

# logs/ holds CloudFront access logs in the same bucket: never touch it.
# Fingerprinted assets can be cached forever...
aws s3 sync dist/ "s3://$BUCKET" --delete --exclude 'logs/*' \
  --exclude '*' --include '_astro/*' \
  --cache-control 'public, max-age=31536000, immutable'

# ...everything else (HTML, favicons) revalidates on each visit.
aws s3 sync dist/ "s3://$BUCKET" --delete --exclude 'logs/*' --exclude '_astro/*' \
  --cache-control 'public, max-age=0, must-revalidate'

aws cloudfront create-invalidation --distribution-id "$DISTRIBUTION_ID" --paths '/*' \
  --query 'Invalidation.Id' --output text
