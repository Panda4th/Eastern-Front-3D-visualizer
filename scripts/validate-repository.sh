#!/usr/bin/env bash
set -euo pipefail

required=(
  README.md
  docs/foundation/project-foundation_v0.1.md
  docs/architecture/github-cloud-development-foundation_v0.3.md
  docs/governance/merge-authority.md
  docs/decisions/0001-identity-separation-option-c.md
  .github/ISSUE_TEMPLATE/general.yml
  .github/ISSUE_TEMPLATE/historical.yml
  .github/pull_request_template.md
  .github/workflows/policy-gate.yml
  .github/workflows/repository-validation.yml
  historical/data/README.md
  historical/sources/README.md
  historical/schemas/README.md
  historical/validation/README.md
)

for path in "${required[@]}"; do
  [[ -s "$path" ]] || { echo "Required non-empty file is missing: $path" >&2; exit 1; }
done

for pdf in Project_Foundation_v0.1.pdf GitHub_Cloud_開発基盤_基礎設計_v0.3.pdf; do
  [[ ! -e "$pdf" ]] || { echo "Superseded root PDF must be removed: $pdf" >&2; exit 1; }
done

# Ruby/Psych is preinstalled on GitHub-hosted runners and catches malformed YAML.
ruby -e 'require "yaml"; ARGV.each { |path| YAML.safe_load_file(path, aliases: true) }' \
  .github/ISSUE_TEMPLATE/general.yml \
  .github/ISSUE_TEMPLATE/historical.yml \
  .github/workflows/policy-gate.yml \
  .github/workflows/repository-validation.yml

grep -Fq 'Project Foundation v0.1' README.md
grep -Fq 'GitHub Cloud Development Foundation v0.3' README.md
grep -Fq 'Human Project Owner' docs/governance/merge-authority.md
grep -Fq 'Option C' docs/decisions/0001-identity-separation-option-c.md

# Technology selection is intentionally deferred in the Foundation phase.
for manifest in package.json pnpm-lock.yaml yarn.lock package-lock.json; do
  [[ ! -e "$manifest" ]] || { echo "Premature technology-selection manifest found: $manifest" >&2; exit 1; }
done

echo 'Repository foundation validation passed.'
