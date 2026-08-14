# AI Runtime Entry

本ファイルは、このRepositoryで作業するAI向けの非正本Runtime Entryであり、Governance正本ではない。
Instructionファイルは権限を技術的に強制するものではない。

## [COMMON]

### 正本・基準文書

各文書は定義された適用領域で使用し、正本文書間に新しい一律の優先順位を設けない。

- `README.md` — Project baselineへの索引。
- `docs/foundation/project-foundation_v0.1.md` — Historical Accuracy、Traceability、上位Project原則。
- `docs/architecture/github-cloud-development-foundation_v0.3.md` — Architecture Baseline。
- `docs/governance/ai-role-and-communication-policy.md` — AI役割、Current State取得責任、transport、出力・連携ルール。v0.3後続運用差分は§14を参照する。
- `docs/governance/merge-authority.md` — Merge authorityおよび実装担当AIの自己承認禁止。
- `docs/governance/review-field-authoring.md` — Review記録と各欄の記入責任。
- `docs/decisions/0001-identity-separation-option-c.md` — Identity Separationに関する決定。

### 共通原則

- 最終Mergeを実行できるのはHuman Project Ownerのみである。
- AIはMergeせず、Auto Mergeを有効化せず、`main`へ直接pushしない。
- AIはBranch Protectionを変更、削除または迂回しない。
- 実装担当AIは自身の実装をIndependent Reviewで自己承認しない。
- Project Foundationが定めるHistorical AccuracyおよびTraceabilityを弱めない。
- Projectの日本語出力原則はAI Role and Communication Policyを参照する。
- AI間またはMasterとの正式な指示・報告を独立コードブロックとする原則は同Policyを参照する。

### Conflict処理

- 本Entry Pointと正本が矛盾する場合は、該当適用領域の正本を使用し、Entry Point側の不整合を報告する。
- その矛盾が権限、Scope、Merge条件またはHistorical Dataの正確性に影響する場合は作業を停止する。
- AIはEntry Pointまたは正本を独断で書き換えない。
- 正本文書同士が矛盾する場合は、AI独自の優先順位で解決せず作業を停止し、Human Project OwnerまたはOverall Leadへ報告する。

Runtime verification marker（非規範）: `EF3D-AGENTS-CONTEXT-CHECK`

このマーカーはRuntimeでの内容反映確認専用であり、権限、役割またはScopeを定義しない。

## [CODEX ONLY]

- Codexの現行役割は`docs/governance/ai-role-and-communication-policy.md` §4を正本とする。
- Codexは、自己完結型指示に封入されたcontextおよびCurrent Stateを使用する。
- 初稿著述・初回実装のために、Codex自身へGitHub Current State探索を要求しない。
- 本ファイルに正本文書pathがあることを理由に、GitHub上での探索的読込を作業前提としてCodexへ要求しない。
- 必要なIssue、Pull Request、Branch、HEADまたはCI等が不足もしくは矛盾する場合は停止して報告する。
- Codexは自己完結型指示のScopeを自主的に拡張しない。
- transport、既存Pull Requestの継続修正、CIまたはworkflow run確認をCodexの通常責任として再定義しない。

## [CLAUDE CODE ONLY]

- Claude Code固有のRuntime Instructionは`CLAUDE.md`を参照する。
- [CODEX ONLY]節をClaude Code自身へ適用しない。
