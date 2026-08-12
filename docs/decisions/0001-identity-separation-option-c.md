# ADR 0001: Identity Separation Option C

- **Status:** Accepted
- **Date:** 2026-08-12

## Context

AI が Human Project Owner の owner session を使用すると、Human-only merge を技術的に強制できず、実装・レビュー・統合の責任分離も監査できない。

## Decision

Option C を採用する。Human Project Owner は Organization Owner/Admin の専用 identity を保持し、各 AI integration は別 identity/GitHub App と最小権限 credential を使用する。AI は task branch と PR を更新できるが、`main` push、merge、admin、ruleset bypass はできない。SOL review は HEAD SHA に拘束し、Opus は統合判断のみを記録し、Human が merge を実行する。

## Consequences

actor の監査性、credential の失効範囲、Human-only merge の強制力が向上する。一方で identity/App の管理が必要になり、PR 本文だけでは SOL actor の真正性を完全には証明できない。当面は SHA 検証、Trusted Policy Gate、独立 review、統合判断および Human merge を組み合わせ、将来は専用 reviewer identity の検証を検討する。
