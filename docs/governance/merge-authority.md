# Merge Authority Policy

## Current enforcement state

**Human-only Merge Enforcement: PARTIAL.** Human, Claude, and Codex GitHub actors cannot currently be distinguished completely. Human-only merge therefore is not represented as technically guaranteed by complete identity separation. The repository uses technical guardrails together with this explicit operating rule.

## Mandatory rules

- AI must not merge a pull request.
- AI must not push directly to `main`.
- AI must not change, disable, or bypass Branch Protection.
- Only the Human Project Owner makes the final merge decision and performs the merge.
- AI may implement and test changes on task branches and submit review material, subject to its available access.

Branch Protection must require a PR, required status checks, an up-to-date branch, and conversation resolution; must prohibit force pushes and deletion; and must not allow AI bypass. Squash merge is the approved merge method.

## Future review

If dedicated machine accounts, GitHub Apps, or another mechanism later provides verifiable actor separation, technical enforcement may be reconsidered through a new recorded decision. This policy does not claim that such separation exists today.
