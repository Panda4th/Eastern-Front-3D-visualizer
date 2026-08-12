# 0001 — Identity Separation: Option C

**Status:** Accepted
**Date:** 2026-08-12
**Decided by:** Human Project Owner
**Proposed by:** Claude Code Opus (Overall Lead)
**Upstream:** GitHub Cloud Development Foundation v0.3 §5.3 / §11.3 / §14.3

---

## Context

GitHub 基盤構築の PRE-FLIGHT において、AI と Human Project Owner の identity 分離状況を検証した。

検証結果は以下。

| 項目 | 実測値 |
|---|---|
| Human Project Owner identity | `Panda4th` |
| Repository role | admin |
| Claude の GitHub actor | `Panda4th`（Human と同一） |
| Claude の repository role | admin（Human と同一） |
| Codex の GitHub actor | 未接続（接続時は同一になる見込み） |
| GPT SOL の GitHub identity | なし |
| 分離できているもの | commit の authorship のみ |
| 分離できていないもの | actor（GitHub 上で誰として操作したか） |

GitHub Cloud Development Foundation v0.3 §11.3 が想定する「`main` への push 可能 actor を Human に限定する」構成は、AI が Human と異なる identity を使用することを前提としている。

本 Repository ではその前提が成立しない。

さらに、本 Repository は個人アカウント所有であるため、Branch Protection の "Restrict who can push to matching branches"（Organization 所有 Repository 専用機能）を使用できない。

### 判定

**Identity Separation = FAIL**

「AI が Human Owner / Admin credential として動作し、Human-only Merge を実質保証できない」状態に該当する。

---

## 検討した選択肢

### Option A — 実装 AI 専用の machine account

Human が無料の GitHub アカウントをもう 1 つ作成し、Write 権限（Admin ではない）で招待する。

- 効果: 当該 AI については Human-only Merge を技術的に強制できる。
- 問題: 新規 credential 作成に該当し、AI 単独では実施できない。Claude Code は Human の GitHub 接続を使用するため、Claude 側は Owner identity のまま残る。

### Option B — GitHub Free Organization + role 分離

Organization を作成し Repository を移管、Human を Org Owner、AI を Member（Write）とする。

- 効果: Push Restriction が使用可能になる。
- 問題: Claude は依然として Org Owner である `Panda4th` として動作するため、単独では FAIL を解消しない。

### Option C — 単一 identity を受け入れ、技術ガードレール + 明文規則で運用

- 効果: 追加の credential なしで、CI 失敗状態・レビュー未完状態での Merge をすべて技術的に阻止できる。
- 残存リスク: 全条件を満たした PR の Merge ボタンを押した actor を区別できない。

---

## Decision

**Option C を採用する。**

判断理由は以下。

1. Option A / B は新規 credential 作成または権限構成の変更を伴い、AI が単独で実施してよい範囲を超える。
2. Option C だけで、「独立レビューを経ていない変更が `main` に入る」経路はすべて塞がる。残る穴は Merge 実行者の識別のみであり、Historical Data の完全性に直接影響しない。
3. Option C から Option A / B への移行は、再設計なしで後から追加できる。

本 Repository で到達可能な上限は **PARTIAL** であり、PASS には構造的に到達できない。GitHub基盤構築指示書 v0.2 の受入基準は「PASS または Human 承認済み PARTIAL」を認めているため、本決定は受入基準を満たす。

---

## Consequences

- `Human-only Merge Enforcement = PARTIAL`（Human Project Owner 承認済み）
- 明文規則を `docs/governance/merge-authority.md` として整備し、全 AI が従う。
- 技術ガードレール（Branch Protection / Required Status Checks / Trusted Policy Gate）を規則の補強として構築する。
- 技術的措置は規則を代替しない。両方が必要である。

---

## Revisit conditions

以下のいずれかが成立した場合に再評価する。

- 実装 AI 専用の machine account を用意できるようになった。
- GitHub Free Organization を導入した。
- AI integration が Human Project Owner とは異なる identity で動作するようになった。

再評価の結果は新しい decision record として記録する。
