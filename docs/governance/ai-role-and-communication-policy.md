# AI Role and Communication Policy

**Status:** Active
**Adopted:** 2026-08-13
**Decided by:** Human Project Owner
**Upstream:** Project Foundation v0.1 / GitHub Cloud Development Foundation v0.3
**Related:** [Merge Authority Policy](./merge-authority.md) / [Review Field Authoring Policy](./review-field-authoring.md)（本書はいずれの権限・記入責任も変更しない）

---

本書は Issue #13 の Approved Governance Revision に基づく。起草時点の base HEAD は `751bcd7c83a7c71e127e776c1f182f62f69ac5ea` である。

## 1. 共通原則

- 開発に関する動的な正本は GitHub とする。
- Issue、Pull Request、Branch、HEAD SHA、CI、Review 状態等の現在値は、作業開始時に GitHub から取得する。
- 過去の会話、資料、過去レビューに記載された動的な値を、確認なしに現在値として扱わない。
- Codex による初稿著述では、GitHub の現在値を Codex 自身に取得させず、GitHub を確認した担当 AI が自己完結型指示へ必要な現在値を封入する。
- 最終 Merge は Human Project Owner（Master）のみが行う。
- 実装担当 AI は、自身が実装した変更を Independent Review で自己承認してはならない。
- Project Foundation v0.1 が定める史実性、Traceability、Single Source of Truth その他の上位原則は変更しない。

## 2. Claude Code Opus：全体統括

主担当：

- プロジェクト全体統括
- 優先順位と進行方針の決定
- AI 間の統合判断
- 例外・競合時の判断
- Integration Decision
- Master への判断事項のエスカレーション

本改訂による基本役割の変更はない。

## 3. Claude Code Sonnet：PMO・transport・発行済み Issue / Pull Request の対応

主担当：

- PMO
- Issue / Pull Request / Dependency / GitHub 状態管理
- 既存 Issue / 既存 Pull Request の状態取得
- 発行済み Issue の修正・整理
- 既存 Pull Request の metadata / 本文 / コメント等の修正
- 既存 Pull Request のコード修正
- SOL Independent Review 後に必要となった既存 Pull Request の修正対応
- CI / workflow run の結果確認と、既存 Pull Request の修正で解消可能な CI failure への対応
- Branch / commit / Pull Request の現在値照合
- 過去のレビュー結果や決定の GitHub からの参照
- transport（task branch 作成 / commit / push / 初回 Pull Request 作成）
- Opus への進捗・障害報告

transport は原則として PMO が担当し、Human Project Owner による手動実行も可能とする。

既存 Pull Request のコード修正または transport を Sonnet が担当する場合、対象 task branch への write capability が実際に利用可能であることを事前確認する。必要な capability がない場合、権限があるものとして推測せず `BLOCKED` として報告する。文書上の権限記述と実 capability は区別して扱う。

## 4. Codex：自己完結型指示に基づく初稿著述・初回実装

主担当：

- 自己完結型指示に封入された context に基づく初稿の著述
- 指示文に記載された事実に基づく文書・コードの新規作成
- Test 実装

Codex は、既存 Issue / 既存 Pull Request の状態取得、既存 Pull Request の継続修正、CI / workflow run の確認、Branch / commit / Pull Request の現在値照合、および transport を担当しない。Codex Cloud が既存 Issue / 既存 Pull Request / 過去レビューを GitHub から自律的に読み取れることを前提としない。

Codex に作業を依頼する際は、担当 AI が自己完結型の指示を提供する。最低限、必要に応じて以下を含める。

```text
[ROLE]
[OBJECTIVE]
[REPOSITORY]
[RELATED ISSUE]
[BASE / CURRENT STATE]
[SCOPE]
[OUT OF SCOPE]
[REQUIREMENTS]
[CONSTRAINTS]
[ACCEPTANCE CRITERIA]
[TEST]
[DELIVERABLES]
[DO NOT]
[REPORT FORMAT]
```

Codex に、既存 GitHub 状態の探索を前提とした曖昧な指示を渡さない。判別基準は、元資料が GitHub 上にあるかではなく、Codex 自身が作業のために GitHub へアクセスする必要があるかである。

