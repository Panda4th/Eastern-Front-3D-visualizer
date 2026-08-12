# 独ソ戦 3D Historical Visualizer — GitHub Cloud 開発基盤 基礎設計 v0.3

**Status:** Reviewed Baseline Proposal  
**Date:** 2026-08-12  
**Upstream:** [Project Foundation v0.1](../foundation/project-foundation_v0.1.md)

## 1. Architecture decision

GitHub Free Organization 配下の Public Single Repository を推奨する。`main` は Protected Branch、変更は短命 task branch と Pull Request を経由し、Squash Merge のみを使用する。AI は branch/PR までを担当し、最終 merge は Human Project Owner のみが行う。GitHub Actions を build/test/validation の正本とし、Codespaces、Git Flow、長期 `develop`、auto merge、merge queue、外部 Preview SaaS は初期採用しない。

Desktop と Smartphone Browser を正式対象とし、モバイル対応を後付けにしない。Technology Selection 前には特定言語、framework、package manager または 3D library を仮定しない。

## 2. Repository baseline

```text
.github/{ISSUE_TEMPLATE,workflows}/
docs/{foundation,architecture,governance,decisions}/
historical/{data,sources,schemas,validation}/
src/ tests/ assets/ scripts/   # 後続フェーズで必要に応じ作成
README.md
```

Historical namespace は場所だけを確保し、schema、Source ID、確度モデルを先行設計しない。

## 3. Public content policy

コード、テスト、文書、dataset、source metadata、schema、validation、自作・Public Domain・再配布許諾確認済み asset のみ格納できる。購入書籍、無許可スキャン、再配布条件不明の地図・写真・asset、secret/token/password、個人情報および契約上非公開の情報を格納しない。史料原本の格納は traceability の要件ではなく、Source ID、書誌、頁、URL/Archive ID、access metadata から逆引き可能にする。

## 4. Branch and merge

許可する branch 名は `feature/<issue>-<slug>`、`fix/<issue>-<slug>`、`data/<issue>-<slug>`、`docs/<issue>-<slug>`、`infra/<issue>-<slug>`。原則 `1 Issue = 1 branch = 1 PR` とし、merge 後に削除する。

`main` protection は PR、up-to-date required checks、conversation resolution を要求する。force push、deletion、bypass を許可せず、push actor は Human Project Owner のみに制限する。Required approving reviews の初期値は 0 とし、GitHub native approval と SOL Independent Review を混同しない。詳細は [Merge Authority](../governance/merge-authority.md) に従う。

## 5. Pull Request contract

PR は Objective、Related Issue、Scope、Changes、Tests、Historical Data Impact、Source Traceability Impact、Client Compatibility Impact、Known Limitations、Current HEAD、SOL Independent Review、Integration Decision を持つ。Historical impact が `YES` の場合は Source IDs、evidence、traceability、validation、不確実性の詳細を追加する。

SOL PASS は review commit と Current HEAD が実際の PR HEAD SHA に一致し、decision が `PASS`、BLOCKER/MUST FIX が 0 の場合だけ有効である。push 後は review を stale として再レビューする。

## 6. Phase 0 CI

- `policy-gate.yml`: base branch の信頼済み定義を `pull_request_target` で実行し、PR metadata と HEAD SHA のみを検証する。PR code を checkout/execute せず、secret を渡さず、read-only permissions とする。
- `repository-validation.yml`: 通常の `pull_request` context で repository structure、必須文書、基本 format および Foundation/Governance の整合性を検証する。

Trusted Policy Gate と application CI を分離する。`.github/**`、Foundation、Governance 等の変更は governance-sensitive とし、変更理由を明記した独立 PR、SOL review、Opus decision、Human merge を要求する。Policy Gate の変更 PR は base branch 上の既存 gate で評価される。

## 7. Identity and authority

Human Owner/Admin identity と AI integration identity を分離し、Owner credential を AI に恒常的に渡さず、AI に admin、bypass または `main` push 権限を与えない。採用する Option C の詳細は [ADR-0001](../decisions/0001-identity-separation-option-c.md) を参照する。

## 8. Deferred decisions

Organization/repository 名、license、frontend stack、3D library、package manager、Historical schema/Source ID/status model、source acceptance 詳細、Pages、PR preview、browser matrix および performance budget は各後続フェーズまで未確定とする。
