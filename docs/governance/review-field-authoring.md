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

1. Codex が実装し、task branch を push、Draft PR を作成する。
2. Overall Lead（Claude Code Opus）が実装を検証し、PR 本文へ記入すべき内容を指示文として作成する。
3. PMO（Claude Code Sonnet）がその指示文に従い PR 本文を置換する。
4. `policy / pr-policy` の判定を確認する。
5. 通常フロー（SOL Independent Review → Integration Decision → Human Merge）へ進む。

### PMO が記入してよい通常欄

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

この改訂は「誰が通常欄を記入するか」という運用割り当ての変更であり、レビュー判断そのものの権限
移動ではない。`## SOL Independent Review` / `## Integration Decision` は対象外である（§4 参照）。

---

## 3. R-2. 改訂の理由

### 3.1 Codex の能力報告

PR #10 の既存本文修正を依頼された際、Codex は以下を報告した。

- 実行環境に Git remote が設定されていなかった。
- GitHub CLI が未認証だった。
- そのため GitHub 上の既存 PR 本文を更新できなかった。
- PR コメントを投稿できなかった。
- GitHub Actions の実行結果を確認できなかった。

Codex はその際、指示に従い以下を実施しなかった。コード・ファイルの変更、commit の追加、Draft の
解除、Merge、`main` への push、新規 PR の作成。結果として PR #10 の本文置換と、更新後の workflow
run ID / conclusion の報告は未完了となった。これは能力上の制約であり、指示違反として扱われたもの
ではない。

参照: https://github.com/Panda4th/Eastern-Front-3D-visualizer/pull/10#issuecomment-5276669700

### 3.2 PR #10 の CI FAIL 原因

Overall Lead が PR #10 HEAD `2a10466ac8b770c09a3b39839b13b309771a666c` を検証した。実装差分
（`Project_Foundation_v0.1.pdf` / `GitHub_Cloud_開発基盤_基礎設計_v0.3.pdf` の削除 2 件のみ）は
Scope に適合していた。

一方、PR 作成時点の本文は connector によって自動生成されており、Pull Request Template に準拠せず
`### Motivation` / `### Description` / `### Testing` の 3 見出しのみで構成されていた。Policy Gate
が要求する固定見出しを 1 つも満たしていなかった。

確認された workflow:

| run | event | mode | conclusion |
|---|---|---|---|
| `31672928350` | `opened`（draft=false） | Merge Ready Mode | `failure` |
| `31673085845` | `converted_to_draft` | Draft Mode | `failure` |
| `31672928343` | — | `repository / validation` | `success` |

`policy / pr-policy` FAIL の直接原因は、PR 本文が Template の必要構造を満たしていないことであり、
実装差分そのものの不備ではなかった。Codex が既存 PR 本文を修正できない環境制約により、Codex 自身
ではこの状態を回復できなかったことが、本改訂の直接の契機となった。

### 3.3 Human Project Owner の判断と PMO への指示

Human Project Owner は 2026-08-13、「PMO が PR 本文を修正し、修正指示文は Overall Lead が作成する」
という運用を承認した。Overall Lead は PMO に対し、PR #10 の body のみを完全置換する自己完結型の
指示を作成した。PMO には以下が要求された。

- PR HEAD を置換直前に再確認する。
- PR body のみを変更する（commit の追加、Draft 解除、Merge、`main` への push、Branch Protection・
  `.github/` の変更はいずれも行わない）。
- PR title / base / head / labels を変更しない。
- Template の固定見出しを保持する。
- `## SOL Independent Review` / `## Integration Decision` に判断値を書かない。
- 更新後の `policy / pr-policy` を確認する。

### 3.4 PMO の完了実績

PMO は置換直前に PR #10 HEAD が `2a10466ac8b770c09a3b39839b13b309771a666c` であることを確認した
上で、指示された Template 準拠本文へ body を置換した。コード変更・追加 commit・Draft 解除・Merge・
push・Branch Protection・`.github/` の変更は行わなかった。

本文更新（`edited` イベント）により再実行された `policy / pr-policy` は、run `31677294512`
（Draft Mode）で `success` となった。`repository / validation`（run `31672928343`）も `success` の
ままだった。

この実績を、Codex から PMO へ通常欄の記入責任を移した理由の具体例として記録する。

---

## 4. R-3. 変更していない点