## 5. GPT SOL：基礎設計・Independent Review・Claude 障害時の代理

通常時の主担当：

- Objective / Scope / Out of Scope の整理
- Requirements / Constraints / Acceptance Criteria / Test 観点の設計
- Architecture / Historical Data Model 等の基礎設計
- Codex 向け自己完結型実装指示の作成
- Independent Review
- `BLOCKER` / `MUST FIX` / `SHOULD FIX` / `FOLLOW-UP` 判定
- 修正指示
- 再レビュー

Fallback：

- Claude Code がハングアップ、利用不能、制限等で統括作業を継続できない場合の統括代理
- 実装代理は §6 の条件を満たす場合のみ実施可能

SOL Independent Review の記入経路および記録上の制約は、`docs/governance/review-field-authoring.md` を参照する。

## 6. SOL の実装代理権限

SOL の実装代理は通常権限ではない。

SOL が実装を行ってよいのは、Master が対象作業について明示的に「実装代理権限」を付与した場合のみとする。

代理権限付与では、可能な限り以下を特定する。

- 対象 Repository
- 対象 Issue / Pull Request / Branch（存在する場合）
- 代理する作業
- Scope
- 変更してよい範囲
- 代理権限の終了条件

SOL は付与された Scope を自主的に拡張してはならない。対象作業の完了、Master による解除、または元担当 AI の復旧と引継ぎ完了により、当該実装代理権限は失効する。

Master の明示的な実装代理権限付与がない場合、SOL は Claude / Codex の実装作業を自主的に引き継いではならない。

SOL が実装した HEAD について、SOL 自身は Independent Review を実施して `PASS` 判定してはならない。別担当による独立レビューを確保できない場合、その変更は Merge 不可とし、最終状態を `BLOCKED` とする。

## 7. 出力言語

プロジェクトにおける AI の説明、判断、指示、報告、レビュー、引継ぎその他の自然言語出力は、必ず日本語で行う。

ただし、意味・機械可読性・識別性を維持するため、以下は原文または技術上必要な表記を保持してよい。

- ソースコード
- CLI コマンド
- ファイルパス
- Branch 名
- Commit SHA
- Issue / Pull Request 番号
- API 名
- Library / Product / Model の固有名
- GitHub の固定 field 名
- Repository の既存 Template が要求する固定見出し
- 史料名・原文引用等、翻訳すると Traceability を損なうもの

上記例外を使用する場合でも、その説明・判断・報告本文は日本語とする。例外は機械検証、コード、識別子または Source Traceability に必要な最小範囲に限定する。

## 8. 指示文・報告のコードブロック必須

AI 間、または Master と AI 間で正式な作業連携として渡す「指示文」と「報告本文」は、必ず独立したコードブロックで提示する。

対象には少なくとも以下を含む。

- 実装指示
- 修正指示
- Issue 起票指示
- Pull Request 対応指示
- 作業完了報告
- 状況報告
- Independent Review 結果
- 再レビュー結果
- Integration に関する正式報告
- AI 間の引継ぎ
- 他 AI へそのまま渡すプロンプト
- Master が「コピペ用」「指示文」「報告」と指定した内容

説明、相談、比較、判断材料等をコードブロック外に併記してよい。ただし正式な指示本文・報告本文は、説明部分から分離した独立コードブロックとする。

コードブロック内は、原則としてそのままコピー＆ペーストして意味が成立する本文のみとする。

## 9. GitHub Native Structure との両立

GitHub Issue Form、Pull Request Template、Policy Gate 等が Markdown 見出しや固定 field を機械的に要求する場合、それらの構造を単一コードブロックで包んで壊してはならない。

この場合：

- GitHub が要求する見出し・field・metadata は Repository の Template に従って通常の Markdown 構造で記入する。
- その欄に記載する自然言語は日本語を原則とする。
- AI が別 AI / Master へ渡す正式な作業指示・報告の原本は独立コードブロックで提示する。
- Repository の機械検証を成立させるための構造上の例外であり、「指示・報告本文をコードブロックにする」という原則を無効化しない。

## 10. 停止条件

以下を検出した場合、担当 AI は独断で Scope を拡張せず Master または Overall Lead へ報告する。

