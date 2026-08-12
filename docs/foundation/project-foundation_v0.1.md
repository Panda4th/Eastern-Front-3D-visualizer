
<!-- Page 1 -->

1
独ソ戦
3D Historical Visualizer — Project Foundation v0.1
1.
プロジェクト概要
1.1
目的
1941
〜
1945
年の独ソ戦について、以下の情報を
3D
地理空間上で可視化し、ユーザーが時間軸を操作しながら戦況の
推移を追跡できる
Historical Visualizer

を構築する。
•
戦線
•
部隊
•
作戦
•
戦闘
•
都市・地域の占領状況
•
時系列上の戦況変化
本プロジェクトの目的は、独ソ戦の歴史的推移を時間・地理・部隊・作戦の関係として視覚的に理解できる環境を提
供することである。
1.2
プロジェクトの位置付け
本プロジェクトは「戦争そのものをシミュレーションする」ものではなく、
史実として確認された戦況推移を時空間
上で再現するビジュアライザー
とする。
以下は対象外とする。
•
戦争ゲーム
•
戦略ゲーム
•
AI
による戦闘結果予測
•
Alternate History / IF
戦史
•
ユーザーによる軍事作戦への介入
•
史料上確認できない展開の自動生成
2.
最上位設計原則
本プロジェクトにおける品質の優先順位を以下とする。
史実性 ＞ トレーサビリティ ＞ 理解しやすさ ＞ 網羅性 ＞ 視覚的演出
視覚的な完成度や網羅性を理由として、史料に裏付けられていない情報を追加してはならない。
例えば、
•
見栄えは良いが推測を含む戦線
•
一部欠落しているが史料根拠がある戦線
の二者であれば、後者を採用する。

<!-- Page 2 -->

2
3. Historical Source Policy
3.1
基本原則
Visualizer
上で史実として表示する情報には、原則として根拠となる史料が存在しなければならない。
史料で確認できない情報について、以下の方法で補完することを禁止する。
•
AI
による推測
•
開発者による推測
•
演出目的の架空データ
•
根拠のない位置補間
•
前後関係だけから生成した部隊配置
•
「おそらくこの位置にいた」といった推定の史実扱い
3.2
特に厳格に扱う情報
以下のデータは、史料根拠なしに確定情報として使用してはならない。
•
日付
•
部隊位置
•
部隊編成
•
戦線位置
•
攻撃方向
•
進撃方向
•
撤退方向
•
占領地域
•
都市占領時期
•
作戦開始時期
•
作戦終了時期
•
兵力
•
戦死者数
•
負傷者数
•
行方不明者数
•
捕虜数
•
戦車・車両損失
•
航空機損失
•
その他戦闘損害

<!-- Page 3 -->

3
4.
史料の優先順位
史料については以下の優先順位を基本とする。
Tier 1 —
一次史料・公的記録
最優先とする。
例：
•
軍公式記録
•
戦闘詳報
•
作戦命令
•
部隊日誌
•
公式戦況図
•
政府アーカイブ
•
軍事機関アーカイブ
•
当時作成された正式記録
Tier 2 —
公刊戦史・公的研究
一次史料等を基礎として、政府・軍・公的研究機関などが編纂した戦史・研究資料。
Tier 3 —
学術研究
一次史料、公刊戦史等を参照した信頼性の高い研究書・学術論文。
Tier 3
のみを根拠として正確な日時・位置・部隊配置等を確定する場合は、特に慎重に扱う。
補助資料
以下は史料探索、所在確認、クロスチェック等には利用できるが、原則として単独では
Visualizer
の史実データ確定
根拠にしない。
•
Wikipedia
•
一般
Web
サイト
•
個人ブログ
•
YouTube
•
SNS
•
出典不明の戦況図
•
出典追跡不能な二次転載情報
推奨される利用方法は以下。
補助資料
  ↓
元となった史料を特定
  ↓
一次史料・公的資料等を確認
  ↓
Historical Dataset
へ採用

<!-- Page 4 -->