以下は本改訂の対象外であり、変更していない。

- `## SOL Independent Review` は GPT SOL による実レビュー結果を記録する欄である。
- `## Integration Decision` は Claude Code Opus による実統括判断を記録する欄である。
- Project Foundation v0.1 は本改訂で変更していない。
- GitHub Cloud Development Foundation v0.3 は本改訂で変更していない。
- [`docs/governance/merge-authority.md`](./merge-authority.md) の Merge 権限は変更していない。
- 最終 Merge は Human Project Owner のみが行う。
- 本改訂は通常の PR 本文記入作業の担当変更であり、Independent Review / Integration Decision /
  Merge の判断権限を変更するものではない。

---

## 5. R-4. 負の側面と緩和策

本改訂には利点だけでなく負の側面がある。利点のみを記載しない。

**負の側面:** PR 本文が実装者自身による自己申告ではなくなることで、別の記入者（PMO）が実装内容を
誤って記述する経路が新たに生じる。PMO は実装差分を自ら書いたわけではない、または指示文に従って
記入するため、以下が具体的に起こり得る。

- 実際の diff にはない変更を記述する、または実際の diff にある変更を書き漏らす。
- 実際には FAIL している `policy / pr-policy` を `success` と記述する、またはその逆を記述する。
- 指示文自体に誤りがあった場合、それを検証せずそのまま PR 本文へ反映してしまう。
- `## Known Limitations` に記載すべき制約や逸脱を、記入者が実装の当事者でないために見落とす。

**緩和策:** 記入内容は「差分・CI 結果・Overall Lead の検証」という確認済みの事実に限定する。推測・
見込み・未検証事項を事実として PR 本文へ書かない。

---

## 6. R-5. 解除条件

- 実装 AI が自力で Template 準拠の PR 本文を作成・更新できる環境が整った場合、本改訂を解除し、
  原則である「実装者が自ら記入する」方式へ戻すことができる。解除は自動的には行われない。
- 解除の判断を行うのは Human Project Owner である。

---

## 7. R-6. SOL Independent Review 欄の記入責任

記入責任者については決定済みの事項として、それ以外の制約については未解決のまま記録する。新しい
判断をここで作らない。

### 7.1 決定済み事項（2026-08-13 / Human Project Owner 決定）

- 原則として、SOL Independent Review 結果は GPT SOL 自身が PR 本文の `## SOL Independent Review`
  欄へ記入する。
- GPT SOL は実行環境上、PR コメントを直接投稿できない。この制約に基づき、レビュー本体は
  Human Project Owner が GPT SOL の出力を PR コメントへ転記する。この Human Project Owner による
  転記を正規経路とする。
- 例外として、必要な場合に限り、Human Project Owner の明示的な許可を得たうえで PMO
  （Claude Code Sonnet）が `## SOL Independent Review` 欄へ転記してよい。PMO が自らの判断で
  同欄へ記入してはならない。
- この決定は GitHub Cloud Development Foundation v0.3 §20.1 の権限表「PR metadata 管理:
  SOL = Review 欄」と整合する。新たな役割変更ではなく、v0.3 が定めた原則の確認である。

### 7.2 記入実績（決定より前の運用）

以下 3 例はいずれも上記 7.1 の決定（2026-08-13）より前の運用であり、実施時点ではいずれも原則からの
逸脱として記録する。2026-08-13 の Q-3 決定により Human Project Owner による転記は決定後の正規経路と
なったが、以下の過去実績を遡及的に正規経路へ再分類しない。決定の前後で位置づけが変わった事実として
記録する。

1. **PR #7** — Human Project Owner が SOL Independent Review 結果を転記した。
2. **PR #10** — Human Project Owner が SOL Independent Review 結果を転記した。この事実は
   2026-08-13 に Overall Lead が Human Project Owner へ確認した。
3. **PR #12** — GPT SOL が実施した再レビュー結果を PMO が PR 本文へ転記した。PR #7 / #10 の
   Human Project Owner による転記とは異なる運用だった。Human Project Owner は、転記者が PMO で
   あることと、GPT SOL の再レビュー自体は実施されたことを確認した。一方、GPT SOL のレビュー本文
   そのものは GitHub 上に存在せず、PR 本文に残ったのは PMO による要約である。

### 7.3 Current State（実測結果）と未解決のまま残る事項

**実測結果:**