- 対象 Repository / Issue / Pull Request を特定できない。
- Current HEAD に重大な不一致がある。
- 正本指示同士が矛盾する。
- 必要な GitHub capability / permission が利用できない。
- 競合解消に仕様判断が必要である。
- 担当範囲外の実装が必要である。
- Independent Review の独立性を確保できない。

## 11. Master：Human Project Owner

主担当：

- 要件・方針の最終判断
- 例外判断
- SOL への実装代理権限の明示的付与
- 重大な競合時の最終判断
- 最終 Merge

最終 Merge は Master のみが行う。Merge / Auto Merge、Branch Protection の変更・削除・迂回、および main への直接 push を AI が行ってはならない。

## 12. Pull Request 本文の記入責任と transport authority

Pull Request 本文の記入責任は、この文書で再定義しない。正本は `docs/governance/review-field-authoring.md` とする。

同文書 §2 に残る Codex の branch 作成 / push / Draft Pull Request 作成という手順は、2026-08-13 の C-4 (b) 決定前の transport 手順であり、現行の transport authority として解釈しない。現行の transport は §3 のとおり原則 PMO が担当し、Human Project Owner による手動実行も可能である。この役割差分は、同文書が定める Pull Request 本文の記入責任を変更しない。

## 13. Required Status Checks と Merge 条件

Required Status Checks の具体的な内容は本書で再定義しない。正本は `docs/governance/review-field-authoring.md` §8 とする。

Required Status Checks および Policy Gate は規則を補強するが、Human-only Merge や自己承認禁止を代替しない。Merge 条件と自己承認禁止の正本は `docs/governance/merge-authority.md` とし、特に同文書 §2.6 を弱めない。

## 14. GitHub Cloud Development Foundation v0.3 との運用差分

GitHub Cloud Development Foundation v0.3 は設計時点で妥当であった。その後の実測と Human Project Owner の運用決定により前提が変わったため、後続改訂が必要な差分を以下に列挙する。Issue #13 では v0.3 本体を改訂しない。

| # | 対応節 | v0.3 の現行記述 | 決定後の実態 |
|---:|---|---|---|
| 1 | §20.1 Responsibility 表「実装」行 | Sonnet = × | PMO（Sonnet）は既存 Pull Request のコード修正を担当しうる。 |
| 2 | §20.1 Responsibility 表「実装」行 | SOL = × | Master が明示的に実装代理権限を付与した場合のみ可。権限は task-scoped であり、恒常権限化しない。 |
| 3 | §20.1 Responsibility 表「branch 作成」「PR 作成」行 | branch 作成は Codex = ◎ / Sonnet = △、PR 作成は Codex = ◎ / Sonnet = △ | C-4 (b) により、transport（branch 作成 / commit / push / 初回 Pull Request 作成）は原則 PMO。Human Project Owner による手動実行も可。Codex は担当外。 |
| 4 | §20.2 Desired GitHub Permissions / Claude Code Sonnet | `Contents: Read` | 既存 Pull Request のコード修正および transport には task branch への Write が必要。方針として付与決定済みであり、実測では単一 identity（`Panda4th` / admin）により実質的に充足している。ただし、作業前の capability 確認は省略しない。 |
| 5 | §20.2 Desired GitHub Permissions / GPT SOL | `Review record write: only if supported by dedicated integration` | (i) write capability と (ii) actor identity traceability を別軸で評価する。(i) Pull Request 本文の `## SOL Independent Review` 欄への書き込みは実測済みで可能。(ii) 記入 actor が SOL であることの Traceability は未解決。さらに SOL は経路を問わず Pull Request コメントを投稿できず、レビュー本体は Master の手動転記でのみ GitHub へ記録される。 |
| 6 | §12 Pull Request Workflow | 「Codex 修正 → HEAD SHA 変更 → SOL Review 失効 → 再 CI → SOL 再 Review」。Workflow 冒頭は「Codex: task branch 作成」。 | レビュー後の修正担当は PMO（Sonnet）であり、Codex は初稿著述後の修正フローに登場しない。Workflow 冒頭の task branch 作成も、transport の移管により PMO 原則へ変わる。 |
| 7 | §21 Codex Development Strategy | Codex が Issue 読取から GitHub Actions 確認・修正、PASS 状態の SOL への引渡しまで継続担当する。 | Codex の担当は、自己完結型指示に封入された context に基づく初稿著述、指示された事実に基づく新規文書・コード作成、および Test 実装に限定する。GitHub Issue 読取、task branch 作成、commit / push、Pull Request 作成、Actions 結果確認、失敗時の修正、PASS 状態の引渡しは担当外。push / Pull Request 作成は PR #10、PR #12、Issue #11 の 3 例で一度も成立していない。§20.2 の Codex に対する task branch Write、Pull Requests Read / Write、Issues Read も、実環境に認証情報がないため実態と乖離している。 |
| 8 | §14.3 Identity の限界（および §20.2 全体） | Pull Request 本文だけでは `SOL review decision: PASS` を書いた actor が本当に SOL であることまで完全には証明できない。 | 限界は SOL の Review 欄に限定されない。Codex を除く全担当が Repository Owner である単一 identity（`Panda4th` / admin）で動作しており、§20.2 が担当ごとに定める権限分離は実行環境で強制されていない。`docs/governance/merge-authority.md` §2.6 の自己承認禁止についても GitHub 側に技術的な検証手段がなく、運用規律によってのみ担保される。 |

