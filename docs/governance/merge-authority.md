# Merge Authority Policy

## Policy

`main` を更新できる唯一の主体は Human Project Owner である。AI actor は Issue、task branch、commit、test、PR、review recommendation および integration recommendation を作成できるが、merge、direct push、force push、protection bypass、auto merge の有効化をしてはならない。

## Option C operation

1. Human Project Owner は Organization Owner/Admin identity を保持する。
2. AI は Owner と異なる、最小権限の GitHub identity または GitHub App を使う。
3. AI identity に `main` push、admin、bypass、secret 管理権限を付与しない。
4. Required CI、最新 HEAD に対する SOL PASS、Opus integration decision、未解決 conversation がないことを Human が確認する。
5. Human Project Owner が Squash Merge を実行する。

Owner session を AI と共有すると技術的分離は成立しない。資格情報を恒常的に AI へ渡さない。緊急時も branch protection を解除して直接 push せず、通常の PR 手順を使用する。例外が避けられない場合は、事前に Issue へ理由・期間・影響を記録し、Human が実行し、直後に保護を復旧して監査記録を残す。

## Required repository settings

- Require a pull request, required status checks, up-to-date branch and conversation resolution
- Restrict `main` pushes to the Human Project Owner
- Do not allow bypassing; disallow force pushes and deletion
- Squash merge only; auto merge off; delete merged head branches
