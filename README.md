# 独ソ戦3D Historical Visualizer

1941〜1945年の独ソ戦について、戦線・部隊・作戦・戦闘・都市および地域の占領状況の時系列上の推移を、3D地理空間上で可視化する Historical Visualizer。

利用者は時間軸を操作しながら、史実として確認された戦況の推移を追跡できる。

## 本プロジェクトの位置付け

**本プロジェクトは Historical Visualizer である。War Game / 戦略ゲーム / IF戦史シミュレーターではない。**

以下は対象外とする。

- 戦争ゲーム / 戦略ゲーム
- AIによる戦闘結果予測
- Alternate History / IF戦史
- ユーザーによる軍事作戦への介入
- 史料上確認できない展開の自動生成

## 品質優先順位

```text
史実性 ＞ トレーサビリティ ＞ 理解しやすさ ＞ 網羅性 ＞ 視覚的演出
```

史料に裏付けられていない情報を、推測によって生成し史実として表示することを禁止する。Historical Data は原則として根拠史料まで逆引き可能な Traceability を持たせる。

## Foundation Documents

| 文書 | 内容 |
|---|---|
| [Project Foundation v0.1](docs/foundation/project-foundation_v0.1.md) | プロジェクトの目的、史料原則、AI開発体制、成果物要件 |
| [GitHub Cloud Development Foundation v0.3](docs/architecture/github-cloud-development-foundation_v0.3.md) | GitHub Cloud 開発基盤の基礎設計 |

## Governance

| 文書 | 内容 |
|---|---|
| [Merge Authority Policy](docs/governance/merge-authority.md) | Merge 実行権限に関する運用規則 |
| [Decision Records](docs/decisions/) | 重要な設計判断の記録 |

## Repository Structure

```text
.github/          Issue / PR Template, Workflows
docs/
  foundation/     上位正本
  architecture/   基礎設計
  governance/     運用規則
  decisions/      決定記録
historical/
  data/           Historical Dataset
  sources/        Historical Source metadata
  schemas/        Schema 定義
  validation/     Validation rule
```

`src/` `tests/` `assets/` `scripts/` は Technology Selection 後に追加する。

## Target Client

```text
Desktop Browser + Smartphone Browser
```

スマートフォン対応は後付け要件ではなく、MVP・UI設計・Technology Selection・Test設計に最初から影響する上位制約として扱う。

## Status

GitHub 開発基盤構築フェーズ。

Technology Selection（frontend framework / 3D library / package manager）は未実施であり、本フェーズでは決定しない。

## Contributing

`main` は Protected Branch であり、変更は Pull Request 経由に限る。

Pull Request は Trusted Policy Gate および Repository Validation による検証を受ける。詳細は [Merge Authority Policy](docs/governance/merge-authority.md) を参照。