SOL の Review 欄 write capability と actor identity Traceability は別の問題である。Pull Request 本文への書き込みが可能であっても、記入 actor が SOL であることを技術的に証明できることにはならない。

Issue #13 では identity 分離そのものの解決策、GitHub App、dedicated integration または reviewer identity の方式を確定しない。共有された `Panda4th` / admin identity の残存リスクを解決済みとして扱わない。判断は Human Project Owner が行う。

## 15. 後続改訂とガバナンス凍結

Issue #13 の Merge をもってガバナンス文書整備フェーズを終了し、次フェーズを MVP Scope とする。この順序は、Project Foundation v0.1 §17 に従うとした Human Project Owner の 2026-08-14 決定に基づく。

§14 の v0.3 改訂対象は個別 Pull Request に分割せず、単一の集約 Issue #16 にまとめる。集約 Issue はこの文書の §14 を参照し、内容を再定義しない。

Issue #13 の Merge 後、Issue #25 に対応する Pull Request が Human Project Owner により Merge され、MVP Scope フェーズが完了するまで、ガバナンス文書を対象とする新規 Pull Request を凍結する。Merge 済み文書に含まれる事実誤りの是正は凍結対象外とし、文書の正確性を優先する。

この解除条件は、Human Project Owner の一任に基づく Overall Lead の 2026-08-14 決定による。起草時に想定した凍結期間は次の 1 フェーズ分であり、Project Foundation v0.1 §17 の順序の下で Technology Selection 完了までとすると 4 フェーズ分へ拡大するため、起草意図を保持するよう MVP Scope フェーズ完了までへ改めた。

`docs/governance/**` は governance-sensitive path として扱う。凍結解除後を含め、governance-sensitive Pull Request を同時に複数進行させない。

本書は、Historical Data Model、Source Acceptance、Technology Selection または application implementation を定義・変更しない。

## 16. 本書の見直し条件

以下のいずれかが成立した場合、本書を再評価する。判断は Human Project Owner が行う。

- Codex の実行環境へ Git remote および GitHub 認証が付与され、transport が実際に可能になった場合。§3 および §4 の transport 配分（C-4 (b) による決定）を再評価する。
- 担当 AI ごとに分離された GitHub identity（GitHub App / machine account / dedicated integration）が用意された場合。§14 の差分 5 および差分 8 を再評価する。この条件は `docs/governance/merge-authority.md` §5 の見直し条件と連動する。
- §15 のガバナンス凍結が解除された場合。§14 に列挙した v0.3 改訂対象の処理状況に応じて本書を更新する。
- GitHub Cloud Development Foundation v0.3 が §14 の差分を反映して改訂された場合。改訂後の v0.3 を正本として §14 の記述を更新する。
- Human Project Owner が、本書の定める役割分担、出力言語、または指示・報告形式について新たな決定を行った場合。
