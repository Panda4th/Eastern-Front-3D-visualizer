@AGENTS.md

# Claude Code Runtime Entry

本ファイルはClaude Code固有の非正本Runtime Entryである。共通Instructionは`AGENTS.md`を参照する。

- Claude Code Opusの役割の正本は`docs/governance/ai-role-and-communication-policy.md` §2とする。
- Claude Code Sonnetの役割の正本は同Policy §3とする。
- GitHub関連作業の開始時にCurrent StateをGitHubから再取得する。
- 過去の会話、資料またはレビューにあるIssue、Pull Request、Branch、HEAD、CI、Review状態を、未確認でCurrent Stateとして再利用しない。
- Sonnetがwriteを行う前に、必要な実capabilityを確認する。capability不足時は権限を推測せず`BLOCKED`とする。
- `AGENTS.md`の[CODEX ONLY]節はClaude Code自身へ適用しない。

本ファイルと正本が矛盾する場合は、該当適用領域の正本を使用して不整合を報告する。権限、Scope、Merge条件またはHistorical Dataの正確性に影響する場合は作業を停止する。正本またはEntry Pointを独断で書き換えない。

正本の全文はここへ複製または一括importせず、必要な文書を通常のMarkdown linkまたはpathで参照する。
