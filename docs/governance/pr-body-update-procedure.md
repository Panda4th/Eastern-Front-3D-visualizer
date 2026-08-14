# PR Body Update Procedure

**Status:** Active
**Adopted:** 2026-08-14
**Decided by:** Human Project Owner
**Upstream:** Project Foundation v0.1 / GitHub Cloud Development Foundation v0.3
**Related:** [Merge Authority Policy](./merge-authority.md) / [Review Field Authoring Policy](./review-field-authoring.md)（本文書は Merge 権限および記入責任を変更しない）

---

## 1. なぜこの文書が必要か

2026-08-14、PR #17 において、Overall Lead（Claude Code Opus）が PR 本文を全置換した際に、直前に
GPT SOL が記入した `## SOL Independent Review` 欄を上書き消去した。

この事象と再発防止手順は PR #17 のコメントとしてのみ存在しており、PR #17 は既に MERGED
（2026-08-14T03:54:59Z）である。[Review Field Authoring Policy](./review-field-authoring.md) §1 が
closed 済みの Issue #1 について記録したのと同じ参照性の問題が生じる。本文書は、その内容を
`docs/governance/` 配下の恒久的な参照場所として記録するものである。

本文書の基礎は、PR #17 上で既に確定し実行された再発防止手順である。これに加えて、PR #22 に対する
SOL Independent Review の指摘により、適用対象主体の明確化（§4）、`## Integration Decision` 欄の
委譲例外の明記（§5）、および復元可能性に関する記述の事実範囲への限定（§6）を行っている。

本文書は、新しい Merge 権限・write 権限・記入責任・承認フローのいずれも定義しない。既存の正本文書が
定める権限を確認し、その運用手順を記録するものである。

出典: https://github.com/Panda4th/Eastern-Front-3D-visualizer/pull/17#issuecomment-5289217541

---

## 2. R-1. 事象記録（PR #17 / 2026-08-14）

PR HEAD は全経過を通じて `9854f611aa4fbb0d2f49aa2e859b9903318670bd` から変更されていない。

| 時刻 (UTC) | 事象 |
|---|---|
| 03:43 頃 | Overall Lead が PR 本文を取得。この時点で `## SOL Independent Review` 欄は空。 |
| 03:44:03 | GPT SOL が `## SOL Independent Review` 欄を記入。 |
| 03:44:05 | `pr-policy` run `31767683438`。error は `Opus decision` / `Decision HEAD` の 2 件のみ。SOL 欄 5 項目はすべて判定を通過していた。 |
| 03:47:15 | Overall Lead が 03:43 時点のスナップショットで本文を全置換し、`## Integration Decision` 欄を記入。この置換により SOL 欄が消去された。 |
| 03:47:21 | `pr-policy` run `31767849765`。error は SOL 欄 5 件のみ。 |

### 影響

- 失われたのは `## SOL Independent Review` 欄のみである。本文の他の箇所は 03:43 時点と同一だった。
- PR HEAD が変更されていないため、GPT SOL の PASS 判定および Overall Lead の Integration Decision は
  いずれも失効していない。
- `validation` は success（run `31767010432`）を維持した。
- `pr-policy` は SOL 欄未記入により failure となり、`mergeable_state` は `blocked` だった。Required
  Status Check は Merge を実際に阻止しており、この点は設計どおり機能した。

### 復旧

[Merge Authority Policy](./merge-authority.md) §2.6 および
[Review Field Authoring Policy](./review-field-authoring.md) §7.1 により、`## SOL Independent Review`
欄の記入者は GPT SOL 本人、または Human Project Owner による転記に限られる。Overall Lead が消去した
という事情は、Overall Lead に同欄の記入権限を与える理由にならない。したがって Overall Lead は同欄を
書き直さず、GPT SOL へ再記入を依頼した。

GPT SOL が同欄へ記入していた散文部分は、復旧作業の時点で復元されなかった。Overall Lead は 03:44 版の
本文を保持しておらず、当時使用した REST ベースの経路では PR 本文の編集履歴を取得できなかった。これは
当時の経路における実測事実であり、GitHub 全体で当該履歴が失われたことを意味しない（§6 参照）。

判定値については、run `31767683438` のログから以下 5 項目が判定を通過していた事実が確定している。

```text
SOL review commit: 9854f611aa4fbb0d2f49aa2e859b9903318670bd
SOL review decision: PASS
BLOCKER: 0
MUST FIX: 0
Current HEAD: 9854f611aa4fbb0d2f49aa2e859b9903318670bd
```

---

## 3. R-2. 原因

- GitHub の PR 本文更新は本文全体の置換であり、部分更新ではない。したがって更新は必ず
  read-modify-write となる。
- GitHub REST API は PR 本文に対する条件付き更新（楽観ロック）を提供しない。書き込み時に「読み取った
  本文が最新であること」を API 側が保証しない。
- 置換直前に PR HEAD SHA は再確認されていた。しかし HEAD SHA は commit の状態を表すものであり、本文の
  版を表さない。本文のみが他 actor によって更新された場合、HEAD SHA は変化しない。したがって
  **HEAD SHA の一致確認では本文の競合を検出できない。** 本件はこの事実の実測例である。
