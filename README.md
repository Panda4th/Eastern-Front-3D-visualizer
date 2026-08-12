# Eastern Front 3D Historical Visualizer

1941–1945 年の独ソ戦について、史料に裏付けられた戦線・部隊・作戦・戦闘・占領状況を、時間軸を備えた 3D 地理空間上で可視化するプロジェクトです。これは戦争ゲームや戦況予測ではなく、確認された史実を追跡可能な形で提示する Historical Visualizer です。

## Project baseline

- [Project Foundation v0.1](docs/foundation/project-foundation_v0.1.md)
- [GitHub Cloud Development Foundation v0.3](docs/architecture/github-cloud-development-foundation_v0.3.md)
- [Merge Authority Policy](docs/governance/merge-authority.md)
- [ADR 0001: Identity Separation Option C](docs/decisions/0001-identity-separation-option-c.md)

史実データの schema、Source ID、および確度表現は後続の Historical Data Model フェーズで決定します。それまでは [`historical/`](historical/) の namespace のみを保持し、推測データを追加しません。
