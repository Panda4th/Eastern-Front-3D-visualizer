# Merge Authority Policy

**Status:** Active
**Adopted:** 2026-08-12
**Decided by:** Human Project Owner
**Upstream:** Project Foundation v0.1 / GitHub Cloud Development Foundation v0.3
**Related decision:** [0001 — Identity Separation: Option C](../decisions/0001-identity-separation-option-c.md)

---

## 1. なぜこの文書が必要か

GitHub Cloud Development Foundation v0.3 §11.3 は、`main` への更新権限を Human Project Owner に限定することで Human-only Merge を成立させる設計である。

しかし本 Repository では、AI（Claude / Codex）が GitHub API 上で使用する actor が **Human Project Owner 本人のアカウント（admin 権限）と同一**である。

このため、

```text
「Merge を実行したのが Human か AI か」
```

を GitHub の記録から技術的に区別できない。

Human Project Owner の判断により、この状態を受け入れたうえで、**技術ガードレールと明文規則の組み合わせ**によって Human-only Merge を担保する方式（Option C）を採用した。

本文書はその明文規則にあたる。

---

## 2. 規則

### 2.1 Merge の実行

**いかなる AI も、いかなる場合も、Pull Request を Merge してはならない。**

以下をすべて含む。

- Merge / Squash Merge / Rebase Merge の実行
- Auto Merge の有効化
- Merge Queue への追加
- Branch Protection を迂回した `main` の更新

Merge を実行してよいのは **Human Project Owner のみ**とする。

### 2.2 `main` への直接 push

**いかなる AI も `main` へ直接 push してはならない。**

`main` の更新は Pull Request 経由に限る。

### 2.3 Branch Protection

**いかなる AI も Branch Protection 設定を変更・削除・迂回してはならない。**

設定変更は Human Project Owner の専管事項とする。

### 2.4 Repository 設定 / Secrets

**いかなる AI も以下を変更してはならない。**

- Repository の visibility
- Merge 方式設定
- Actions 権限設定
- Security 機能設定
- Secrets

### 2.5 Credential

**いかなる AI も、新規の credential（Personal Access Token / GitHub App / service account 等）を作成してはならない。**

必要が生じた場合は作業を停止し、Human Project Owner へ判断を求める。

### 2.6 自己承認の禁止

実装を担当した AI は、その実装に対する承認判断を行ってはならない。

- Codex は自身の PR を承認してはならない。
- Pull Request の `## SOL Independent Review` 欄には、GPT SOL による実レビュー結果のみを記録する。
- Pull Request の `## Integration Decision` 欄には、Claude Opus による実統括判断のみを記録する。
- 実装を担当した AI が上記いずれかの欄の記入者となる場合、その事実を Pull Request 本文へ明記し、当該欄の判断を Human Project Owner へ委譲する。

---

## 3. 技術ガードレール

本規則は、以下の技術的措置によって補強される。ただし技術的措置は規則を**代替しない**。

| 措置 | 防げること |
|---|---|
| Branch Protection: Require a pull request | `main` への直接 push |
| Branch Protection: Do not allow bypassing | admin による上記の迂回 |
| Branch Protection: Allow force pushes = OFF | `main` の履歴改変 |
| Branch Protection: Allow deletions = OFF | `main` の削除 |
| Required Status Checks | CI 失敗状態での Merge |
| Trusted Policy Gate | SOL Review 未完・Opus 判断未完での Merge |
| Trusted Policy Gate: HEAD SHA 照合 | 古い commit に対するレビュー結果での Merge |

### 防げないこと

**全条件を満たした Pull Request の Merge ボタンを押した actor を区別すること。**

これが Option C における唯一の残存リスクであり、本文書の規則によってのみ担保される。

---

## 4. Merge 前チェックリスト

Human Project Owner は、以下がすべて成立していることを確認したうえで Squash Merge を実行する。

```text
Required Checks          = PASS
SOL review decision      = PASS
SOL review commit        = Current PR HEAD SHA
BLOCKER                  = 0
MUST FIX                 = 0
Opus decision            = APPROVE
Decision HEAD            = Current PR HEAD SHA
Conversation Resolution  = 完了
```

Human Project Owner がコードを読んで技術的正当性を自力で判定することは、Merge の条件としない。

技術的正当性は以下によって担保する。

```text
実装 AI の Tests
+
GitHub Actions
+
GPT SOL Independent Review
```

---

## 5. 本規則の見直し条件

以下のいずれかが成立した場合、本規則および Option C を再評価する。

- 実装 AI 専用の machine account を用意できるようになった。
- GitHub Free Organization を導入し、role による権限分離が可能になった。
- AI integration が Human Project Owner とは異なる identity で動作するようになった。

再評価の結果は `docs/decisions/` へ新しい decision record として記録する。本文書を無記録で書き換えてはならない。
