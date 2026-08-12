# historical/data/

Historical Dataset を格納する namespace。

**現時点では空である。** 詳細な構造は Historical Data Model フェーズで決定する。

## 制約

- 史料根拠のないデータを置いてはならない。
- 架空・推測のデータを placeholder として置いてはならない。
- 数値のみの上書きを行ってはならない。元の史料値と Visualizer 採用値を分離して保持する。
- `historical/` 配下を変更する Pull Request は `Historical Data Impact = YES` を宣言し、`Historical Change Detail` を記入しなければならない。

詳細は [Project Foundation v0.1](../../docs/foundation/project-foundation_v0.1.md) §3 / §5 / §6 / §9 を参照。