4
補助資料のみを根拠として
Historical Dataset
へ直接採用することは禁止する。
5.
複数史料間で数値が異なる場合
5.1
基本方針
正確な損害数・兵力等が確定しておらず、複数の信頼できる史料で数値に差異が存在する場合は、
比較可能な史料の
平均値を
Visualizer
上の代表値として採用する
。
ただし、単純平均を行う前に各史料の定義・対象範囲を確認する。
5.2
比較可能性の確認
少なくとも以下を確認する。
•
集計対象期間
•
対象部隊
•
対象国
•
対象地域
•
戦闘・作戦の範囲
•
casualty
等の用語定義
•
戦死・負傷・行方不明・捕虜の区分
•
Axis
全体かドイツ軍のみか
•
ソ連軍全体か特定方面軍のみか
5.3
平均可能な例
史料
A
：戦死者
80,000
史料
B
：戦死者
90,000
史料
C
：戦死者
100,000
対象期間・対象範囲・定義が同一または十分に比較可能であれば、
Visualizer
採用値：
90,000
算出方法：
Arithmetic Mean
とする。
5.4
平均してはならない例
史料
A
：戦死者
史料
B
：戦死者＋負傷者
史料
C
：戦死者＋負傷者＋行方不明者
この場合、それぞれの指標が異なるため平均してはならない。
6.
史料値と
Visualizer
採用値の分離
平均値等を採用する場合でも、元の史料値を失ってはならない。
内部データ上では、最低限以下を保持する。
Visualizer Value:
90,000

<!-- Page 5 -->

5
Method:
Arithmetic Mean
Source Values:
SRC-004 = 80,000
SRC-018 = 90,000
SRC-027 = 100,000
Definition:
Killed
Period:
YYYY-MM-DD to YYYY-MM-DD
つまり、
史料に記載された値
と
Visualizer
で使用する代表値
を明確に分離する。
7.
史料不足の戦闘・事象
7.1
小規模戦闘
十分な史料が存在しない小規模な戦闘については、
Visualizer
から省略して構わない。
網羅性を高める目的で推測情報を追加してはならない。
7.2
重要な戦闘
重要な戦闘であっても、一部情報について十分な史料が存在しない場合は、その情報を無理に再現しない。
例えば、
戦闘の存在：確認済
戦闘期間：確認済
参加部隊：一部確認済
正確な部隊位置：確認不能
の場合、
戦闘そのものや確認済み情報は表示できるが、正確な位置が確認できない部隊を推測配置してはならない。
8.
時系列データと補間
8.1
原則
前後の日付について史料が存在していても、その中間状態を自動的に史実として扱ってはならない。
例えば、
6
月
22
日：部隊位置確認済
6
月
25
日：部隊位置確認済
という状態から、

<!-- Page 6 -->

6
6
月
23
日
6
月
24
日
の正確な部隊位置を単純な線形補間等によって生成し、それを確認済み史実として表示することは禁止する。
8.2
データ状態
将来的な
Historical Data Model
では、必要に応じて以下のような状態区分を検討する。
Confirmed
Estimated
Unknown
ただし
Estimated

を使用する場合でも、明確な史料的根拠から合理的に導出可能なものに限定し、
Confirmed

と
明確に区別する。
具体的な採用基準と表示方法は
Historical Data Model
設計時に正式決定する。
9. Historical Data Traceability
すべての
Historical Data
は、原則として根拠史料へ逆引き可能な構造とする。
概念構造は以下。
Historical Event
    │
    ├── Date
    ├── Location
    ├── Units
    ├── Front
    ├── Operation
    ├── Strength
    ├── Casualties
    │
    └── Sources
          │
          ├── Source ID
          ├── Title
          ├── Author / Institution
          ├── Publication
          ├── Page
          ├── URL / Archive ID
          └── Access Metadata
長期的には、
Visualizer
に表示されている情報から、その情報の根拠となった史料を確認できる
状態を目指す。
10. AI
開発体制
開発には複数
AI
モデルを利用し、責任分界を明確にする。
Role
AI
主責任
全体統括
Claude Code Opus
プロジェクト全体管理、方向性決定、
優先順位、統合判断
PMO
Claude Code Sonnet
Issue
、
PR
、依存関係、進捗、
GitHub
状態管理

<!-- Page 7 -->

7
Role
AI
主責任
基礎設計・独立レビュー
GPT SOL
要件定義、アーキテクチャ、データモ
デル、実装前設計、独立レビュー
実装
Codex
コーディング、テスト、修正、
PR
作成
責任分離
基本フローは以下。
Requirements / Architecture
        ↓
      GPT SOL
        ↓
Implementation Instructions
        ↓
       Codex
        ↓
Implementation / Tests
        ↓
GPT SOL Independent Review
        ↓
Claude Code Opus
        ↓
