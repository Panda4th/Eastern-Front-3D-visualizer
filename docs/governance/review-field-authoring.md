# Review Field Authoring Policy

**Status:** Active
**Adopted:** 2026-08-13
**Decided by:** Human Project Owner
**Upstream:** Project Foundation v0.1 / GitHub Cloud Development Foundation v0.3
**Related:** [Merge Authority Policy](./merge-authority.md)（本文書は Merge 権限を変更しない）

---

## 1. なぜこの文書が必要か

2026-08-13、Human Project Owner は運用規約の改訂を承認した。この改訂は Issue #1 のコメントおよび
PR #10 のコメントとしてのみ存在しており、Issue #1 は既に closed（2026-08-13T06:02:39Z）であるため
参照性が著しく低い。本文書は、その改訂内容を `docs/governance/` 配下の恒久的な参照場所として
記録するものである。

本文書は既に確定した事実を記録するものであり、新規の運用判断を行うものではない。

---

## 2. R-1. 改訂内容

- **発効日:** 2026-08-13
- **承認者:** Human Project Owner
- **改訂内容:** Pull Request 本文の記入責任を、実装担当（Codex）から PMO（Claude Code Sonnet）へ移す。

### 手順

1. Codex が実装し branch を push、Draft PR を作成する。
2. Overall Lead（Claude Code Opus）が実装を検証し、PR 本文に記入すべき内容を指示文として作成する。
3. PMO が指示文に従って PR 本文を置換する。
4. `policy / pr-policy` の判定を確認する。
5. 以降は通常フロー（SOL Independent Review → Integration Decision → Human Merge）とする。

### PMO が記入してよい欄

- Objective
- Related Issue
- Scope
- Changes
- Tests
- Historical Data Impact
- Source Traceability Impact
- Client Compatibility Impact
- Known Limitations
- Current HEAD
- Historical Change Detail

上記に含まれない欄（`## SOL Independent Review` / `## Integration Decision`）は本改訂の対象外である
（§4 参照）。

---

## 3. R-2. 改訂の理由

Codex は既存 PR の本文を編集できない。実行環境に Git remote がなく GitHub CLI も未認証であるため、
PR 本文更新・コメント投稿・Actions 結果確認ができない。

根拠として、PR #10 における Codex 自身の能力報告を参照する。

- https://github.com/Panda4th/Eastern-Front-3D-visualizer/pull/10#issuecomment-5276669700

この能力欠如により、PR #10 の `policy / pr-policy` が FAIL した（run 31672928350 / run 31673085845）。
これが本改訂の直接の契機である。

---

## 4. R-3. 変更していない点

以下は本改訂の対象外であり、変更していない。

- `## SOL Independent Review` 欄には、GPT SOL による実レビュー結果のみを記録する。
- `## Integration Decision` 欄には、Claude Opus による実統括判断のみを記録する。
- Foundation 文書（Project Foundation v0.1 / GitHub Cloud Development Foundation v0.3）は
  一切変更していない。
- Merge 権限（[`docs/governance/merge-authority.md`](./merge-authority.md)）は一切変更していない。

本改訂は「誰が記入するか」の運用割り当てにすぎない。

---

## 5. R-4. 負の側面と緩和策

本改訂には利点だけでなく負の側面がある。

- **負の側面:** 実装者による自己申告ではなくなる代わりに、記入者（PMO）が実装内容を誤記する経路が
  生まれる。PMO は §2 の手順で実装内容を直接検証したわけではない指示文に従って記入するため、
  指示文自体の誤りをそのまま PR 本文へ反映してしまう可能性がある。
- **緩和策:** PMO が PR 本文へ記入する内容は、「差分・CI 結果・Overall Lead の検証」という
  確認済みの事実に限定する。推測・見込み・未検証の記述を PR 本文へ書かない。

---

## 6. R-5. 解除条件

- 実装 AI が自力で Template 準拠の PR 本文を作成・更新できる環境が整った場合、本改訂を解除し、
  原則（実装者が自ら記入する）へ戻す。
- 解除の判断は Human Project Owner が行う。

---

## 7. R-6. SOL Independent Review 欄の記入責任

### 7.1 決定済み事項（2026-08-13 / Human Project Owner 決定）

- 原則として、SOL Independent Review 結果は GPT SOL 自身が PR 本文の
  `## SOL Independent Review` 欄へ記入する。
- 例外として、必要な場合に限り、Human Project Owner の明示的な許可を得たうえで
  PMO（Claude Code Sonnet）が転記してよい。PMO が自らの判断で同欄へ記入してはならない。
- この決定は GitHub Cloud Development Foundation v0.3 §20.1 の権限表「PR metadata 管理:
  SOL = Review 欄」と整合する。新たな役割変更ではなく、v0.3 が定めた原則の確認である。

### 7.2 実績（原則決定より前の運用。原則からの逸脱として記録する）

以下はいずれも本決定（2026-08-13）より前の運用であり、原則（GPT SOL 自身が記入する）からの
逸脱として記録する。

| PR | 転記者 | 備考 |
|---|---|---|
| PR #7 | Human Project Owner | 転記 |
| PR #10 | Human Project Owner | 転記 |
| PR #12 | PMO | PMO が転記し、Human Project Owner が事後に確認 |

### 7.3 未解決のまま残る事項

以下は本文書によって解決されるものではない。解決策をここで確定させない。

- GPT SOL が GitHub へ書き込める capability を実際に保持しているかは未検証である。
  GitHub Cloud Development Foundation v0.3 §20.2 は SOL の Review record write を
  「only if supported by dedicated integration」とし、Pull Requests は Read、Contents Write は
  None としている。
- GitHub Cloud Development Foundation v0.3 §14.3 のとおり、PR 本文の記述だけでは、同欄を記入した
  actor が本当に SOL であることを完全には証明できない。SOL 専用の GitHub App または reviewer
  identity が用意されるまで、この限界は残る。
- 例外パス（PMO 転記）が用いられる限り、SOL がレビューを実施した事実の GitHub native な記録が
  残らないという制約は解消しない。

---

## 8. R-7. Required Status Checks と Merge 阻止の関係

main branch の Required Status Checks は Human Project Owner により登録済みである。

- 「Require status checks to pass before merging」は有効。
- 必須 status checks は `pr-policy`（GitHub Actions）と `validation`（GitHub Actions）の 2 件。
- Merge Ready Mode で `pr-policy` が FAIL した場合、mergeable_state は `blocked` となり、Merge は
  実際に阻止される。根拠は PR #12 の実測である。
  - run 31705884135 → workflow `policy` / conclusion: `failure`
  - run 31706080217 → workflow `policy` / conclusion: `success`

ただし「Require branches to be up to date before merging」は無効であり、base branch が最新でない
状態でも Merge は可能である。branch の最新性は gate が保証していない。この点を保証されているかの
ように記述してはならない。

本改訂によって解決していない問題を、解決したかのように書かない。

---

## 9. 本文書の見直し条件

- §6 に定める解除条件が成立した場合。
- §7.3 に列挙した未解決事項について、Human Project Owner が新たな決定を行った場合。

見直しの結果は本文書を直接更新して記録し、無記録で書き換えない。
