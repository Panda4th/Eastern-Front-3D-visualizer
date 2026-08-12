# 独ソ戦 3D Historical Visualizer — Project Foundation v0.1

**Status:** PASS  
**Version:** 0.1

## 1. 目的と対象範囲

1941〜1945 年の独ソ戦の戦線、部隊、作戦、戦闘、都市・地域の占領状況および時系列上の変化を 3D 地理空間上で可視化し、時間・地理・部隊・作戦の関係を理解できるブラウザ向け Historical Visualizer を構築する。

本プロジェクトは史実として確認された推移の再現であり、戦争・戦略ゲーム、AI による結果予測、Alternate History、ユーザーの作戦介入、および史料で確認できない展開の生成を対象外とする。

## 2. 最上位設計原則

> 史実性 ＞ トレーサビリティ ＞ 理解しやすさ ＞ 網羅性 ＞ 視覚的演出

見栄えや網羅性のために史料に裏付けられない情報を追加しない。不完全でも根拠のある表現を、完全に見える推測より優先する。

## 3. Historical Source Policy

Visualizer 上で史実として表示する情報には根拠史料を必要とする。AI・開発者の推測、演出用架空データ、根拠のない位置補間、前後関係だけから生成した部隊配置を史実として扱わない。日付、位置、編成、戦線、移動方向、占領、作戦期間、兵力および損害は特に厳格に扱う。

史料の優先順位は次の通りとする。

1. **Tier 1:** 一次史料・公的記録（公式記録、命令、日誌、当時の正式戦況図、政府・軍事アーカイブ）
2. **Tier 2:** 一次史料を基礎に政府・軍・公的研究機関が編纂した公刊戦史・公的研究
3. **Tier 3:** 一次史料や公刊戦史を参照した信頼性の高い研究書・学術論文

Wikipedia、一般 Web サイト、ブログ、動画、SNS、出典不明の図版等は探索・所在確認・クロスチェックの補助に限る。補助資料から原史料を特定・確認してから Historical Dataset に採用する。数値が相違する場合は単一値へ恣意的に統合せず、各値と出典、定義、対象期間および不確実性を保持する。

## 4. データと表現

全 Historical Data は出典へ逆引きできなければならない。確認済み、推定、未知等の状態モデル、Source ID、schema、補間および不連続時系列の表現は Historical Data Model フェーズで定義する。定義前に架空データで namespace を埋めない。

## 5. AI 開発責任

- Claude Code Opus: 全体統括、方向性、優先順位、統合判断
- Claude Code Sonnet: PMO、Issue/PR、依存関係および進捗管理
- GPT SOL: 要件・アーキテクチャ・データモデル・実装前設計・独立レビュー
- Codex: 実装、テスト、修正、Pull Request 作成

設計者、実装者、レビュー者および統括者を分離し、実装 AI による自己承認を避ける。GitHub 上の Repository、Issue、PR、Commit、Actions、Documentation、Historical Data を Single Source of Truth とする。

## 6. 成果物と後続順序

成果物はブラウザで利用できる HTML ベースの Web Application とする。詳細化は GitHub 開発基盤、要件、アーキテクチャ、Historical Data Model、Source Acceptance Policy、Technology Selection、Implementation の順に進める。MVP の対象期間・作戦・粒度および 3D 技術は後続フェーズで決定する。
