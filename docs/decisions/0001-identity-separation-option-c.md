# ADR 0001: Identity Separation Option C

- **Status:** Accepted with partial enforcement
- **Date:** 2026-08-12

## Context

Human, Claude, and Codex GitHub actors cannot currently be distinguished completely. Consequently, Human-only Merge cannot currently be guaranteed through complete identity separation alone.

## Decision

Use Option C in its current, partial form: combine available technical guardrails with explicit rules. AI merge, direct push to `main`, Branch Protection modification, and protection bypass are prohibited. Only the Human Project Owner performs the final merge. **Human-only Merge Enforcement = PARTIAL.**

This record does not assert that each AI already uses a separate identity or GitHub App.

## Consequences

Responsibility is explicit, but identity-based enforcement and attribution remain incomplete. Dedicated machine accounts, GitHub Apps, or equivalent verifiable separation may be evaluated later and recorded in a superseding decision.