- 2026-08-13、PR #14 HEAD `75bc1f0bffe82d375420fab517ec2134fb76091d` に対する SOL Independent
  Review において、GPT SOL が専用 GitHub integration 経由で PR 本文の `## SOL Independent Review`
  欄を直接更新することに成功した。PR metadata / Review 欄への write capability は実測済みである。
- GPT SOL は実行環境上、PR コメントを直接投稿できない。この制約は実測済みであり、PR 本文の
  Review 欄への write capability とは別に扱う。
- 同じ PR #14 HEAD に対する `CHANGES_REQUIRED` / `MUST FIX 2` のレビューでは、PR 本文に判定と
  件数のみが記録され、指摘 2 件の内容は PR コメント、review threads、reviews、Issue #11 コメントを
  含む GitHub 上のどこにも存在しなかった。これは、レビュー本体が GitHub native な記録として
  残らない制約の実害である。

**未解決のまま残る事項:**

以下は本文書によって解決されるものではない。解決策・推奨案・暫定解・自動化案・新しい承認フローを
ここで定義しない。

- v0.3 §14.3 のとおり、PR 本文の記述だけでは、同欄を記入した actor が本当に SOL であることを
  完全には証明できない。ADR 0001 のとおり本 Repository の AI identity は Human Project Owner と
  同一の `Panda4th` に統合されており、SOL 専用の GitHub App または reviewer identity が用意される
  まで、この限界は残る。
- SOL は経路を問わず PR コメントを直接投稿できないため、`## SOL Independent Review` 欄に記録される
  判定サマリ（decision / BLOCKER 数 / MUST FIX 数）を超えるレビュー本体は、Human Project Owner の
  手動転記によってのみ GitHub へ記録される。この制約は PMO 転記の例外パス使用時に限定されず、
  現行の実行環境では恒久的に成立する。Human Project Owner による転記が行われなければ、PR #14 で
  観測されたとおりレビュー本体の GitHub native な記録は残らない。

未解決であり、今後 Human Project Owner の判断および integration の整備が必要な状態である。本 Issue
では identity 分離の解決策を確定しない。

---

## 8. R-7. Required Status Checks と Merge 阻止の関係

main branch の Required Status Checks は Human Project Owner により登録済みである。

- 「Require status checks to pass before merging」は有効。
- 必須 status checks は `pr-policy`（GitHub Actions）と `validation`（GitHub Actions）の 2 件。
- 「Require branches to be up to date before merging」は無効である。base branch が最新でない状態
  でも Merge は可能であり、branch の最新性は gate が保証していない。この点は保証されているかの
  ように記述しない。

### 実測（PR #12, HEAD `97ecc06bb9489e4715f00be04a75570b37b2579b`）

Human Project Owner の判断により、`## Integration Decision` 欄（`Opus decision:` / `Decision HEAD:`）
が未記入の状態で Ready for Review へ切り替え、Merge Ready Mode を意図的に FAIL させた。

| run | event | mode | conclusion |
|---|---|---|---|
| `31705884135` | `ready_for_review` | Merge Ready Mode | `failure` |
| `31706080217` | `edited`（Integration Decision 記入後） | Merge Ready Mode | `success` |

この FAIL 時に `mergeable_state` は `clean` から `blocked` へ変化し、GitHub 上で Merge が実際に
阻止された。その後 `## Integration Decision` を記入すると run `31706080217` は `success` となり、
`mergeable_state` は `blocked` から `clean` へ復帰した。両 run は Overall Lead が GitHub Actions の
実行結果として照合済みである。

したがって現在は、`policy / pr-policy` が Required Status Check として FAIL した場合、その FAIL が
Merge を実際に阻止する、という実測済みの事実として記載する。

### 過大に表現してはならない点

- Branch Protection や Required Status Checks を変更可能な admin identity の残存リスクは解決されて
  いない（[`docs/governance/merge-authority.md`](./merge-authority.md) §3 参照）。
- 「Require branches to be up to date before merging」が無効であることにより生じる、base branch
  非最新状態での Merge 可能性は、本改訂によって解決していない。
- 本改訂によって解決していない問題を、解決したかのように書かない。

---

## 9. 本文書の見直し条件

- §6 に定める解除条件が成立した場合。
- §7.3 に列挙した未解決事項について、Human Project Owner が新たな決定を行った場合。