- [Review Field Authoring Policy](./review-field-authoring.md) §3.3 が PMO へ課している「置換直前に
  再確認する」を、Overall Lead 自身が満たしていなかった。

---

## 4. R-3. 手順

本手順は、既存の正本文書によって PR 本文への更新権限を持つ**すべての主体**に適用する。現時点では
Overall Lead（Claude Code Opus）、PMO（Claude Code Sonnet）、GPT SOL、および Human Project Owner が
これにあたる。GPT SOL による PR 本文の直接更新は
[Review Field Authoring Policy](./review-field-authoring.md) §7.1・§7.3 に正規経路かつ実測済みの
capability として記録されており、同じ read-modify-write 競合が発生し得る。

本手順は、既存の正本文書が定める write 権限および各欄の記入権限を変更しない。本文書によって新しい
更新権限または記入権限を、いずれの主体へも付与しない。付与されていない欄への記入は、本手順を満たした
場合であっても許されない。

対象主体は、以下をすべて満たす。

1. **書き込み直前に PR 本文を再取得する。** HEAD SHA の確認は本文再取得の代替とならない。両方を行う。
2. **再取得した本文を基点として編集し、取得直後に書き込む。** 取得と書き込みの間に他の GitHub 操作を
   挟まない。過去に取得したスナップショットを基点として全置換しない。
3. **再取得した本文に、自身が記入権限を持たない欄の記入が存在する場合、その内容をそのまま保持する。**
   自身の担当外の欄を、空欄化・要約・書き換えのいずれの形でも変更しない。
4. **他 actor による記入待ちであることが判明している間は、当該 PR 本文へ書き込まない。**

---

## 5. R-4. 変更していない点

以下は本文書の対象外であり、変更していない。

- `## SOL Independent Review` 欄の記入者は GPT SOL 本人、または Human Project Owner による転記である
  （[Review Field Authoring Policy](./review-field-authoring.md) §7.1）。PMO は Human Project Owner の
  明示的な許可がある場合の例外に限る。
- `## Integration Decision` 欄の記入者は Claude Code Opus である
  （[Merge Authority Policy](./merge-authority.md) §2.6）。ただし同 §2.6 は自己承認を禁じており、
  Claude Code Opus が当該 PR の実装担当を兼ねる場合、Opus は同欄へ承認判断を記入しない。その事実を
  PR 本文へ明記したうえで、同欄の判断を Human Project Owner へ委譲する。同様に、実装を担当した AI は
  `## SOL Independent Review` 欄の判断者ともならない。
- 誤って欄を消去した事実は、消去した actor に当該欄の記入権限を与えない。
- 最終 Merge は Human Project Owner のみが行う。
- Project Foundation v0.1 / GitHub Cloud Development Foundation v0.3 を変更していない。

---

## 6. R-5. 本手順で解決しない点

利点のみを記載しない。以下は本手順によって解決していない。

- **上書きされた本文が復元されるとは限らない。** PR #17 では、Overall Lead が 03:44 版の本文を保持
  しておらず、当時使用した REST ベースの経路では PR 本文の編集履歴を取得できなかった。結果として
  復旧時に確定できたのは、`pr-policy` run `31767683438` のログから読み取れる判定値 5 項目のみであり、
  GPT SOL の散文部分は復元されなかった。

  ここで確定している事実は「当時使用した経路では復元されなかった」ことに限られる。GitHub GraphQL の
  `PullRequest.userContentEdits`（`UserContentEdit` に `diff` / `editor` / `editedAt` を持つ）は本件で
  試行しておらず、同 API により編集履歴を取得できる可能性は否定されていない。2026-08-14 時点で、本
  Repository の作業に用いている実行環境からは GraphQL endpoint への任意クエリが proxy により拒否され
  （HTTP 403）、この経路での確認を実施できていない。**したがって「復元不能」を確定事実として扱わない。**
  上書きが発生した場合は、まず GitHub UI の編集履歴表示または GraphQL `userContentEdits` による復元
  可能性を確認し、その実測結果を記録する。
- **本手順は運用規律であり、技術的に強制されない。** GitHub 側に条件付き更新が存在しない以上、競合の
  検出は書き込み主体の手続きにのみ依存する。手順を守らなかった場合を検出する gate はない。
- **同時編集そのものを防止しない。** 本手順が縮小するのは、取得から書き込みまでの時間差に起因する
  意図しない消去である。書き込みが厳密に同時であった場合の競合は残る。
- **消去した actor を GitHub の記録から特定できない限界は残る。** ADR 0001 のとおり本 Repository の
  AI identity は Human Project Owner と同一の `Panda4th` に統合されており、記入・消去はいずれも同一
  actor の操作として記録される（[Review Field Authoring Policy](./review-field-authoring.md) §7.3）。
  本文書のような事後記録によってのみ操作の内訳が補われる。

---

## 7. 本文書の見直し条件

- GitHub API が PR 本文に対する条件付き更新（楽観ロック）を提供するようになった場合。
- AI identity 分離が実現し、PR 本文の更新 actor を GitHub 上で区別できるようになった場合
  （[ADR 0001](../decisions/0001-identity-separation-option-c.md) /
  [Merge Authority Policy](./merge-authority.md) §5）。
- 見直しの判断を行うのは Human Project Owner である。本文書を無記録で書き換えてはならない。