Integration / Next Decision
設計者・実装者・レビュー者の役割を分離し、実装
AI
による自己承認を避ける。
11. AI
間連携
各
AI
モデル間の作業指示・引き継ぎは、原則としてコードブロックによる構造化指示を使用する。
基本フォーマットは以下。
[ROLE]
[OBJECTIVE]
[CURRENT STATE]
[SCOPE]
[REQUIREMENTS]
[CONSTRAINTS]
[ACCEPTANCE CRITERIA]
[DELIVERABLES]
[DO NOT]
[REPORT FORMAT]
作業内容に応じて項目を追加・省略できるが、目的・範囲・制約・完成条件については可能な限り明示する。
12. Single Source of Truth
開発に関する正本は
GitHub

とする。
GitHub
├── Repository

<!-- Page 8 -->

8
├── Issues
├── Pull Requests
├── Branches
├── Actions
├── Documentation
└── Historical Data
ChatGPT
、
Claude
、
Codex
等との会話は作業・検討・レビューの場として利用するが、最終決定事項の正本とはしな
い。
重要な決定事項・要件・設計・レビュー結果等は必要に応じて
GitHub
へ反映する。
13.
開発環境
13.1
基本方針
開発環境は
GitHub Cloud Only

とする。
ローカル
PC
上での開発は原則行わない。
以下の開発工程を
GitHub Cloud
上で完結させる。
•
Coding
•
Testing
•
Build
•
CI
•
Review
•
Deployment
具体的な構成候補として以下を想定する。
•
GitHub Repository
•
GitHub Issues
•
GitHub Pull Requests
•
GitHub Actions
•
GitHub Codespaces
•
GitHub Pages
•
Web Preview Environment
具体的な採用技術・構成は技術設計フェーズで決定する。
14.
成果物
最終成果物は、
ブラウザから利用可能な
HTML
ベースの
Web Application
とする。
単一
HTML
ファイルで構成することは要求しない。

<!-- Page 9 -->

9
開発ソースは必要に応じて以下を利用できる。
Source
├── HTML
├── JavaScript / TypeScript
├── CSS
├── Historical Data
├── Assets
└── Tests
        ↓
      Build
        ↓
Browser-based Historical Visualizer
最終的にブラウザで利用できることを成果物要件とする。
15.
システム構造の基本思想
3D
描画技術を最初に設計の中心へ置かない。
開発の基本順序は以下とする。
Historical Sources
        ↓
Historical Dataset
        ↓
Historical Data Model
        ↓
Timeline Engine
        ↓
Visualization Model
        ↓
3D Rendering
        ↓
User Interface
本プロジェクトの中核は特定の
3D
ライブラリではなく、
独ソ戦を時間・地理・部隊・作戦・戦闘・史料という構造化データとして表現する
Historical Data Model
である。
3D Visualization Layer
は、その
Historical Data Model
を利用して史実を表示するプレゼンテーション層として位置
付ける。
16.
現時点での自己レビュー
評価
評価軸
判定
コメント
プロジェクト目的
PASS
Historical Visualizer
として明確
対象外範囲
PASS
War Game / IF
戦史との境界が明確
AI
責任分界
PASS
設計・実装・レビュー・統括を分離
史実性
PASS
非推測原則を明確化
史料ポリシー
PASS
優先順位と補助資料の扱いを定義
数値不一致処理
PASS
比較可能性確認後の平均値採用
トレーサビリティ
PASS
Source ID
ベースの追跡思想を定義

<!-- Page 10 -->

10
評価軸
判定
コメント
Historical Data Model
PASS /
要詳細化
基礎思想は確立、スキーマは未設計
開発基盤
PASS /
要詳細化
GitHub Cloud Only
は確定
Visualization
技術
未選定
MVP
・データモデル確定後に選定
BLOCKER
0
件
MUST FIX
0
件
次フェーズで決定する主要事項
1.
Historical Source
の具体的採用・棄却基準
2.
不連続な時系列データの表現方法
3.
Confirmed / Estimated / Unknown
等のデータ状態モデル
4.
Historical Data Model
の具体的スキーマ
5.
GitHub Cloud
開発環境の具体構成
6.
MVP
の再現対象期間・作戦・粒度
7.
3D Visualization
技術の選定
17. Project Foundation
判定
Status: PASS
現段階では、プロジェクトの目的、史料原則、
AI
開発体制、開発基盤の基本思想に重大な矛盾はない。
今後は基礎構想を不用意に変更せず、以下の順序で詳細化する。
1. GitHub
開発基盤
        ↓
2.
開発ガバナンス
        ↓
3. MVP Scope
        ↓
4. Historical Data Model
        ↓
5. Historical Source Acceptance Policy
        ↓
6. Technology Selection
        ↓
7. Implementation
本ドキュメントを、以後のプロジェクト設計における
Project Foundation v0.1

として扱う。
