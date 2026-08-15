# Historical Source Definition & Collection Framework v1.0

**Project:** 独ソ戦3D Historical Visualizer  
**Repository:** `Panda4th/Eastern-Front-3D-visualizer`  
**Status:** Approved by Human Project Owner 2026-08-15（HPO-13）/ 正本登録版 / 登録先 `docs/research/historical-source-framework_v1.0.md`  
**Prepared by:** GPT SOL（v0.1〜v0.2.5の著述）/ Codex（v1.0初稿）/ PMO — Claude Code Sonnet（v1.0正本登録版の実装）  
**Prepared:** 2026-08-15  
**GitHub baseline checked:** `main` @ `6626e7c3aea4c9eb24d0e87a965a5c0c2e0da7e8`  
**Related:** Project Foundation v0.1 §§2–9, 12, 15–17 / Issue #24 / Issue #25 / Parent Issue #26 / Overall Lead Review 2026-08-14〜15（v0.1 Review / v0.2 Re-Review / v0.2.1 2nd Re-Review / v0.2.2 Independent Re-Review `#issuecomment-5293751543` / v0.2.3 Independent Re-Review `#issuecomment-5293761279` / v0.2.4 Independent Re-Review `#issuecomment-5299189860` / v0.2.5 Independent Re-Review `#issuecomment-5299304890` / v1.0 Independent Re-Review `#issuecomment-5299527450`）/ Human Project Owner HPO-1〜HPO-15・HPO-R1〜R4 / Framework承認記録 `#issuecomment-5299352830` / HPO-15決定記録 `#issuecomment-5299561829`  
**Normative effect:** 本文書はHPO-13により承認された上位Research Frameworkであり、Stage 1以降のHistorical Source研究における手続基準として適用する。本文書は、Project Foundation、AI Role and Communication Policy等のgovernance正本、Historical Data Modelのschema・field名・状態enum、Historical Source Acceptance Policyの詳細基準・閾値、Repository path規則、およびFoundation §17のフェーズ順序を単独で変更・確定しない。矛盾が生じた場合は該当適用領域の正本を優先し、本文書側の不整合として報告する。  
**Parent tracking issue:** GitHub Issue #26 `Historical Sources: 採用資料定義・収集Frameworkの決定記録と後続作業管理`  

---

## 1. Executive Summary

本Frameworkの目的は、独ソ戦3D Historical Visualizerに採用するHistorical Dataについて、史料の探索・特定・取得・史料批判・根拠抽出・照合・採否判断・不確実性保持・追跡可能性を、一貫した研究プロセスとして成立させるための上位Research Frameworkを示すことである。

最終ゴールは次のとおりとする。

> **独ソ戦3D Historical Visualizerで使用するHistorical Dataについて、採用可能な史料の条件と、史料を探索・特定・取得・検証・記録する標準的方法を確立し、各Historical Dataが「何を根拠とし、どのような判断を経て採用されたか」を第三者が追跡し、少なくとも根拠史料を再特定して採用判断を検証できる状態を実現する。**
>
> **史料で確認できない情報は推測で補完せず、史料間の不一致・情報欠落・未発見・非残存・アクセス不能・判読不能を失わずに扱う。採用時点では第三者が遠隔のonline channelから金銭負担なくEvidence本文・画像を確認できることを必須とする一方、将来にわたる公開継続までは保証せず、provenance、locator、access確認記録により再特定可能性と採用時判断の検証可能性を確保する。**

中核となる証拠連鎖は以下である。

```text
Historical Data / Historical Claim
        ↓
Claim-specific Evidence
        ↓
Source Object
        ↓
Archival / Publication Provenance
        ↓
Archive / Institution / Original Record
```

ProjectのSingle Source of TruthはProject Foundation §12に従いGitHubである。外部史料そのものをProject SOTと再定義しない。GitHub上には、Projectが採用したHistorical Data、判断、provenance、必要なtraceability情報を正本として保持する。

本v1.0は、Human Project Ownerが2026-08-15にHPO-13で承認したFramework Proposal v0.2.5（SHA-256 `04c5a4ff50f4d4f3456f3eae3f09d511538315e6e657dae72854df205f9fa60b`）を正本登録用に整備した版である。v0.2.5に対するOverall Lead Independent Re-Reviewは`APPROVE`（`BLOCKER 0 / MUST FIX 0 / SHOULD FIX 0 / FOLLOW-UP 1`）であり、そのIntegration判断とHuman Project OwnerによるFramework承認を区別する。本版は承認済み規定を再審査せず、正本登録に必要なmetadata、決定記録および履歴構造だけを整備する。

Historical Data確定根拠として適格なのは、第三者が遠隔のonline channelからEvidence本文・画像まで金銭負担なく再現可能に確認できるSourceだけである。公開online access、無料登録後のonline access、第三者にも同条件で再現可能な無料remote request、および同一Source Objectの合法的な別free online channelを適格候補とする。現地閲覧のみ、有料access、特定個人だけの再現不能なcopyは不適格とし、例外条項は設けない。

free-access eligibilityはSource Tier、Claim Fitnessおよび§6.6の探索・取得7状態とは直交する。適格性を正準7状態へ第8状態として混入させず、独立したaccess eligibility / exclusion recordとして保持する。

---

## 2. Current Authority and Phase Boundary

### 2.1 Project Foundationから継承する原則

本Frameworkは以下を変更せず前提とする。

1. **史実性 ＞ トレーサビリティ ＞ 理解しやすさ ＞ 網羅性 ＞ 視覚的演出**。
2. Visualizer上の史実情報には原則として根拠史料を要求する。
3. AI・開発者による推測、根拠のない位置補間、前後関係だけによる部隊配置生成を禁止する。
4. Foundation §4のTier 1 / Tier 2 / Tier 3 / 補助資料を基礎分類とする。
5. 史料値とVisualizer採用値を分離する。
6. 史料不足時は省略・Unknownを許容し、推測で網羅性を作らない。
7. Historical Dataは根拠史料へ逆引き可能とする。
8. Projectの開発上のSingle Source of TruthはGitHubとする。

§6.11のonline free-access-only制約は、Foundation §2の品質優先順位および§4の史料Tier順位へ新たな「信頼性順位」を加えるものではなく、採用候補集合に対するaccess / third-party verifiabilityのGateである。free-accessで必要Evidenceを確保できない場合は§27.8 C-8に従ってScope縮小、Unknownまたはomissionへ終端し、削るのは網羅性であって史実性ではない。一方、第三者が同じEvidence本文・画像を再確認できる条件を要求するため、トレーサビリティを強化する。access制約を理由に劣位史料や推測値で欠落を埋めて史実性を下げてはならない。

### 2.2 Foundation §17の順序

本Frameworkは以下の順序を維持する。

```text
MVP Scope
   ↓
Historical Data Model
   ↓
Historical Source Acceptance Policy
   ↓
Technology Selection
   ↓
Implementation
```

Issue #25はMVP Scopeであり、Historical Schema、Source ID形式、正式なConfirmed / Estimated / Unknown等の状態モデル、Historical Source Acceptance Policyの詳細基準はOut of Scopeである。本書もそれらを先取りして確定しない。

### 2.3 Governance freezeとIssue #24 / Pull Request #27

本v1.0改訂開始時点のGitHub Current Stateは§19.1に集約する。Issue #24に対応するPull Request #27はHuman Project OwnerによりMerge済みであり、Issue #24自体はOPENのままである。

`main`上の現行AI Role and Communication Policy §15は、Issue #25に対応するPull RequestがHuman Project OwnerによりMergeされMVP Scopeフェーズが完了するまで、governance文書を対象とする新規Pull Requestを凍結する。Merge済み文書に含まれる事実誤りの是正だけが凍結対象外であり、governance-sensitive Pull Requestを同時に複数進行させない制限も維持される。

本文書は以下を守る。

- path選択によって凍結の趣旨を迂回しない。
- HPO-14および2026-08-15のHuman Project Owner決定により、本文書は`docs/research/historical-source-framework_v1.0.md`へ登録する。
- 本登録はPolicy §15のgovernance freezeを解除せず、Merge済み文書の事実誤り是正に関する例外規定も援用しない。
- `docs/research/`を選定する実体的理由は、本文書がHistorical Researchの方法論文書であり、役割・権限・Merge条件を定めるgovernance文書ではないことである。「凍結中だから」を選定理由としない。
- 後続フェーズで本文書がgovernance性を帯びる場合は、その時点の正本規則に従ってpathを見直しうる。
- 方法論文書と実Historical Dataのpath分離は、`v0.1 Review / FOLLOW-UP-1`に由来する未決事項として保持し、`docs/research/`の確定だけで解消済みとは扱わない。

---

## 3. Objective

本作業のObjectiveは、次の6点を満たすHistorical Source Research Frameworkを確立することである。

### 3.1 O-1. Source Eligibility

FoundationのTier体系を維持しながら、複製、刊行一次史料、翻訳、転載、出所不明scan等の境界事例を後続Policyで一意に扱える骨格を用意する。

### 3.2 O-2. Source Collection

情報発見から原典・原資料の所在確認までを標準化し、検索結果や転載物をそのまま根拠化しない。

### 3.3 O-3. Evidence Traceability

「この本・このサイトを使った」ではなく、そのHistorical Claimを支える具体的ページ、画像、frame、文書、地図、表、記述へ戻れるようにする。

### 3.4 O-4. Uncertainty Preservation

史料間の相違、未発見、非残存、未調査、actor側アクセス不能、史料側利用制限、判読不能等を同一の「不明」に潰さない。

### 3.5 O-5. Reviewability

別の研究者またはAIが、使用史料、Evidence locator、史料批判、比較対象、採用理由を確認し、その判断を独立に評価できるようにする。

### 3.6 O-6. Executability

Research Protocolを誰がどの環境で実行できるかを事前に確認し、archive access capability不足を史料不存在と混同しない。

---

## 4. Scope

本Frameworkが対象とするのは以下である。

- Historical Sourceの探索原則
- Source Tierの運用骨格と境界事例の扱い
- SourceとEvidenceの区別
- Source ObjectとAccess Platformの区別
- 原資料へのprovenance追跡
- Source lineage / independence
- Claim-specific source criticism
- 史料間corroborationの基本原則
- Foundation §5の適用に関する未規定論点の明示
- Operational map / War Diary / Order / Intelligence / Casualty等の注意点
- time reference / formation instance / georeferencing等の情報要件
- OCR・転記・翻訳の扱い
- archive access・free-access eligibility・rights・privacy・public repositoryの扱い
- Search Log / negative evidence / access failureの扱い
- Historical Data Modelへ引き渡す情報要件
- Historical Source Acceptance Policyで正式決定すべき事項
- Pilotを含むphase-aligned delivery plan

---

## 5. Out of Scope and Governance Contact

本Frameworkでは以下を確定しない。

- MVP対象期間・作戦・戦闘の最終決定
- Historical Dataの具体的schema
- Source ID / Evidence ID等の識別子形式
- Confirmed / Estimated / Unknown等の正式な状態名・enum
- JSON / YAML / CSV等の保存形式
- Database / frontend / 3D library等の技術選定
- 個別戦闘についての正式Historical Dataset
- 個別史料の最終採用・棄却
- Project Foundationの改訂
- Foundation §5のArithmetic Mean原則そのものの変更
- 方法論文書と実Historical Dataおよび後続D-3〜D-8の最終path分離
- Archive binaryの一括再配布・ミラーリング
- 有料会員登録、subscription、書籍・論文・digital copy購入、閲覧料、download料、複写注文等の支払いを前提とする史料のHistorical Data根拠への採用

HPO-14および2026-08-15のHuman Project Owner決定により、本Frameworkは`docs/research/historical-source-framework_v1.0.md`へ登録する。この登録はPolicy §15のgovernance freezeを解除せず、例外規定も援用しない。`docs/research/`を選定する実体的理由は、本FrameworkがHistorical Researchの方法論文書であり、役割・権限・Merge条件を定めるgovernance文書ではないことであり、「凍結中だから」を理由としない。後続フェーズでgovernance性を帯びる場合は、その時点の正本規則に従ってpathを見直しうる。方法論文書と実Historical Dataのpath分離は`v0.1 Review / FOLLOW-UP-1`に由来する未決事項として保持し、本Frameworkのpath確定をもって解消済みとは扱わない。

---

## 6. Core Design Principles

### 6.1 P-1. Claim-centric acceptance

史料を文書単位で一括して「信頼できる／できない」と評価しない。採用判断の単位はHistorical Claimとする。

例：

- 自軍命令書は「命令された攻撃方向」を示す根拠として強い。
- 同じ命令書は「実際にその方向へ進撃できた」ことを自動的には証明しない。
- 自軍戦闘詳報は自軍配置の根拠になりうる。
- 同じ文書の敵損害推定は、敵側記録や独立資料による照合なしに同じ強度で扱わない。

### 6.2 P-2. Source Tier ≠ Reliability Score

Tierは史料類型・制度的位置・史実への距離を示す基礎分類であり、Tier 1を無条件に正しいとみなす点数ではない。一次史料にも誤認、戦場の混乱、上申上の偏り、敵情推定、後日訂正、欠落、作成目的による歪みがありうる。

### 6.3 P-3. Source ObjectとAccess Platformを分離する

```text
Память народа / invenio / NARA catalog
    = Access / Discovery Platform

War Diary / Order / Map / Report / specific archival file
    = Source Object
```

Tierは原則としてSource Objectに関する分類であり、Access PlatformそのものにTierを付与しない。

### 6.4 P-4. Provenance first

転載、引用、索引、まとめページから資料を発見した場合、可能な限り元のArchive / Fonds / Bestand / Record Group / Series / File / Itemへ遡る。「どこで見たか」と「何の原資料か」を分離して保持する。

### 6.5 P-5. Source lineage / independenceを保持する

同一の原報告・原文書を再掲または再引用する複数資料を、独立した複数観測として数えない。

```text
Original Report X
  ├─ Microfilm reproduction
  ├─ Official History quotation
  └─ Academic Book quotation
```

この原則はFoundation §5が明示していない**追加適用規則**であり、特定の場合にArithmetic Meanの算出結果を変えうる。Human Project Ownerは2026-08-14、本原則を採用する方針を承認した。ただし、重複・部分的独立の正式処理規則はHistorical Source Acceptance Policyで確定する。

### 6.6 P-6. Unknown and negative evidence are valid research outcomes

研究結果は少なくとも次の概念を区別して後続Data Modelへ引き渡すことを提案する。

1. **Not yet searched** — relevant archive / collectionをまだ調査していない。
2. **Not found in searched scope** — 記録された探索範囲では未発見。
3. **Non-survival supported** — 非残存を示すarchive側の積極的証拠がある。
4. **Source identified but not acquired** — 所在・識別はできたが内容未取得。
5. **Actor/environment access blocked** — 研究actorのnetwork / auth / environment要因でchannelへ到達できない。
6. **Source-side restricted** — archive側の閲覧・利用・権限制約で取得不能。
7. **Illegible / incomplete** — 史料は取得できたが判読不能・欠頁等がある。

**Source conflictはnegative evidenceではないため上記集合から分離し、別カテゴリとして保持する。**

free-access eligibility / exclusionも上記7状態とは直交する独立軸である。有料、現地閲覧のみ、再現不能な個人限定access等のため不適格となった候補Sourceを、正準7状態へ機械的な第8状態として追加しない。同じSourceについて、探索・取得状態とaccess eligibility / exclusionの双方を独立に記録できる骨格をHistorical Data Modelへ引き渡す。

正式なenum名やstorage schemaはHistorical Data Modelで決める。

「No source exists」は研究者の検索結果だけから原則として主張しない。明示的なarchive記録等の積極的証拠がない場合、既定の表現は`Not found in searched scope`とする。

### 6.7 P-7. Original image/text precedes OCR and translation

OCR、機械翻訳、人手翻訳、要約は派生情報である。採用Claimは可能な限り原画像または原文の特定箇所へ戻れることを要求する。

### 6.8 P-8. Rights-aware and privacy-aware collection

「閲覧できる」「研究に利用できる」「Public GitHubへ再配布できる」は別判定とする。copyright / reproduction / republicationに加え、個人情報・private life等の制約も独立軸で扱う。

### 6.9 P-9. Bilateral but not mechanically symmetrical

可能な範囲でドイツ側・ソ連側双方の記録を利用するが、全Claimへ機械的な「双方1件ずつ」を要求しない。Claimのriskと史料残存状況に応じてcorroborationを変える。

online無償公開の範囲は史料の残存状況だけでなくdigitizationの経済・機関別公開方針に依存する。HPO-9のonline free-access-only境界により、ソ連側でTier 1 scanが広く残る一方、ドイツ側では利用可能なTier 1が限定されTier 2〜3への依存が相対的に高まる等、陣営別の証拠強度差が生じうる。この非対称を「一方の史実が本質的により確かである」という意味へ変換してはならない。Visualizer側へ、陣営別coverage、利用可能Tier、free-access制約およびunresolved gapを誤読されない形で引き渡す。表示仕様の正式決定は後続Data Model / Visualization設計へ留保する。

### 6.10 P-10. Source precision caps data precision

Sourceの時間・地理・部隊粒度を超える精度を確定情報として生成しない。地図のgeoreferencingや時刻正規化等の派生処理は、元史料と変換情報を分離して保持する。

### 6.11 P-11. Free-access evidence only

Historical Dataの根拠として採用するSource Objectは、第三者が遠隔のonline channelから**金銭を支払わず、Evidence本文・画像を再現可能に確認できること**を必須条件とする。例外条項は設けない。

**適格候補は次の4類型である。**

1. 公開Webページ、online viewerまたはdownloadから無償で確認できる。
2. 無料アカウント登録後にonlineで無償確認できる。
3. 無料のremote request後にdigital copyまたはonline accessが提供され、第三者にも同じ条件で再現可能である。
4. 同一Source Objectを合法的な別channelから上記条件で無償確認できる。

**Historical Data確定根拠として不適格なのは次の3類型である。**

1. 有料会員登録、subscription、購入、閲覧料、download料、複写料その他の支払いが必要である。
2. 現地閲覧のみで、遠隔から無償確認できない。
3. 特定個人だけに付与された権限、再現不能な一時access、第三者一般に再現できない裁量的提供による。

現地閲覧のみのSourceはdiscovery、所在確認、将来候補の記録には利用できるが、Historical Data確定根拠には採用しない。現地閲覧で取得した複製がrights条件を満たし、合法的かつ安定的なfree online channelで第三者へ公開された場合は、現地閲覧経路ではなく当該free online channelを別途Gate判定する。

有料またはonline無償条件を満たさないSourceと無料Evidenceの関係は、確認できた内容の水準に応じて次の3段階に分ける。

| 段階 | 確認できた状況 | 扱い |
|---:|---|---|
| 1 | 有料Sourceの所在だけ判明し、内容を確認できない | `free-access constraintにより除外された候補Source`として記録する。存在だけを理由にconfidenceを自動的に下げず、内容・値を推定しない。 |
| 2 | catalog metadataまたは無料で確認できる二次資料から、Claim-specificな反証可能性が合理的に示される | `potential conflict`として保持する。有料Sourceから直接確認した事実として扱わない。materialな反証可能性が残る間、無料Source側を無条件のConfirmed値にしない。 |
| 3 | 無料で確認可能な別Evidenceが対立内容を具体的に裏付ける | §14.5の正式なconflictとして保持する。無料Sourceの片側だけを単独確定値にしない。最終状態と閾値はHistorical Data ModelまたはHistorical Source Acceptance Policyで確定する。 |

「有料Sourceが存在する」という一般的事実だけを理由に、全Claimを一律にsingle-source supportまたはlower-confidenceへ落としてはならない。探索量の多寡をconfidenceへ混入させない。free-access eligibilityはTier、Claim Fitness、§6.6の正準7状態およびconfidenceとは別に評価する。

---

## 7. Research Flow and Gates

標準研究フローを次とする。

```text
0. Research Actor / Channel Capability Gate
        ↓
1. Historical Question / Claim Definition
        ↓
2. Research Packet
        ↓
3. Source Discovery / Finding Aid
        ↓
4. Provenance Identification
        ↓
5. Access / Acquisition
        ↓
6. Source Criticism
        ↓
7. Evidence Extraction
        ↓
8. Corroboration / Conflict Check
        ↓
9. Online Free-access Eligibility / Rights / Privacy Check
        ↓
10. Adoption / Rejection / Hold / Unknown
        ↓
11. Traceability Record
        ↓
12. Historical Dataset
```

### 7.1 Gate 0 — Research actor / channel capability

調査単位へ着手する前に、利用予定channelごとに以下を実測し記録する。

- catalog / search pageへ到達可能か
- document metadataへ到達可能か
- document image / binaryへ到達可能か
- access channelが次のStage 1観測区分のどれに該当するか
- Evidence本文・画像まで遠隔・無償・第三者再現可能な条件で確認できるか（online free-access eligibility）
- automated retrievalが許容されるか
- actor側network restrictionか、source側restrictionか

Stage 1 Channel Access Feasibilityでは、各channelについて次の8区分を観測し記録する。

1. `online public access`
2. `online access after free registration`
3. `free and reproducible remote request`
4. `on-site-only consultation`
5. `paid registration / subscription`
6. `purchase / download / reproduction fee required`
7. `actor-side block`
8. `source-side or regional restriction`

これらはGate 0 / Stage 1の観測区分であり、Historical Data Modelのcanonical enumとして先取り確定しない。registration / request / on-site / paid等の正式なfield名・値域もHistorical Data Modelへ留保する。

観測区分3 `free and reproducible remote request`を適格候補と判定する場合は、公開された請求手続きのlocator、無料であることの明示、第三者一般への適用可否、応答実績の有無・確認日・確認actor・結果等、再現可能性の判定根拠を記録する。個別の好意的対応や特定actorだけの取得実績から第三者一般への再現可能性を推定せず、根拠を確認できない間は適格と確定しない。

Channel Access Feasibilityでは、HPO-9の境界を適用したときにGerman-side Tier 1 SourceがどのClaim family・期間・部隊・必要粒度でどの程度残るかを実測し、Soviet-sideとのcoverage / Tier非対称を比較可能にする。さらに、部隊位置、front line、都市占領時刻、strength、casualties等のhigh-risk Claim familyごとに、free-access範囲でbilateral、上級／下級または隣接部隊によるcorroborationが成立しうるかを実測し、成立しない場合の終端候補をsingle-source support、Scope縮小、Unknownまたはomissionとして記録する。最終状態と閾値はHistorical Data Model / Historical Source Acceptance Policyへ留保する。

Human Project Owner承認方針は**併用モデル**とする。

- GPT SOL：通常のOrientation、finding aid調査、公開catalog検索、アクセス可能資料のEvidence抽出を担当可能。
- Human Project Owner：無料アクセスの範囲で、SOL環境から取得不能な資料について本人操作・無料登録・第三者にも再現可能な無料remote request・別環境確認等を必要に応じて担当。現地閲覧のみまたは個人限定の再現不能なcopyをHistorical Data確定根拠へ昇格させない。
- **有料請求・購入・有料会員登録・閲覧料等はエスカレーション対象ではなく採用除外条件とする。**
- 他actorを用いる場合も、実capabilityを推測せず実測する。

**Change-history note — v0.2 §7.1の「現地閲覧」削除:** v0.2からv0.2.1への改訂時（2026-08-14）、文書実装担当GPT SOLがHuman側担当記述から「現地閲覧」を削除した。この変更はHPO-9決定前に行われ、当時、削除を命じるHuman Project Owner決定または明示的な根拠は記録されていなかったため、権限根拠を確認できない著者側変更として履歴に残す。現行§7.1が現地閲覧のみのSourceをHistorical Data確定根拠へ採用しないのは、当該先行変更を権限根拠とするのではなく、v0.2.1 2nd Re-Review後にHuman Project Ownerが決定したHPO-9によって事後的に正当化・正式化されたためである。先行変更の手続上の欠陥を遡及的に解消済みとは扱わない。

2026-08-14の再確認ではSOLのWeb環境からBundesarchiv、NARA、Память народа、German Documents in Russiaの公開ページへ到達可能であった。ただし、個別binary・認証・大量取得・全holdingsへのアクセスを保証するものではない。採用候補化には各Evidenceが§6.11のonline free-access要件を満たすことを別途確認する。

### 7.2 Gate A — Claim definition

検索前に、何を知りたいか、対象日・期間、対象地域、対象部隊、必要粒度、何をもって十分な証拠とするかを定義する。

### 7.3 Gate B — Provenance identification

補助資料・二次資料から発見した情報は可能な限り出典を遡る。原典へ到達できない場合は、その限界を明示し採用強度を下げるかholdとする。

### 7.4 Gate C — Source criticism

Source Tierだけでは採否を決めず、§10のClaim Fitness観点でClaimへの適合性を確認する。

### 7.5 Gate D — Corroboration

位置・日時・front line・損害等の高risk Claimは、必要に応じて独立資料、相手側資料、上級／下級部隊資料を照合する。

### 7.6 Gate E — Traceability

採用後に「どこに書いてあるか」を再特定できないClaimは、正式Historical Dataへ昇格させない。

---

## 8. Priority Source Landscape and Finding Aids

これは最終的な採用資料一覧ではなく、Source Discoveryの優先探索先である。Archive本体とfinding aidを別層として扱う。

### 8.1 German-side primary source channels

#### 8.1.1 Bundesarchiv / invenio

Bundesarchivのinvenioは所蔵資料検索、デジタル化資料閲覧、閲覧室利用の準備に利用できる。URLだけでなく正式なArchivsignaturを主要locatorとする。

**Finding aid layer:** Bestand構造、Bestandsbeschreibung、Findbuch、invenioのhierarchical holdings view等をOrientationに利用する。Catalog移行に伴うreference code変更の可能性を考慮し、access dateと旧新identifierが判明する場合は双方を保持する。

#### 8.1.2 U.S. National Archives — RG 242 Captured German Records

東部戦線研究に重要なcaptured German recordsとして、NARAはT78（OKH）、T311（Army Groups）、T312（Armies）、T313（Panzer Armies）、T314（Corps）、T315（Divisions）等を案内している。

**Finding aid layer:** `Guides to German Records Microfilmed at Alexandria, Va.`および各microfilm publicationのGuide番号をOrientationに使用する。Publication / roll / frameをlocatorとして保持する。

Bundesarchiv原資料とNARA microfilmが同一原資料を再現する場合、独立した2証拠として数えない。

#### 8.1.3 German Documents in Russia

ロシア連邦のarchiveに残るドイツ文書のdigital accessを提供する共同プロジェクト。archive / fond / opis / delo等の原資料情報を保持し、website自体をSource Objectとしない。

### 8.2 Soviet-side primary source channels

#### 8.2.1 Память народа

部隊文書、戦闘日誌、命令、報告、作戦計画、地図等へのDiscovery / access channelとして扱う。portalの編集済み作戦ページと原文書scanを区別する。

#### 8.2.2 Underlying archival references and finding aids

ЦАМО等の`фонд / опись / дело`を保持する。可能な場合はfonds / opisレベルの目録・collection structureをOrientationに利用し、portal URLだけに依存しない。

### 8.3 Tier 2 / Tier 3 / auxiliary sources

以下に積極利用する。

- 一次史料の所在特定
- 作戦構造と部隊系統のOrientation
- archive reference / document familyの発見
- 一次史料間の矛盾点の発見
- 研究史上の主要論点把握

補助資料はDiscoveryへ利用できるが、Foundation §4に従い単独でHistorical Datasetへ直接採用しない。

---

## 9. Operational Collection Protocol

正式SOPは後続Source Acceptance Phaseでprovisional版を作成しPilotで検証する。本節はその骨格である。

### 9.1 Research Packetを先に作る

Archive検索開始前に、1つのInvestigation Unitについて少なくとも以下を整理する。

- Historical Question / Claim
- target date / date range
- target geography
- target unit / command hierarchy
- **formation instance / effective period / superior command**
- required granularity
- **time referenceが問題になるか**
- expected document families
- German / Russian names and abbreviations
- place-name variants / historical spellings / transliteration variants
- sufficient evidenceの仮条件

### 9.2 Discoveryは二段階で行う

#### 9.2.1 Phase A — Orientation

Tier 2 / Tier 3、archive guide、Findbuch、Bestandsbeschreibung、NARA Guides、fonds / opis目録等を使い、関係部隊、指揮階梯、文書系列、holdings、date rangeを特定する。

#### 9.2.2 Phase B — Archive-first retrieval

特定したarchive / collection / record group / fondへ移動し原資料を検索する。

### 9.3 Top-down / bottom-upの両方向で探す

Army Group / Front → Army → Corps → Division等のtop-down調査と、当該部隊記録からのbottom-up調査を併用する。食い違いは消さず研究対象とする。

### 9.4 Search keyを多言語・異表記で管理する

同一対象のGerman / Russian designation、略号、当時地名、占領期名称、Russian / Ukrainian / Polish等の表記差、transliteration variantsを管理する。

重要Historical Dataについて「確認不能」または`Not found in searched scope`を主張する場合、少なくとも以下を**逐語で記録する**。

- 実際に投入した検索語・表記
- platform / catalog / finding aid
- 実行日
- filter / date range等の条件
- 結果件数またはresult state
- follow-upしたcollection / record group

### 9.5 Document familyに優先順位を置く

| Claim | 優先して探す資料 |
|---|---|
| 作戦意図 | directive / order / operation plan |
| 実際の進撃 | war diary / combat report / situation report / map |
| 部隊位置 | situation map / war diary / operations log |
| front line | dated map + adjacent/opposing records |
| 都市占領時点 | combat report / war diary / opposing record |
| strength | strength return / status report |
| casualties | casualty return / personnel report / later aggregate |
| enemy losses | opposing-side recordsを優先照合 |

これは探索優先順位であり、採用強度を自動決定しない。

### 9.6 Locatorを先に確保する

内容をメモする前に、可能な限りarchive / institution、collection / fonds / record group、file / item、page / folio / image / frame、document date、creator / unitを確保する。

### 9.7 Evidence extractionはClaimごとに行う

各Claimについて、どの記述・図示を根拠にしたか、どこまで言えるか、何は言えないかを分離する。Sourceが示す精度以上の主張へ拡張しない。

### 9.8 Research Logを同時更新する

採用候補だけでなくrejected、contradictory、actor-blocked、source-restricted、not-found、incomplete等の探索経路も記録する。

### 9.9 Collection Stop Rule

通常探索は、必要粒度を満たすEvidenceが得られ、重大な矛盾が解消または明示され、追加探索が結論を変える可能性が十分低くなった時点で停止できる。

以下が残る場合は追加探索を優先する。

- 主要史料系列が未確認
- source lineageが不明
- high-risk Claimが当事者一方の推定だけ
- 重要な矛盾が未記録
- locatorが不十分

ただし、**所定の探索範囲を尽くしてもcorroborationが得られない場合は永久に探索を継続しない。** その時点でsingle-source supportまたはUnknown / unresolvedへ終端し、以下をSearch Logへ残す。

- 探索した範囲
- 未充足のcorroboration条件
- source survival / accessの制約
- なぜ停止したか
- 将来再開条件があればその条件

「所定の探索範囲」の正式な閾値はHistorical Source Acceptance Policyで決める。

---

## 10. Claim Fitness — Source Criticism Dimensions

正式な採点方式・enumはHistorical Source Acceptance Policyで決めるが、少なくとも次の観点を評価する。

### 10.1 Provenance / Authenticity

作成主体、原資料／複製／転記、archive provenance、改変・編集・抜粋の有無を確認する。

### 10.2 Contemporaneity

事象との時間的距離を確認する。後世資料を自動排除せず、同時代記録と回顧を区別する。

### 10.3 Administrative / Observational Distance

現場部隊、上級司令部、敵情取得経路等、情報が何階梯を経ているかを確認する。

### 10.4 Purpose / Bias

命令、状況報告、損害申告、情報報告、宣伝、戦後教訓、回顧録等の作成目的を確認する。

### 10.5 Scope / Definition Fit

数値の場合は期間、部隊範囲、地域、陣営、casualty definition、strength population等を一致確認する。

**時刻を含むClaimでは、照合前に時刻・日付基準を確認する。** 原文のtime expressionと、必要に応じて正規化されたtimeを分離する。

### 10.6 Independence / Lineage

複数資料が同じ原報告を再利用していないか確認する。完全重複と部分的独立を区別する。

### 10.7 Completeness / Legibility

欠頁、欠図、判読不能、cut-off scan、OCR誤り、付属地図欠落等を記録する。

### 10.8 Granularity Fit

SourceがMVPで必要とする時間・部隊・地理粒度を支えられるか確認する。

### 10.9 Identity Fit

部隊名だけでなくformation instance、有効期間、上級所属等が対象Claimと一致するか確認する。同一番号の再編・再建部隊を同一時系列として誤接続しない。

---

## 11. Minimum Information Requirements

ここではschemaやfield名を確定せず、将来のHistorical Data Modelが表現できるべき情報要件のみを示す。

### 11.1 Source identity

- title / document description
- creator / issuing organization / unit
- document date / date range
- archive / institution
- fonds / Bestand / Record Group
- series / opis / finding aid context
- file / delo / Akte / item
- page / Blatt / image / frame / map sheet
- 対象部隊がある場合のformation instance / effective period / superior command

### 11.2 Access metadata

将来のHistorical Data Modelは、Source / Claimごとに少なくとも次の概念を表現できることを要求する。

- Source identifier
- Source locator / stable identifier / URL
- access channel
- access check date
- accessを確認したactor
- actor/environment capability state
- source-side / regional restriction
- Stage 1観測区分（§7.1の8区分）
- free-access eligibility（Evidence本文・画像まで遠隔・無償・第三者再現可能に確認できるか）
- remote requestを再現可能と判定した根拠（公表された請求手続きのlocator、無料条件の明示、第三者一般への適用可否、応答実績の有無・確認日・actor・結果）
- exclusion reason
- 対象Claimとの関係
- 内容確認状態（例：内容未確認 / Claim-specificな反証可能性のみ確認 / 対立内容を無料Evidenceで確認可能）
- rights条件を満たす別free online channelの有無

これらは§6.6の探索・取得7状態と別軸のaccess eligibility / exclusion recordの情報要件である。有料またはonline無償条件を満たさないSourceも、Evidenceとして採用せずにcandidate / exclusionのTraceabilityを保持する。

Source ID、field名、`registration` / `request` / `on-site` / `paid`等の正式な値域、status enumおよびstorage schemaはHistorical Data Modelへ留保する。§7.1の8区分はStage 1で観測すべき区分であり、canonical enumではない。

### 11.3 Evidence locator

page、folio、image、frame、map sheet、table row、document number、dated entry等、Claimを支える具体的箇所。

### 11.4 Time reference

時刻・日付が重要なClaimでは以下を分離可能にする。

- 原史料上のdate/time表記
- 史料側time zone / time standard / calendar basisが判明する場合そのbasis
- 正規化値を作る場合その値
- conversion rule / uncertainty

正規化方式・canonical timezoneはHistorical Data Model / Policyで決める。

### 11.5 Provenance lineage

複製、翻訳、編集刊行、二次引用等を経由した場合、その系譜と上流Source Objectを追えること。

### 11.6 Interpretation / adoption context

- 何のClaimを支えるか
- どの意味で使用したか
- 他資料と矛盾するか
- single-sourceか
- 採用判断の制約

### 11.7 Rights / reuse / privacy

- 閲覧条件
- reproduction / republication条件
- attribution条件
- Public Repositoryへbinaryを置けるか
- 個人情報を含むか
- private-life情報等の公開制約があるか
- 引用・transcription可能範囲

### 11.8 Spatial derivation / georeferencing

地図を現代座標系へ変換する場合、元地図情報と派生情報を分離し、少なくとも以下を追跡可能にする。

- source map scale / sheet / edition
- original grid / coordinate system
- control points / transformation route
- transformation parameters / softwareまたはmethod
- estimated error / uncertainty
- resulting coordinateがsource precisionを超えていないか

### 11.9 Integrity metadata

合法的に保持できるbinaryについて、将来的にfilename / checksum等で参照copyを同定できる構造を検討する。方式と保存場所は後続設計で決める。

---

## 12. Tier Boundary Skeleton

Foundation §4のTier体系を維持しつつ、後続Policyが境界事例を判定できる骨格を次のように提案する。

### 12.1 TierはSource Objectを基準にする

Access Platform自体にTierを付与しない。Catalog、portal、mirrorはAccess / Discovery layerである。

### 12.2 Faithful reproduction / surrogate

Microfilm、scan、写真複製が同一Source Objectを忠実に再現しprovenanceが確立している場合、**元Source ObjectのTier評価を参照できる**。ただし複製物は元資料と独立したEvidenceを追加しないため、lineageを必ず記録する。

### 12.3 Edited documentary publications

一次文書を収録する編集刊行版では、以下を分離する。

- 収録された一次文書そのものに基づくClaim
- 編者による要約・注釈・選択・解説

収録一次文書へ一意に遡れ、転記・省略・編集介在が追跡できる場合、その一次文書のTier評価を参照候補とできる。ただし刊行版自体を原本と独立した一次証拠として二重計上しない。編集者の解説は別Source Object / Claimとして評価する。

### 12.4 Translation

翻訳は派生表現であり、原文Source ObjectのTierを自動的に変えない。Claim採用時は可能な限り原文へ戻り、翻訳はlineageとして記録する。原文へ遡れない翻訳のみの場合は、精密Claimへの利用を慎重に扱う。

### 12.5 Unprovenanced scan / repost

原文書らしい画像であってもprovenanceが確立できない転載・scanは、provenance確立まで補助資料として扱い、Foundation §4の単独採用禁止を適用する。

正式なTier境界・例外はHistorical Source Acceptance Policyで確定する。

---

## 13. Search Log, Negative Evidence, and Conflict

### 13.1 Canonical conceptual states

§6.6の7状態を本Framework内のnegative / access research stateの正準概念集合とする。Conflictは別カテゴリとする。

### 13.2 Reproducibility requirement for negative findings

重要Historical Dataについて`Not found in searched scope`を採用理由に用いる場合、検索語、platform、日付、filters、result count/state、調査collectionを逐語記録する。

### 13.3 High bar for non-survival / non-existence

研究者の検索失敗から「史料は存在しない」とは結論しない。非残存を主張するには、archive inventory、destruction/loss record、finding aid上の明示、archive institutionの説明等の積極的Evidenceを要求する。

### 13.4 Actor-side vs source-side access failure

- actor/environment access blocked
- source-side restricted

を分離する。Claude Code environment等、あるactorからchannelへ到達できないことをProject全体の史料不存在・到達不能へ一般化しない。

---

## 14. Corroboration and Conflict Handling

### 14.1 Risk-based corroboration

すべてのClaimに一律2資料を要求しない。正確な部隊位置、front line、攻撃／撤退方向、都市占領時刻、作戦開始・終了、strength、casualties、equipment losses等、誤りの影響が大きいClaimほどcorroborationを強くする。

### 14.2 Own-side vs enemy-side claims

自軍の命令・配置・損害と、敵軍配置推定・敵軍損害推定・戦果申告を区別する。敵側に関する推定は相手側記録または独立資料の確認優先度を上げる。

### 14.3 Command-level cross-check

上級司令部、当該部隊、隣接部隊、相手側部隊の記録を可能な範囲で照合する。時刻を照合する場合はtime referenceを正規化する前後双方で確認する。

### 14.4 Single-source support

残存・access制約のため信頼できる単一SourceしかないClaimを自動棄却しない。ただしsingle-sourceであることと限界を追跡可能にする。正式な状態ラベルはData Modelで決める。

### 14.5 Potential conflict and formal conflict boundary

日付・位置・front line等の不一致を資料数の多数決だけで決めない。Claim Fitness、作成時点、指揮階梯、独立性、map precision、time basis等を比較し、解消不能なら不一致を保持する。

`potential conflict`は、catalog metadataまたは無料で確認できる二次資料からClaim-specificな反証可能性が合理的に示される一方、対立内容そのものを無料Evidenceで具体的に確認できていない状態を指す。有料Sourceの内容を直接確認した事実として扱わず、値・記述・反証内容を推定しない。materialな反証可能性が残る間、無料Source側を無条件のConfirmed値にしない。

正式なconflictは、無料で確認可能な別Evidenceが対立内容を具体的に裏付ける場合に成立する。正式conflictでは無料Sourceの片側だけを単独確定値にせず、対立するEvidenceと判断根拠を保持する。有料Sourceの所在だけが判明し内容未確認の場合はpotential conflictにもformal conflictにもせず、§6.11の`free-access constraintにより除外された候補Source`としてのみ記録する。

potential conflict、formal conflictおよび最終的なConfirmed / unresolved等の正式状態名・materiality / confidence閾値はHistorical Data ModelまたはHistorical Source Acceptance Policyで確定する。

---

## 15. Numerical Data and Foundation §5

### 15.1 Foundation §5の原則は維持する

比較可能な複数の信頼できる史料について、Foundation §5が定めるArithmetic Mean原則そのものを本Frameworkでは変更しない。

### 15.2 Source independenceは追加適用規則である

Human Project Owner承認方針として、平均前にsource lineage / independenceを確認する。ただしこれはFoundation §5に明記済みの単なる「安全な具体化」ではなく、**Foundationが未規定の論点へ追加する適用規則**であり、算出結果を変えうる。

正式Policyでは少なくとも以下を確定する。

1. **完全な派生重複:** 同一上流原報告を再掲する派生資料は独立観測として平均へ追加せず、可能な場合は上流原典の値を用いる。
2. **部分的独立:** 共通原典に加え独自Evidenceで値を調整した資料の独立性をどう扱うか。
3. **lineage不明:** 独立性を確認できない資料を平均へ入れる条件。
4. **Tier混在:** Tierをまたぐ平均の可否。これは現時点で未規定であり後続Data Model / Policyへ明示的に持ち越す。
5. **平均採用値の状態:** Confirmed / Estimated等のどこへ位置付けるかはData Modelへ持ち越す。

### 15.3 比較不能なら平均しない

killedとtotal casualties、German Army onlyとAxis total、daily lossとoperation total、reported missingとlater confirmed POW、initial strengthとeffective strength等を混ぜない。

---

## 16. Special Handling by Source Type

### 16.1 Operational maps

最低限、map date / situation time、issuing organization、scale、sheet / edition、coordinate/grid system、legend、unit symbol、annotation originを確認する。太いfront lineやsymbolの中心を根拠なく精密座標へ変換しない。

Georeferencingは派生処理であり、§11.8の変換経路・parameter・推定誤差を保持する。

### 16.2 War diaries / Journals of combat operations

日々の経過確認に強いが、記録欠落、後日清書、上級司令部への転記を確認する。

### 16.3 Orders

意図・命令を示すが、実行結果とは分離する。

### 16.4 Situation reports / intelligence

敵情の観測、捕虜尋問、無線傍受、推定等のoriginが分かる場合は保持する。

### 16.5 Strength / casualty reports

reporting cutoff、replacement、hospital return、missing→POW再分類等により数値が変わる。何時点の何を数えた値かを確認する。

### 16.6 Memoirs / postwar testimony

回顧時点、記憶、自己正当化、後知恵を考慮し、単独で精密位置・時刻・損害数を確定する用途には慎重に使用する。

### 16.7 Postwar military studies

所在探索・作戦構造把握に有用だが、戦後作成・依頼目的・自己説明というcontextを保持し、戦時一次史料と同格に扱わない。

---

## 17. OCR / Transcription / Translation

### 17.1 OCR

検索・索引・一次転記支援に利用できるが、OCR textのみでHistorical Dataを確定しない。採用箇所は原画像と照合する。

### 17.2 Transcription

判読不能箇所を推測で補完しない。rights上binaryを保持できない場合、検証可能性を高めるため最小限の逐語引用・構造化転記を検討できるが、その引用・転記自体のrights / privacy条件を確認する。

### 17.3 Translation

原文と翻訳を区別する。重要な軍事用語、部隊名、地名、略号は原語へ戻れるようにする。機械翻訳は調査補助に限定し、採用Claimは原文確認を基本とする。

---

## 18. Rights, Privacy, Access, and Public Repository

### 18.1 Default rule — metadata first / binary opt-in

Public GitHubへ原史料binaryを保存することをデフォルトにしない。rights / privacy条件が確認でき、Project方針上必要な場合のみ保存候補とする。

### 18.2 Adoption-time verification floor and future availability

**採用時点のadoption condition:** 本Frameworkが採用史料について要求する下限は、第三者がprovenance / locatorを用いて史料を再特定でき、かつ遠隔のonline channelから**金銭負担なくEvidence本文・画像を再現可能に確認できること**である。§6.11の適格4類型を満たすことを確認し、access channel、check date、actorおよびfree-access eligibilityを記録する。現地閲覧のみ、有料accessまたは個人限定の再現不能なcopyはHistorical Data確定根拠として採用しない。例外条項は設けない。

**将来にわたるavailability:** 採用時点の条件を満たしたPortalやfree online channelが、将来も公開を継続することまでProjectは保証しない。Portal停止、公開終了、URL変更、source-side / regional restriction等が生じた場合はavailabilityの変化として記録し、合法的な別free online channelを再探索する。過去の採用時条件を満たしていた事実と、現在または将来の到達可能性を混同しない。

### 18.3 Privacy is an independent axis

copyrightが消滅・不存在であっても、個人情報・private-life情報等について別制約がありうる。Public Repositoryへの掲載可否はcopyrightとprivacyを別々に確認する。

### 18.4 Current portal-specific examples

- Bundesarchiv: invenioは検索・デジタル化資料閲覧を提供するが、archive materialに利用制限がありうる。
- NARA RG 242: captured German recordsのmicrofilm seriesとfinding aidsを提供し、公開・出版に関するrights注意を示している。
- Память народа: 2026-08-14再確認時の同portal利用規約は、電子copyの権利者をロシア連邦国防省とし、個別copyの研究利用と大量copy・再配布等を区別している。
- German Documents in Russia: research / education用途と、personal data / private lifeを含む文書の複製・第三者提供に関する制約を掲げている。

これらはStage 1着手時に再確認する。

---

## 19. Phase-aligned Delivery Plan

### 19.1 Stage 0 — Framework Proposal / review

成果物：Framework Proposal（D-1）、Overall Lead review、Human Project Owner decisions、再レビュー。

GitHub **Issue #26** は2026-08-14に起票された親tracking Issueであり、Framework Status、Human Project Owner Decisions、D-IDおよびreview follow-up checklistの同期状態に関するSOTとする。

**GitHub Current State（PMO — Claude Code Sonnetが2026-08-15T00:47:24Z実取得）:** `main` HEADは`6626e7c3aea4c9eb24d0e87a965a5c0c2e0da7e8`、Open Pull Requestは0件、Open Issueは#16 / #24 / #25 / #26である。Issue #16はOPEN・`updated_at 2026-08-14T07:38:53Z`、Issue #24はOPEN・`updated_at 2026-08-14T09:22:37Z`、Issue #25はOPEN・`updated_at 2026-08-14T12:11:14Z`、Issue #26はOPEN・`updated_at 2026-08-15T00:39:54Z`・コメント9件である。Issue #26本文は、対象artifact行がv0.2.3、Deliverables D-1が`現行作業版 v0.2.4`、Framework Statusがv0.2.4 Independent Re-Reviewまで、Human Project Owner DecisionsがHPO-1〜HPO-12 / HPO-R1〜R4までの同期状態であり、v0.2.4 Independent Re-ReviewのSHOULD FIX 2件はfollow-up checklist上で未チェックである。v0.2.5 Independent Re-Review `#issuecomment-5299304890`、HPO-13 / HPO-14決定`#issuecomment-5299352830`、v1.0 Independent Re-Review`#issuecomment-5299527450`およびHPO-15決定`#issuecomment-5299561829`はコメントとして記録済みだが、本文への同期はPMO作業（Issue #26同期および正本登録Pull Requestのtransport）として分離する。本実取得値は、`main` HEAD・Open Pull Request数・Issue #24 / #25の`updated_at`についてOverall Leadが2026-08-15T00:32Zに実測した値と一致することを確認した。Issue #26は本実取得までにHPO-15コメント追加により`updated_at`とコメント数がさらに更新されており、当該差分はIssue #26本文同期作業（PMO担当）で処理する。

HPO-9 / HPO-10の出典は、訂正内容を反映済みのIssue #26本文およびOverall Lead訂正コメント`#issuecomment-5292982327`とする。先行する誤記コメント`#issuecomment-5292851625`は訂正コメントにより上書き済みであり、正しい決定内容の出典として用いない。Current Stateはこの§19.1だけに集約し、他節は本節およびIssue #26を参照する。本改訂へ供給されず実取得もしていない後続値を現在値として扱わない。

FrameworkはHPO-13により承認済みであり、HPO-14および2026-08-15のHuman Project Owner決定に基づく正本登録pathは`docs/research/historical-source-framework_v1.0.md`である。登録Pull Requestのtransport、Issue #26本文同期およびMergeは本改訂と分離する。

### 19.2 Stage 1 — MVP Scope support

Issue #25のために「史料的成立可能性の調査」に限定して実施する。

最初の成果は**Channel Access Feasibility**とし、actor / environmentごとにcatalog、metadata、document image、auth等の到達可能性と§7.1の8観測区分を実測する。remote requestについては、公開手続き、無料条件、第三者一般への適用可否および応答実績を含む再現可能性の判定根拠を記録する。HPO-9のonline free-access-only境界を適用したときにGerman-side Tier 1がどの程度残るかを実測し、German / Soviet channels間のcoverage、Tier構成、時間・部隊・地理粒度および重大な史料空白を比較する。

D-2 `MVP Source Feasibility input`はIssue #25へ渡す判断軸として、Tier 1〜3の見込みだけでなく**online free-access eligibility**、German / Soviet側の証拠強度差、Source不適格理由およびunresolved gapを含める。加えて、部隊位置、front line、都市占領時刻、strength、casualties等のhigh-risk Claim family別に、free-access範囲でbilateral、上級／下級または隣接部隊のいずれによるcorroborationが成立しうるかを実測し、成立しない場合の終端候補（single-source support / Scope縮小 / Unknown / omission）を示す。根拠決定としてIssue #26 / HPO-8 / HPO-9を参照する。

D-2はIssue #25のAcceptance Criteriaを増やす独立必須成果物とはしない。原則として**MVP Scope文書の史料的成立可能性を支える節・annex・review material**として扱い、別文書化する場合は別途scopeを明示する。

Issue #25本文は2026-08-14T12:11:14Zに更新済みであり、Requirements / Acceptance Criteria / Dependenciesへonline free-access eligibility、Issue #26 / HPO-8 / HPO-9参照および無料で必要史料を確保できない場合のScope縮小 / Unknown / omissionを明示している。このAcceptance Criteria拡張はHPO-11に基づくHuman Project Ownerの**明示的拡張**であり、§26.9 R-9が禁じるD-2経由の**暗黙の拡張**とは別である。本Frameworkは現在のIssue #25 Scopeをそれ以上拡張せず、Issue本文の更新も行わない。

個別Historical Dataの正式採用は行わない。

### 19.3 Stage 2 — Historical Data Model

MVP Scope確定後、少数の実在史料を**非正本specimen**として利用し、Source / Evidence / uncertainty / conflict / provenance / rights / time reference / formation instance等を表現できるData Modelを設計する。

Human Project Owner承認条件：

1. specimenをHistorical Datasetへ昇格させない。
2. specimenを`historical/**`へ正式Historical Dataとして配置しない。
3. binaryを扱う場合はrights / privacy確認を適用する。

### 19.4 Stage 3 — Historical Source Acceptance Phase

Foundation §17第5フェーズとして、以下を**同一phase内のprovisional → pilot → formal**で進める。

#### 19.4.1 Stage 3A — Provisional Source Acceptance Policy

Tier境界、Claim Fitness、corroboration、single-source、source independence、negative evidence、rights / privacy、conflict等の暫定Policyを作る。

#### 19.4.2 Stage 3B — Provisional Source Collection SOP / Checklist

Discovery、intake、Evidence extraction、source criticism、Search Log、rights review等の暫定SOPを作る。

#### 19.4.3 Stage 3C — Method Validation Pilot

MVP対象の限定範囲で少なくとも以下3類型を検証する。

1. Spatial claim — 部隊位置またはfront line
2. Temporal/event claim — 作戦・都市占領・戦闘経過等
3. Numerical claim — strength / casualty / equipment loss等

Pilotは歴史的結論だけでなく、provenance保持、Source/Evidence分離、time reference、formation identity、conflict、single-source、negative evidence、rights / privacy、locator、georeferencing、Search Log再現性を検証する。

#### 19.4.4 Stage 3D — Formalization / Exit Gate

Pilotで発見した欠陥をprovisional Policy / SOPへ反映し、重大なTraceability欠陥が残っていないことを確認して正式化する。**Pilot通過をHistorical Source Acceptance Phaseのexit gateとする。**

これにより、正式化後すぐに改訂する手戻りを避ける。

### 19.5 Stage 4 — Technology Selection

Foundation §17第6フェーズ。Stage 3D完了後に開始する。

### 19.6 Stage 5A — MVP Source Inventory / Coverage Assessment

Stage 3D完了後、MVPのClaim familyに対する史料カバレッジを可視化する。Technology Selectionと並行可能とする。

### 19.7 Stage 5B — Production Historical Research

Stage 3D完了後、Policy / SOP / Data Modelに基づきMVP Historical Datasetの研究を開始できる。**Historical Research自体はTechnology Selectionと並行可能**だが、application implementationの順序を変更しない。

### 19.8 Stage 6 — Application Implementation

Foundation §17第7フェーズ。Technology Selection完了を前提とする。

---

## 20. Proposed Deliverables

Cross-document trackingに用いるD-IDは、Project SOTであるGitHub Issue #26本文の`Deliverables`節を正とする。v0.2.2 Proposal §20はD-4〜D-8でIssue #26と分岐していたため、v0.2.3で以下の表をIssue #26基準へ整合させ、v0.2.5でも維持する。v0.2.2で独立D-6としていた`Historical Source Review Checklist`は、D-5 Provisional Collection SOPの構成物として作成し、D-6 Method Validation Pilotで使用・検証する。現時点では独立D-IDを付与しない。

| ID | Deliverable | Purpose | Phase |
|---|---|---|---|
| D-1 | Historical Source Definition & Collection Framework Proposal | 上位Research Framework | Stage 0 |
| D-2 | MVP Source Feasibility input / annex | Issue #25の史料成立性判断支援。Tier見込み、online free-access eligibility、陣営別証拠強度差、high-risk Claim family別corroboration成立見込みと不成立時の終端候補を含む | Stage 1 |
| D-3 | Source / Evidence Information Requirements | Data Model入力要件 | Stage 2 |
| D-4 | Provisional Historical Source Acceptance Policy | Pilot前の暫定採否・史料批判基準 | Stage 3A |
| D-5 | Provisional Collection SOP | 探索・収集・検証の暫定標準手順。Historical Source Review Checklistを構成物として含む | Stage 3B |
| D-6 | Method Validation Pilot Report | Policy / SOP / ModelおよびChecklistの実地検証 | Stage 3C |
| D-7 | Formalized Policy / SOP | Pilot結果を反映した正式Policy / SOP | Stage 3D |
| D-8 | Source Inventory / Production Research work items | 史料充足度・欠落可視化およびMVP Historical Datasetのproduction research追跡 | Stage 5A / 5B |

Issue #26本文のD-ID体系は本表と一致する。D-1の版表記およびreview follow-up checklistを含む現在の同期状態は§19.1を参照し、Issue #26側を実在する最新版へ同期する作業はPMOが担当する。本書はGitHub書き込みを行わない。

正本登録pathはHPO-14および2026-08-15のHuman Project Owner決定により`docs/research/historical-source-framework_v1.0.md`とする。path選定の制約と未決事項は§2.3 / §5を適用する。

---

## 21. Acceptance Criteria for the Overall Framework

本タスク全体は少なくとも以下を満たした時点で「採用資料の定義と収集方法が確立した」と判断する。

1. Tier 1 / 2 / 3 / 補助資料の境界事例を後続Policyで一意に判定できる骨格がある。
2. Source TierとClaim-specific fitnessを分離して評価できる。
3. Source ObjectとAccess Platformを分離できる。
4. 補助資料から原資料へ遡る標準手順がある。
5. Historical DataからEvidence locatorへ逆引きできる。
6. archive / fonds / series / file / page-image-frame等のprovenanceを保持できる。
7. URL変更後もarchive identifier等から再探索可能である。
8. source lineageを追跡し同一原典の二重計上を避けられる。
9. Source independenceがFoundation §5の未規定追加適用規則であることが明示される。
10. 完全重複・部分的独立の正式規則をStage 3で確定できる。
11. Tier混在平均と平均採用値の状態が未決としてData Model / Policyへ引き渡される。
12. §6.6の正準7状態（not searched / not found / non-survival supported / source identified but not acquired / actor-blocked / source-restricted / illegible）を区別でき、conflictを別概念として保持できる。
13. 重要なnegative findingについて検索語・platform・日付・結果を再現可能に記録できる。
14. 「不存在」を検索失敗だけから断定しない。
15. single-source supportを終端状態として扱える。
16. Collection Stop Ruleが無限探索を要求しない。
17. time referenceを原表記と正規化値に分離できる。
18. formation instanceを識別して同名異体を誤接続しない。
19. OCR・翻訳が原史料を置き換えない。
20. map georeferencingの変換経路と誤差を保持できる。
21. rightsとprivacyを別軸で評価できる。
22. metadata-first / binary opt-inでPublic Repositoryを運用できる。
23. 第三者への最低保証がre-locatableであることが明示される。
24. Method Validation PilotでSpatial / Temporal / Numericalの3類型を通す。
25. Research actor / channel capabilityを着手前に実測する。
26. MVP Scope / Data Model / Source Acceptance / Technology Selectionのフェーズ境界を侵食しない。
27. HPO-11に基づくIssue #25 Acceptance Criteriaの明示的拡張と、D-2による無権限の暗黙拡張を区別し、後者を行わない。
28. 別の研究者またはAIが採用判断を独立にレビューできる。
29. 史料不足を推測で補わずworkflowが終端できる。
30. 採用史料が§6.11の適格4類型を満たし、不適格3類型に該当しないことを確認できる。
31. free-access eligibility / exclusionがSource Tierおよび§6.6の正準7状態と別軸で保持される。
32. 除外候補Sourceについてidentifier / locator、access channel、check date、actor、eligibility、exclusion reason、対象Claimとの関係、内容確認状態を追跡でき、remote requestを適格候補とする場合は第三者再現可能性の判定根拠を保持できる。
33. 有料Sourceの所在だけ、Claim-specificな反証可能性、無料Evidenceで具体化された対立を、それぞれexcluded candidate / potential conflict / formal conflictへ一意に区別できる。
34. Stage 1の8観測区分が記録され、Historical Data Modelのcanonical enumとして先取り確定されていない。
35. 現地閲覧のみのSourceをdiscovery / 所在確認には使えるが、Historical Data確定根拠へ採用しない。
36. online無償公開の非対称によるGerman / Soviet側の証拠強度差を、Visualizer側で史実の確かさそのものの差と誤読させないための情報を引き渡せる。
37. Issue #25へ渡すMVP Source Feasibility inputがonline free-access eligibilityを判断軸に含み、Issue #26 / HPO-8 / HPO-9へ追跡でき、high-risk Claim family別のcorroboration成立見込みと不成立時の終端候補を示せる。
38. 採用時点のadoption conditionと、将来にわたるavailabilityを別の主張として扱える。

---

## 22. Major Risks and Mitigations

### 22.1 RISK-1. Digitization asymmetry

**Risk:** online無償公開の範囲は史料の残存状況だけでなくdigitizationの経済・機関別公開方針に依存する。HPO-9の境界下でSoviet-side Tier 1 scanが相対的に多く、German-sideがTier 2〜3へ偏る等の証拠強度差が生じた場合、Visualizer利用者が「ソ連側の記録のほうが本質的に確か」と誤読するおそれがある。  
**Mitigation:** finding aid / archive holdings / inaccessible / unsearchedに加え、陣営別coverage、利用可能Tier、online free-access exclusionおよびunresolved gapを記録する。Stage 1でHPO-9適用後のGerman-side Tier 1残存度とhigh-risk Claim family別のcorroboration成立見込みを実測し、成立しない場合の終端候補とともにVisualizerへ非対称の由来を引き渡す。

### 22.2 RISK-2. Survival bias

**Risk:** 残存文書のみで戦況像を作る。  
**Mitigation:** non-survival evidenceとnot-foundを分離する。

### 22.3 RISK-3. Reporting bias

**Risk:** 戦果・敵損害等が作成主体の利害に影響される。  
**Mitigation:** Claim-centric criticismとopposing-side corroboration。

### 22.4 RISK-4. Duplicate lineage

**Risk:** 同一原典の再引用が多数説に見える。  
**Mitigation:** source lineage / independence。

### 22.5 RISK-5. Precision inflation

**Risk:** 粗いSourceから精密Dataを生成する。  
**Mitigation:** source precision cap、georeferencing error追跡。

### 22.6 RISK-6. OCR / translation error

**Mitigation:** original image verification、原語保持、uncertain transcription。

### 22.7 RISK-7. Link rot / catalog change

**Mitigation:** URLだけでなく正式signatur / archive identifier / access date / finding aid contextを保存する。

### 22.8 RISK-8. Rights / privacy restrictions

**Mitigation:** metadata-first、binary opt-in、privacy独立判定。

### 22.9 RISK-9. Research scope explosion

**Mitigation:** MVP Scope → Claim requirements → targeted collection → Stop Rule。

### 22.10 RISK-10. Research actor access capability

**Risk:** Protocolは正しくてもactorのnetwork / auth / environmentがarchive channelへ到達できず実行不能になる。  
**Mitigation:** Gate 0でchannel別・actor別に実測し、actor-side blockとsource-side restrictionを分離する。SOL / Humanの併用モデルを既定とし、無料登録・別環境確認等はHumanへエスカレーション可能とする。有料accessが必要なSourceは採用候補から除外する。

### 22.11 RISK-11. Paid-source dependency

**Risk:** MVP ScopeやHistorical Datasetが、有料会員登録・購入・閲覧料・複写料等を支払わなければ検証できない史料へ依存し、第三者検証性と継続運用性を損なう。  
**Mitigation:** §6.11を採用必須条件とし、Gate 0 / Source FeasibilityでEvidence本文・画像までのonline free-accessを実測する。有料・現地閲覧のみ・再現不能な個人限定Sourceはdiscovery / candidate記録に留め、Historical Data確定根拠には採用しない。候補の存在だけでconfidenceを自動的に下げず、Claim-specificな反証可能性と無料Evidenceで確認できるformal conflictを区別する。

---

## 23. Human Project Owner Decisions Reflected in v1.0

2026-08-14〜15、Human Project OwnerはHPO-1〜HPO-15およびHPO-R1〜R4を決定した。決定およびFramework同期状態のGitHub SOTは **Issue #26** とし、Current Stateは§19.1を参照する。HPO-9 / HPO-10の正しい内容は、訂正内容を反映済みのIssue #26本文およびOverall Lead訂正コメント`#issuecomment-5292982327`を出典とする。先行する誤記コメント`#issuecomment-5292851625`は訂正コメントにより上書き済みであり、矛盾する場合はIssue本文および訂正コメントを正とする。

HPO-13 / HPO-14の正しい記録はIssue #26コメント`#issuecomment-5299352830`とする。v0.2.5 Overall Lead Independent Re-Reviewは`#issuecomment-5299304890`として投稿済みであり、その`APPROVE`はIntegration判断である。Framework承認はHPO-13により別途成立している。Issue #26本文のFramework Status、D-1、HPO-13 / HPO-14およびfollow-up checklistの同期はPMO作業として分離し、本書では完了済みと推定しない。

### 23.1 HPO-1 — Research actor

**Approved:** SOL + Humanの併用。SOLは通常のOrientation / public archive researchを担当する。無料登録・別環境確認等で対応可能な無料SourceはHumanへエスカレーションできる。有料accessが必要なSourceは購入判断へエスカレーションせず採用対象外とする。各channelの実capabilityは毎回実測する。

### 23.2 HPO-2 — Governance freeze / path

**Approved:** pathでfreezeを迂回しない。Issue #24に対応するPull Request #27は2026-08-14にMergeされ、`main` Policy §15の解除条件はIssue #25に対応するPull RequestのHuman Project OwnerによるMergeへ更新済みである。正本配置は、その時点の`main`とgovernance状態を再取得して決定する。

### 23.3 HPO-3 — Source independence

**Approved:** Source independence原則を採用する。ただしFoundation §5の「安全な具体化」ではなく、未規定論点への追加適用規則として扱う。

### 23.4 HPO-4 — Model-design specimens

**Approved with conditions:** 正式Datasetへ昇格させない、`historical/**`へ正式データとして置かない、rights / privacy確認を行う。

### 23.5 HPO-5 — Pilot before formalization

**Approved:** provisional Policy / SOP → Pilot → formalizationとし、PilotをHistorical Source Acceptance Phaseのexit gateとする。

### 23.6 HPO-6 — Stage 4〜7とTechnology Selection

**Approved:** Source Acceptance Phase完了後、Technology Selectionへ進む。Source Inventory / Production Historical Researchはその後Technology Selectionと並行可能とする。Application implementationのFoundation順序は変更しない。

### 23.7 HPO-7 — Issue structure

**Approved:** Framework用の親Issueを設け、その後Stage単位へ分割する。親Issue #26は起票済みである。正本path確定はgovernance状態再確認後に行う。

### 23.8 HPO-8 — Free-access-only source constraint

**Approved:** Historical Dataの根拠として採用する史料は、Evidence本文・画像を第三者が金銭負担なく確認できるものに限定する。無料アカウント登録は許容する。有料会員登録、subscription、購入、閲覧料、download料、複写注文等が必要な史料は採用不可とする。metadataだけ無料でEvidence本体が有料の場合も採用不可とする。

### 23.9 Re-Review decisions — HPO-R1〜R4

GitHub Issue #26に以下を記録済みである。

- **HPO-R1:** HPO-1〜7の承認を再確認。Issue #26をGitHub上の決定記録先とする。
- **HPO-R2:** v0.2 Overall Lead Re-ReviewのSHOULD FIX 6件はfollow-up管理とし、`v0.2 Re-Review / SHOULD FIX-A`のみStage 1前に先行修正する。
- **HPO-R3:** 親Issueを先に起票し、正本path / 文書登録はgovernance状態確認後に行う。
- **HPO-R4:** Stage 1の史料成立可能性調査はSOL + Human併用で開始可能。ただしHPO-8により有料Sourceは採用不可。

### 23.10 HPO-9 — Online free-access eligibility boundary

**Decided 2026-08-14 / Human Project Owner / Option (a) adopted:** 例外条項は設けない。

- Historical Data確定根拠として適格なのは、公開online access、無料登録後のonline access、第三者にも同条件で再現可能な無料remote request、および同一Source Objectの合法的な別free online channelである。
- 有料access、現地閲覧のみ、特定個人だけの再現不能なaccessは不適格である。
- 現地閲覧のみのSourceはdiscovery / 所在確認 / 将来候補の記録には使えるが、Historical Data確定根拠には採用しない。rights条件を満たす複製が合法的かつ安定的なfree online channelで公開された場合は、そのchannelを別途Gate判定する。
- Gate 0 / Stage 1では§7.1の8区分を観測する。これはData Modelのcanonical enumではない。

### 23.11 HPO-10 — Excluded candidate source and conflict handling

**Decided 2026-08-14 / Human Project Owner / Option (a) adopted with clarification:** §6.6の正準7状態へ第8状態を追加せず、独立したaccess eligibility / exclusion recordを設ける骨格を採用する。

1. 有料Sourceの所在だけ判明し内容未確認の場合、excluded candidateとして記録し、存在だけでconfidenceを自動的に下げず、内容・値を推定しない。
2. 無料metadata / 二次資料からClaim-specificな反証可能性が合理的に示される場合、potential conflictとして保持する。materialな可能性が残る間、無料Source側を無条件のConfirmed値にしない。
3. 無料Evidenceが対立内容を具体的に裏付ける場合、§14.5のformal conflictとして保持し、片側だけを単独確定しない。

全Claimを「有料Sourceが存在する」という一般的事実だけで一律にsingle-source supportまたはlower-confidenceへ落とさず、探索量の多寡をconfidenceへ混入させない。正式field名、enum、final stateおよび閾値は後続Data Model / Policyへ留保する。

### 23.12 HPO-11 — Issue #25 relationship

**Decided 2026-08-14 / Human Project Owner:** Issue #25へIssue #26 / HPO-8 / HPO-9を参照させ、「史料を確保できる見込み」の判断軸へTier 1〜3だけでなくonline free-access eligibilityを含める。Proposal側のD-2 MVP Source Feasibility inputも同じ判断軸と参照関係を持つ。

Issue #25本文は2026-08-14T12:11:14Zに更新済みであり、Requirements / Acceptance Criteria / Dependenciesへonline free-access eligibilityとIssue #26 / HPO-8 / HPO-9参照を反映している。この更新はHPO-11に基づくHuman Project Owner権限下の明示的なAcceptance Criteria拡張であり、D-2がIssue #25 Scopeを独自に広げる暗黙の拡張ではない。Proposal側は現在のIssue #25 Scopeを所与とし、それ以上の本文更新またはScope拡張を行わない。

### 23.13 HPO-12 — v0.2.1 disposition and v0.2.2 path

**Decided 2026-08-14 / Human Project Owner / Option (a) adopted:** v0.2.1を差し戻し、`v0.2.1 2nd Re-Review / MUST FIX-A〜D`、`v0.2.1 2nd Re-Review / SHOULD FIX-A〜D`および`v0.2.1 2nd Re-Review / FOLLOW-UP-A〜B`を反映したv0.2.2を作成する。v0.2.2はOverall Leadの独立再レビューへ渡し、その後にHuman Project Ownerが承認を判断する。実装担当GPT SOLは自己実装をIndependent Reviewで自己承認しない。

### 23.14 HPO-13 — Framework approval

**Decided 2026-08-15 / Human Project Owner:** Framework Proposal v0.2.5（SHA-256 `04c5a4ff50f4d4f3456f3eae3f09d511538315e6e657dae72854df205f9fa60b`）を承認する。記録先はIssue #26コメント`#issuecomment-5299352830`である。

この承認は、(1) Stage 0のD-1内容、(2) §6 P-1〜P-11、§7のworkflow、§10〜§18、§19のStage体系、§21 AC 1〜38、§26 R-1〜R-14、§27 C-1〜C-10および§28の検証体系を上位Research Frameworkとして採用すること、(3) 承認済みFrameworkおよびHPO-R4の条件下でStage 1へ進めることを確定する。

この承認は、Historical Data Modelのschema・ID・status・canonical timezone・storage、Historical Source Acceptance Policyの詳細基準・閾値、Project Foundationの改訂、MVP対象期間・作戦・粒度、Repositoryへの登録完了、方法論文書と実Historical Dataのpath分離、またはFoundation §17のフェーズ順序変更を確定しない。

### 23.15 HPO-14 — Canonical registration path policy

**Decided 2026-08-15 / Human Project Owner:** HPO-13承認済みFrameworkを非governance pathへ先行登録する。記録先はIssue #26コメント`#issuecomment-5299352830`である。その後のHuman Project Owner決定により、版をv1.0、登録先を`docs/research/historical-source-framework_v1.0.md`とする。

Overall LeadがHPO-14へ付した条件を次のとおり保持する。

1. top-levelの`historical/**`を本Frameworkの登録先にしない。
2. path選定の実体的理由を登録Pull Requestへ記録し、governance freezeの迂回を理由にしない。本FrameworkはHistorical Researchの方法論文書であり、役割・権限・Merge条件を定めるgovernance文書ではない。
3. 本登録はPolicy §15のgovernance freezeを解除せず、例外規定も援用しない。
4. HPO-14決定時点では具体的pathを先取り確定せず、後続のHuman Project Owner決定で`docs/research/`を選定した。方法論文書と実Historical Dataのpath分離は未決事項として保持する。
5. 後続フェーズで本Frameworkがgovernance性を帯びる場合は、その時点の正本規則に従ってpathを見直しうる。

### 23.16 HPO-15 — v1.0実装担当の変更

**Decided 2026-08-15 / Human Project Owner.** Codex Cloudがファイルの受け渡しに対応せず改訂元v0.2.5を供給できないため、案1（Codex実装）を置き換え、v1.0の実装担当をPMOとする。Independent ReviewはGPT SOLが担当し、実装担当と分離されるためmerge-authority §2.6の例外を要しない。記録先はIssue #26コメント`#issuecomment-5299561829`である。

---

## 24. Review Disposition Matrix — Overall Lead Review History 2026-08-14〜15

本Matrixは、v0.1 Overall Lead Review、v0.2 Overall Lead Re-Review、v0.2.1 Overall Lead 2nd Re-Review、v0.2.2 Overall Lead Independent Re-Review、v0.2.3 Overall Lead Independent Re-Review、v0.2.4 Overall Lead Independent Re-Review、v0.2.5 Overall Lead Independent Re-Review、v1.0 Overall Lead Independent Re-Review、v1.0 Overall Lead 2nd Independent Re-Reviewの9回を区別し、各指摘の処理先または明示的follow-upを追跡する。過去Reviewの件数と判定を現在版の承認状態と混同しない。

Review findingの正準識別表記は`<Reviewed version> <Review type> / <original finding ID>`とする。各Reviewで付与されたoriginal ID自体は変更せず、回次修飾を前置して衝突を解消する。§24外からfindingを参照する場合も回次修飾を省略しない。

### 24.1 v0.1 Overall Lead Review — CHANGES_REQUIRED

内訳：`BLOCKER 1 / MUST FIX 8 / SHOULD FIX 10 / FOLLOW-UP 6`

#### 24.1.1 BLOCKER

| ID | Disposition |
|---|---|
| v0.1 Review / BLOCKER-1 Research actor / archive access capability | §7.1 Gate 0、§22.10 RISK-10、§23.1へ反映。SOL / Human併用とchannel別実測を明記。actor環境のblockをProject全体へ一般化しない。 |

#### 24.1.2 MUST FIX

| ID | Disposition |
|---|---|
| v0.1 Review / MUST FIX-1 節番号不整合 | v0.2で全小節を親節番号へ再採番し、相互参照を再構成。 |
| v0.1 Review / MUST FIX-2 governance freeze / path | §2.3、§5、§20、§23.2。pathによる迂回禁止。Issue #24対応Pull Request #27のMerge後状態へ更新。 |
| v0.1 Review / MUST FIX-3 Source independence評価 | §6.5、§15、§23.3。「追加適用規則」へ訂正し、完全重複・部分独立をStage 3確定対象化。 |
| v0.1 Review / MUST FIX-4 Stop Rule終端なし | §9.9へsingle-source / Unknown終端とSearch Log記録を追加。 |
| v0.1 Review / MUST FIX-5 Negative evidence二重定義 / 再現性 | §6.6と§13へ単一概念集合を定義し、conflictを分離。重要not-foundでは検索語等を逐語必須化。 |
| v0.1 Review / MUST FIX-6 time reference欠落 | §10.5、§11.4、§14.3へ追加。 |
| v0.1 Review / MUST FIX-7 Tier境界規則なし | §12を新設し、surrogate / edited publication / translation / unprovenanced scanの骨格を定義。 |
| v0.1 Review / MUST FIX-8 Память народа典拠 | Appendix A-3を`pamyat-naroda.ru/agreement/`へ修正し、2026-08-14再確認結果を反映。 |

#### 24.1.3 SHOULD FIX

| ID | Disposition |
|---|---|
| v0.1 Review / SHOULD FIX-1 Pilot前正式化 | §19.4でprovisional → Pilot → formalizationへ変更。 |
| v0.1 Review / SHOULD FIX-2 Stage 4〜7 / §17関係 | §19全体を再編し、Technology Selectionとの並行可否を明記。 |
| v0.1 Review / SHOULD FIX-3 P-6 normative wording | §6.6をData Modelへの提案として表現。 |
| v0.1 Review / SHOULD FIX-4 不存在主張 | §6.6、§13.3で積極的Evidenceを要求。 |
| v0.1 Review / SHOULD FIX-5 formation instance | §9.1、§10.9、§11.1へ追加。 |
| v0.1 Review / SHOULD FIX-6 verification floor | §1、§18.2で採用時点のre-locatable / online free-accessを最低条件化。 |
| v0.1 Review / SHOULD FIX-7 privacy | §6.8、§11.7、§18.3へ独立軸として追加。 |
| v0.1 Review / SHOULD FIX-8 georeferencing | §11.8、§16.1へ変換経路・parameter・誤差を追加。 |
| v0.1 Review / SHOULD FIX-9 D-2 / Issue #25 | §19.2、§20でMVP Scope支援inputとしACを増やさないと明記。 |
| v0.1 Review / SHOULD FIX-10 finding aid | §8へBundesarchiv / NARA / Soviet finding aid layerを追加。 |

#### 24.1.4 FOLLOW-UP

| ID | Disposition / tracking destination |
|---|---|
| v0.1 Review / FOLLOW-UP-1 path分類中間領域 | §5、§23.2。方法論文書と実Historical Dataのpath分離を後続決定。 |
| v0.1 Review / FOLLOW-UP-2 史料粒度とclient制約の突合責任 | Stage 1は史料側inputのみ。最終粒度決定はIssue #25 / Human Project Owner側に残す。 |
| v0.1 Review / FOLLOW-UP-3 Tier混在平均 | §15.2で明示的未決事項として保持。 |
| v0.1 Review / FOLLOW-UP-4 状態モデル統合 | §6.6、§14.4、§15.2からHistorical Data Modelへ引き渡す。 |
| v0.1 Review / FOLLOW-UP-5 Appendix A再確認 | Appendix A冒頭と§18.4でStage 1着手時再確認を必須化。 |
| v0.1 Review / FOLLOW-UP-6 Proposal登録Issueなし | §19.1、§23.7。親Issue #26を起票済み。正本登録は別作業。 |

### 24.2 v0.2 Overall Lead Re-Review — CHANGES_REQUIRED

内訳：`BLOCKER 0 / MUST FIX 1 / SHOULD FIX 6 / FOLLOW-UP 3`

| Class / ID | Finding | Disposition / tracking destination |
|---|---|---|
| v0.2 Re-Review / MUST FIX-A | HPO-1〜HPO-7承認のGitHub記録欠落 | Issue #26本文へHPO-1〜HPO-12 / HPO-R1〜R4を記録済み。§23でProposalとのTraceabilityを保持。解消。 |
| v0.2 Re-Review / SHOULD FIX-A | §21 / §28のnegative evidence列挙が§6.6の7状態と不一致 | v0.2.1で§21 / §28を修正し、v0.2.2でも維持。解消。 |
| v0.2 Re-Review / SHOULD FIX-B | v0.1→v0.2のStage番号体系再編の明示 | Issue #26のStage 3Aまでのfollow-upとして保持。正式化時のhistory記録先で処理。 |
| v0.2 Re-Review / SHOULD FIX-C | time basisのstated / inferred / unknown区分 | §11.4の情報要件を基礎とし、正式値域はHistorical Data Model / Stage 3Aへ留保。Issue #26 follow-up。 |
| v0.2 Re-Review / SHOULD FIX-D | sole surviving witnessの骨格 | 原本非残存・所在不明時の複製／刊行版規則をStage 3Aへ留保。Issue #26 follow-up。 |
| v0.2 Re-Review / SHOULD FIX-E | Application Implementation前提となるMVP Historical Dataset成立 | Foundation §17を変更せず、Stage 3Aまでにexit conditionとして具体化する。Issue #26 follow-up。 |
| v0.2 Re-Review / SHOULD FIX-F | Requirements / Acceptance Criteria / Testの三重化 | 本版では§28.15に対応参照を追加。R-ID中心の正式整理はStage 3A / Issue #26 follow-up。 |
| v0.2 Re-Review / FOLLOW-UP-A | NARA T77をv0.2で除外した理由 | Issue #26で確認・記録を継続。未解決。 |
| v0.2 Re-Review / FOLLOW-UP-B | Gate 0 capability記録の継続的保持先 | §11.2の情報要件をData Modelへ引き渡し、正式保持先は同設計で確定。未解決。 |
| v0.2 Re-Review / FOLLOW-UP-C | Stage 1調査開始とIssue #24 → #25 Pull Request順序 | §19.1 / §19.2および§23.2で区別。Pull Request #27はMerge済み。Issue #25進行時に再確認。 |

### 24.3 v0.2.1 Overall Lead 2nd Re-Review — CHANGES_REQUIRED

内訳：`BLOCKER 0 / MUST FIX 4 / SHOULD FIX 4 / FOLLOW-UP 2`

| Class / ID | Finding | Disposition through v0.2.3 |
|---|---|---|
| v0.2.1 2nd Re-Review / MUST FIX-A | free-access除外とconflict | §6.6 / §6.11 / §11.2 / §14.5 / §18.2 / R-12〜R-13 / C-9 / AC 31〜33 / T-12〜T-13。7状態へ第8状態を追加せず、独立access recordと3段階境界を反映。 |
| v0.2.1 2nd Re-Review / MUST FIX-B | online free-access境界 | §6.11 / §7.1 / §11.2 / §18.2 / R-11 / C-8 / AC 30・34・35 / T-11。適格4類型、不適格3類型、on-site-only処理、8観測区分、例外なしを反映。v0.2→v0.2.1でGPT SOLがHuman側担当から「現地閲覧」を削除した時点ではHPO-9未決定かつ明示根拠なしだったこと、現行記述はHPO-9により事後的に正当化・正式化されたことを§7.1へ追記。 |
| v0.2.1 2nd Re-Review / MUST FIX-C | Issue #25との関係 | §19.2 / §20 D-2 / §23.12 / R-14 / AC 37 / T-14。online free-access eligibilityとIssue #26 / HPO-8 / HPO-9参照を追加。Issue #25本文は2026-08-14T12:11:14Zに更新済みであり、HPO-11による明示的AC拡張とD-2による暗黙拡張禁止を区別。 |
| v0.2.1 2nd Re-Review / MUST FIX-D | Appendix B末尾CommonMark defect | 過去自己レビュー本文とthematic breakの間に空行を確保し、文書全体の同型箇所をT-1 / 機械検証で確認。 |
| v0.2.1 2nd Re-Review / SHOULD FIX-A | free-accessによるGerman / Soviet証拠強度差 | §6.9 P-9 / §7.1 / §19.2 / §22.1 RISK-1 / R-14 / AC 36 / T-3・T-14へ反映。 |
| v0.2.1 2nd Re-Review / SHOULD FIX-B | §18.2 adoption conditionとfuture availability | §18.2を2つの主張へ分離し、AC 38 / T-15で検証。 |
| v0.2.1 2nd Re-Review / SHOULD FIX-C | Review Matrix / T-2がv0.1のみ | 本§24へ3 Review分を追加し、§28.2を全3回対象へ更新。 |
| v0.2.1 2nd Re-Review / SHOULD FIX-D | §25早期固定原則のfree-access欠落 | §25へonline free-access-onlyとaccess axis分離を追加。 |
| v0.2.1 2nd Re-Review / FOLLOW-UP-A | Appendixの時系列不明瞭 | Appendix B〜Oを、v0.2 self-review → v0.2.1 correction / self-review / 2nd Re-Review・HPO decisions → v0.2.2 self-review / Independent Re-Review → v0.2.3 self-verification / Independent Re-Review → v0.2.4 self-verification / Independent Re-Review → v0.2.5 self-verification / Independent Re-Review → HPO-13 / HPO-14 decisions → v1.0 self-verificationの順に整理。過去自己レビューの実質的内容は維持し、回次修飾IDだけを明確化。Appendix追加時の範囲・時系列同期を恒常的な確認項目とする。 |
| v0.2.1 2nd Re-Review / FOLLOW-UP-B | registration / request / on-site / paidの正式値域 | §7.1 / §11.2でStage 1観測区分を明記し、正式field / enumはHistorical Data Modelへ留保。 |

### 24.4 v0.2.2 Overall Lead Independent Re-Review — CHANGES_REQUIRED

内訳：`BLOCKER 0 / MUST FIX 3 / SHOULD FIX 4 / FOLLOW-UP 2`

| Class / ID | Finding | Disposition in v0.2.3 / tracking destination |
|---|---|---|
| v0.2.2 Independent Re-Review / MUST FIX-1 | v0.2 §7.1から「現地閲覧」を削除した経緯が未記録 | §7.1および§24.3へ、時期（v0.2→v0.2.1改訂時、2026-08-14）、実施主体（GPT SOL）、当時の明示根拠なし、HPO-9による事後的正当化・正式化を記録。Overall Leadがv0.2.3 Reviewで解消を確認。 |
| v0.2.2 Independent Re-Review / MUST FIX-2 | Issue #25 / #26現在状態との乖離 | §19.1 / §19.2 / §23冒頭 / §23.12 / §24.2 / C-10を、Review時点のIssue #26 `updated_at 2026-08-14T12:10:42Z`およびIssue #25 `updated_at 2026-08-14T12:11:14Z`へ同期。HPO-9 / HPO-10はIssue #26本文と訂正コメントを出典化し、誤記コメントの上書き関係を維持。Overall Leadがv0.2.3 Reviewで解消を確認。 |
| v0.2.2 Independent Re-Review / MUST FIX-3 | ProposalとIssue #26のD-ID体系不一致 | §20でGitHub SOT上のIssue #26 D-IDを正と明示し、D-4〜D-8を整合。Review ChecklistはD-5の構成物・D-6の検証対象とし独立D-IDを付与しない。Issue #26 D-1版表記等の同期はPMO作業として記録。Overall Leadがv0.2.3 Reviewで解消を確認。 |
| v0.2.2 Independent Re-Review / SHOULD FIX-1 | §6.11とFoundation §2優先順位の関係未記述 | §2.1へ、free-access制約は網羅性を削りトレーサビリティを強化するが、劣位史料・推測によって史実性を下げないことを追記。R-1を本文上で支える。 |
| v0.2.2 Independent Re-Review / SHOULD FIX-2 | reproducible remote request判定根拠の記録要件欠落 | §7.1 / §11.2 / R-12 / AC 32 / T-11 / T-12へ、公開手続きlocator、無料条件、第三者一般への適用可否、応答実績等の記録要件を追加。正式field名・値域はData Modelへ留保。 |
| v0.2.2 Independent Re-Review / SHOULD FIX-3 | high-risk Claimのcorroboration成立見込みがStage 1実測対象外 | §7.1 / §19.2 / §20 D-2 / §22.1 / R-14 / AC 37 / T-3 / T-14へ、Claim family別のbilateral・上下級・隣接部隊corroboration成立見込みと不成立時の終端候補を追加。 |
| v0.2.2 Independent Re-Review / SHOULD FIX-4 | Issue #25 ACの明示的拡張と暗黙拡張の区別欠落 | §19.2 / §23.12 / R-9 / C-10 / AC 27へ、HPO-11に基づく明示的拡張とD-2経由の無権限な暗黙拡張禁止を区別して記録。 |
| v0.2.2 Independent Re-Review / FOLLOW-UP-1 | §11.9 Integrity metadataのchecksum対象未定 | binary非保持時のchecksum対象はHistorical Data Model設計時に確定する。未解決として保持。 |
| v0.2.2 Independent Re-Review / FOLLOW-UP-2 | NARA T77の扱い | v0.2 Re-Review / FOLLOW-UP-Aを継続し、Issue #26 follow-up checklistで保持する。本文§24.2の未解決状態を維持。PMO同期対象。 |

### 24.5 v0.2.3 Overall Lead Independent Re-Review — APPROVE

内訳：`BLOCKER 0 / MUST FIX 0 / SHOULD FIX 2 / FOLLOW-UP 1`

Overall LeadのIntegration Decisionは`APPROVE`である。v0.2.2 Independent Re-ReviewのMUST FIX 3件・SHOULD FIX 4件がすべて解消し、既存FOLLOW-UP 2件が適切に保持されていることを確認した。本判定はFramework承認ではなく、Human Project Ownerの承認判断を代替しない。

| Class / ID | Finding | Disposition in v0.2.4 / tracking destination |
|---|---|---|
| v0.2.3 Independent Re-Review / SHOULD FIX-1 | §2.1のFoundation節参照が不正確 | §2.1を「Foundation §2の品質優先順位および§4の史料Tier順位」へ訂正。論旨とR-1の関係は変更しない。反映済み。 |
| v0.2.3 Independent Re-Review / SHOULD FIX-2 | Review finding IDがReview回次間で衝突 | §24に正準回次修飾形式を定義し、全Review Matrix IDおよびAppendix H.1の参照へ回次を明示。original finding IDと実質的な過去自己レビュー内容は維持。反映済み。 |
| v0.2.3 Independent Re-Review / FOLLOW-UP-1 | §24.3 FOLLOW-UP-AのAppendix範囲が現状と不一致 | 次回改訂に当たる本v0.2.4で§24.3をAppendix B〜Jの実構成と時系列へ更新。反映済み。 |

Overall Leadはv0.2.2 / v0.2.3 Independent Re-ReviewをIssue #26コメント`#issuecomment-5293751543` / `#issuecomment-5293761279`として投稿済みである。Issue #26をFramework同期状態のSOTとし、現在の取得値と本文同期状態は§19.1を参照する。未取得の後続値を推測しない。

### 24.6 v0.2.4 Overall Lead Independent Re-Review — APPROVE

内訳：`BLOCKER 0 / MUST FIX 0 / SHOULD FIX 2 / FOLLOW-UP 0`

Overall LeadのIntegration Decisionは`APPROVE`である。新規指摘はmetadata / 記録同期に限定され、Frameworkの規定内容、判定境界、フェーズ境界およびDeliverable体系を変更しない。本判定はFramework承認ではなく、Human Project Ownerの承認判断を代替しない。

| Class / ID | Finding | Disposition in v0.2.5 |
|---|---|---|
| v0.2.4 Independent Re-Review / SHOULD FIX-1 | Appendix B.3にOverall Lead finding IDの回次修飾欠落が残存 | `v0.1 Review / BLOCKER-1`へ回次修飾し、過去自己レビューの件数・評価・処理内容は変更しない。反映済み。 |
| v0.2.4 Independent Re-Review / SHOULD FIX-2 | header `Related`のReview round / HPO列挙が不完全 | 6 round、HPO-1〜HPO-12・HPO-R1〜R4およびGitHub記録済み3 Reviewのコメント識別子を列挙。反映済み。 |

Review本体はIssue #26コメント`#issuecomment-5299189860`へ投稿済みである。Issue #26をFramework同期状態のSOTとし、現在の取得値と本文同期状態は§19.1を参照する。未取得の後続値を推測しない。新規FOLLOW-UPはない。

### 24.7 v0.2.5 Overall Lead Independent Re-Review — APPROVE

内訳：`BLOCKER 0 / MUST FIX 0 / SHOULD FIX 0 / FOLLOW-UP 1`

Overall LeadのIntegration Decisionは`APPROVE`である。v0.2.4 Independent Re-ReviewのSHOULD FIX 2件が解消し、過去Review分に退行がないことを確認した。本判定はIssue #26コメント`#issuecomment-5299304890`に記録されている。本判定自体はFramework承認ではなく、Human Project OwnerによるHPO-13の承認と区別する。

| Class / ID | Finding | Disposition in v1.0 |
|---|---|---|
| v0.2.5 Independent Re-Review / FOLLOW-UP-1 | Issue #26のsnapshotを複数節で反復保持し、投稿・同期のたびに陳腐化する | GitHub Current Stateを取得時刻付きで§19.1へ集約し、§20 / §23 / §24.5 / §24.6は§19.1およびIssue #26を参照する。Issue #26をFramework同期状態のSOTと明示し、未取得値を現在値として扱わない。Appendix K等の過去Review時実取得値は当時の事実記録として維持する。反映済み。 |

### 24.8 v1.0 Overall Lead Independent Re-Review — CHANGES_REQUIRED

内訳：`BLOCKER 0 / MUST FIX 1 / SHOULD FIX 3 / FOLLOW-UP 0`

Overall LeadのIntegration Decisionは`CHANGES_REQUIRED`である。v1.0初稿（Codex作成、artifact SHA-256 `7187a6eb5ec51540c93bf4e61994ddb7d65af5b9a39413b8cb2dedf9e61a37ca`）に対する独立再レビューであり、HPO-13承認対象であるv0.2.5に承認された規定内容への退行は検出されなかった。本判定はIssue #26コメント`#issuecomment-5299527450`に記録されている。

| Class / ID | Finding | Disposition in v1.0（PMO修正版） |
|---|---|---|
| v1.0 Independent Re-Review / MUST FIX-1 | Appendix Oの実装担当記載がheader `Prepared by`と矛盾し、merge-authority §2.6の充足根拠を毀損する | 見出しをPMO Document-Implementer Verificationへ改め、担当分離表と作成経緯を追記し、O.2をHPO-15反映済みへ更新した。反映済み（HPO-15によりv1.0の実装担当がCodexからPMOへ変更されたため、記載主体もPMOとした）。 |
| v1.0 Independent Re-Review / SHOULD FIX-1 | `Prepared by`が単一主体表記でv0.1〜v0.2.5の著述主体を落としている | GPT SOL（v0.1〜v0.2.5の著述）/ Codex（v1.0初稿）/ PMO — Claude Code Sonnet（v1.0正本登録版の実装）の3者を区別する表記へ改めた。反映済み。 |
| v1.0 Independent Re-Review / SHOULD FIX-2 | §19.1のCurrent Stateに取得主体・取得時刻が記載されていない | 「PMO — Claude Code Sonnetが2026-08-15T00:47:24Z実取得」と明記した。反映済み。 |
| v1.0 Independent Re-Review / SHOULD FIX-3 | §2.1 / §2.2 / §13.1 / §15.1 / §19.2の自称が「本提案」「本Proposal」のまま残存 | 指定5箇所を「本Framework」へ統一した。反映済み。 |

Review本体はIssue #26コメント`#issuecomment-5299527450`へ投稿済みである。当該指摘の反映はHPO-15によりPMOが担当した。

### 24.9 v1.0 Overall Lead 2nd Independent Re-Review — CHANGES_REQUIRED

内訳：`BLOCKER 0 / MUST FIX 2 / SHOULD FIX 2 / FOLLOW-UP 0`

Overall LeadのIntegration Decisionは`CHANGES_REQUIRED`である。§24.8の指摘4件はすべて解消したことを確認した一方、HPO-15反映に伴うheader `Related`・§23冒頭列挙の不整合、および指示書task IDの正本本文への漏出を新規に検出した。本判定はIssue #26コメント`#issuecomment-5299722931`に記録されている。

| Class / ID | Finding | Disposition in v1.0（本改訂） |
|---|---|---|
| v1.0 2nd Independent Re-Review / MUST FIX-1 | HPO-15がheader `Related`および§23冒頭の列挙から欠落し、§23内部で自己矛盾していた | §23冒頭を「HPO-1〜HPO-15」へ更新し、header `Related`へHPO-15、v1.0 Independent Re-Review round、`#issuecomment-5299527450`、`#issuecomment-5299561829`を追加した。反映済み。 |
| v1.0 2nd Independent Re-Review / MUST FIX-2 | 指示書のtask ID（`A-0` / `A-4` / `B-1`）が正本本文へ漏出し、うち2件が無関係な実在見出しへ誤解決していた | §19.1・Appendix O.6の3箇所を、外部の一過性文書に依存しない本文書内で自己完結する記述へ置き換えた。反映済み。 |
| v1.0 2nd Independent Re-Review / SHOULD FIX-1 | §24にv1.0 roundのdisposition行がなく、§28.2 T-2が7 roundのままであった | 本節（§24.8 / §24.9）を追加し、§24冒頭の round数を9回へ更新し、§28.2 T-2の列挙を(1)〜(9)へ更新した。反映済み。 |
| v1.0 2nd Independent Re-Review / SHOULD FIX-2 | §19.1に自称「本Proposal」が1件残存していた | 「成果物：本Proposal、…」を「成果物：Framework Proposal（D-1）、…」へ改め、自己を指さない表現とした。反映済み。 |

Review本体はIssue #26コメント`#issuecomment-5299722931`へ投稿済みである。当該指摘の反映はHPO-15によりPMOが担当した。次のOverall Lead独立再レビューで`MUST FIX 0`であればIntegration Decisionとして`APPROVE`となる。

`MUST FIX 0 / SHOULD FIX 0`で終端するAPPROVE roundは、文書改訂を伴わないため本節へ行を追加せず、正本登録Pull RequestのIntegration DecisionおよびIssue #26を記録先とする。

---

## 25. Recommendation

本FrameworkはHPO-13により承認された上位Research Frameworkとして、Stage 1以降のHistorical Source研究、Historical Data ModelおよびHistorical Source Acceptance Phaseを進める際の基準に適用する。v0.2.5に対するOverall Leadの`APPROVE`はIntegration判断であり、それ自体をFramework承認と扱わない。Framework承認の根拠はHuman Project OwnerのHPO-13である。

早期に固定すべき原則は以下である。

1. Source TierとClaim Fitnessを分離する。
2. Source ObjectとAccess Platformを分離する。
3. Source lineage / independenceを保持する。
4. Negative evidence / access failure / conflictを別概念として保持する。
5. Source precisionを超える精度を生成しない。
6. Research capabilityをactor別に実測してから実行する。
7. Historical Data確定根拠をonline free-access-onlyとし、例外を設けない。
8. free-access eligibility / exclusionをTier、§6.6の正準7状態およびconfidenceと別軸で保持する。

一方、具体的ID形式、status enum、storage schema、採点方式、canonical timezone、Tier混在平均、平均採用値の状態、部分的独立の算術処理等は、Foundation §17に従い後続フェーズへ残す。

---


## 26. Requirements

本Frameworkは少なくとも以下を満たさなければならない。

### 26.1 R-1. Foundation fidelity

Project Foundation §§2–9, 12, 15–17を弱めず、推測によるHistorical Data補完を正当化しない。§2.1のとおり、free-access制約は網羅性を削りうる一方でトレーサビリティを強化し、史実性を下げる代替・推測を許容しない。

### 26.2 R-2. Claim-level traceability

採用ClaimからEvidence locator、Source Object、provenanceへ逆引きできること。

### 26.3 R-3. Claim-centric source criticism

Tierのみで採否を自動決定せず、Claim Fitnessとsource lineageを評価できること。

### 26.4 R-4. Executable research capability

Archive research開始前にactor / channel capabilityを実測し、actor-side blockとsource-side restrictionを分離すること。

### 26.5 R-5. Phase integrity

Issue #25、Historical Data Model、Historical Source Acceptance、Technology Selectionの責任境界を維持し、後続フェーズを先取りしないこと。

### 26.6 R-6. Uncertainty preservation

not searched / not found / non-survival supported / not acquired / actor-blocked / source-restricted / illegibleを区別し、conflictを別概念として保持すること。

### 26.7 R-7. Rights and privacy safety

閲覧可能性、再配布可能性、copyright、privacyを別々に確認し、不明なbinaryをPublic Repositoryへ既定でcommitしないこと。

### 26.8 R-8. Method validation

正式運用前にSpatial / Temporal / Numericalの3類型をPilotで検証し、Policy / SOPをformalizeすること。

### 26.9 R-9. MVP Scope non-expansion

Stage 1はIssue #25へ史料的成立可能性の入力を提供するにとどめ、HPO-11に基づくHuman Project Owner権限下の明示的なAcceptance Criteria拡張を所与とする。D-2または本Frameworkの判断だけでIssue #25のAcceptance Criteriaを暗黙に増やさないこと。

### 26.10 R-10. GitHub SOT preservation

外部史料をProject SOTと再定義せず、Projectが採用したData・判断・provenance情報の正本管理はGitHubに従うこと。

### 26.11 R-11. Free-access source eligibility

Historical Dataの根拠として採用するSourceは、第三者が遠隔のonline channelからEvidence本文・画像まで金銭負担なく再現可能に確認でき、§6.11の適格4類型を満たすこと。現地閲覧のみ、有料accessまたは個人限定の再現不能なcopyを採用しない。例外条項を設けない。採用時条件と将来availabilityを区別する。

### 26.12 R-12. Access eligibility / exclusion traceability

free-access eligibility / exclusionをSource Tierおよび§6.6の正準7状態と別軸で保持すること。excluded candidateについて、§11.2に定めるidentifier / locator、channel、check date、actor、eligibility、exclusion reason、Claim関係および内容確認状態を追跡できること。remote requestを適格候補とする場合は、第三者再現可能性の判定根拠も追跡できること。

### 26.13 R-13. Claim-specific conflict boundary

有料Sourceの所在だけ、無料metadata / 二次資料が示すClaim-specificなpotential conflict、無料Evidenceで具体化されたformal conflictを§6.11 / §14.5の境界で区別すること。候補Sourceの存在または探索量だけでconfidenceを自動的に変更しないこと。

### 26.14 R-14. MVP Source Feasibility and asymmetry

Issue #25へ渡すMVP Source Feasibility inputは、Tier 1〜3の見込みとonline free-access eligibilityを判断軸に含み、Issue #26 / HPO-8 / HPO-9へ追跡できること。Stage 1でHPO-9適用後のGerman-side Tier 1残存度、German / Soviet証拠強度差およびhigh-risk Claim family別のcorroboration成立見込みを実測し、成立しない場合の終端候補とVisualizer側の誤読防止に必要なcoverage情報を引き渡すこと。

---

## 27. Constraints

### 27.1 C-1. No unilateral Foundation change

本FrameworkはProject Foundationを改訂しない。Foundation §5の未規定論点は追加適用規則または後続決定事項として明示する。

### 27.2 C-2. No schema / enum preemption

Source ID、Evidence ID、status enum、canonical timezone、storage format等を本Frameworkで確定しない。

### 27.3 C-3. Governance path constraint

path選択だけでgovernance freeze、policy-gate、Historical Data Impact等のProject規則を回避しない。

### 27.4 C-4. Authority constraint

Human Project Ownerの専管事項、Overall LeadのIntegration Decision、最終Merge権限を変更しない。本Frameworkの著者自己レビューをIndependent Reviewとして扱わない。

### 27.5 C-5. External access variability

Archive portal、catalog、規約、authentication、digitization範囲は変化しうるため、過去の到達結果を将来のcapabilityとして固定しない。

### 27.6 C-6. Rights / privacy constraint

研究目的で閲覧できることからPublic Repositoryへの再配布権を推定しない。

### 27.7 C-7. Historical inference constraint

史料不足・未発見・時間差・地図空白をAIまたは開発者推測で埋めない。

### 27.8 C-8. No paid-source dependency

MVP Scope、Historical Data Model、Source Acceptance Policy、Historical Datasetは、有料Sourceの購入・契約・閲覧料支払いを成立条件として設計しない。現地閲覧のみのSourceまたは個人限定の再現不能なcopyもHistorical Data確定根拠にしない。online free-accessで必要史料を確保できない候補は、Scope縮小・別Source探索・Unknown / omissionの対象として扱い、例外条項を設けない。

### 27.9 C-9. No canonical value-domain preemption

§7.1の8区分はStage 1観測区分に限定する。registration / request / on-site / paid、access eligibility、exclusion、potential conflict等の正式field名・値域・canonical enum、confidence閾値および最終状態を本Frameworkで確定しない。

### 27.10 C-10. MVP Scope non-expansion

MVP Source Feasibility inputはIssue #25の再現対象期間・作戦・粒度を決定せず、史料的成立可能性の判断材料だけを提供する。2026-08-14T12:11:14ZのIssue #25本文更新はHPO-11に基づく明示的拡張として記録し、本FrameworkまたはD-2を根拠とする追加の暗黙拡張を行わない。本FrameworkはIssue #25本文を更新しない。

---

## 28. Test / Validation Viewpoints

本Frameworkおよび後続Policy / SOPの検証では少なくとも以下を確認する。

### 28.1 T-1. Structural reference test

全見出し番号と相互参照が一意であり、同じ`§x.y`が複数意味を持たないこと。CommonMark上、説明文の直後に空行なしで`---`が続き直前行がsetext headingとして解釈される箇所がないこと。

### 28.2 T-2. Review disposition test

§24において、(1) v0.1 Overall Lead Review（`BLOCKER 1 / MUST FIX 8 / SHOULD FIX 10 / FOLLOW-UP 6`）、(2) v0.2 Overall Lead Re-Review（`BLOCKER 0 / MUST FIX 1 / SHOULD FIX 6 / FOLLOW-UP 3`）、(3) v0.2.1 Overall Lead 2nd Re-Review（`BLOCKER 0 / MUST FIX 4 / SHOULD FIX 4 / FOLLOW-UP 2`）、(4) v0.2.2 Overall Lead Independent Re-Review（`BLOCKER 0 / MUST FIX 3 / SHOULD FIX 4 / FOLLOW-UP 2`）、(5) v0.2.3 Overall Lead Independent Re-Review（`APPROVE`、`BLOCKER 0 / MUST FIX 0 / SHOULD FIX 2 / FOLLOW-UP 1`）、(6) v0.2.4 Overall Lead Independent Re-Review（`APPROVE`、`BLOCKER 0 / MUST FIX 0 / SHOULD FIX 2 / FOLLOW-UP 0`）、(7) v0.2.5 Overall Lead Independent Re-Review（`APPROVE`、`BLOCKER 0 / MUST FIX 0 / SHOULD FIX 0 / FOLLOW-UP 1`）、(8) v1.0 Overall Lead Independent Re-Review（`CHANGES_REQUIRED`、`BLOCKER 0 / MUST FIX 1 / SHOULD FIX 3 / FOLLOW-UP 0`）、(9) v1.0 Overall Lead 2nd Independent Re-Review（`CHANGES_REQUIRED`、`BLOCKER 0 / MUST FIX 2 / SHOULD FIX 2 / FOLLOW-UP 0`）の全指摘が、回次修飾IDにより本文反映または明示的follow-upとして一意に追跡できること。

### 28.3 T-3. Archive capability test

Bundesarchiv、NARA、Память народа、German Documents in Russia等について、使用actorごとにcatalog / metadata / image / auth levelと§7.1の8観測区分を実測して記録できること。HPO-9適用後にGerman-side Tier 1がClaim family / period / unit / granularityごとにどの程度残るかを測定し、high-risk Claim familyについてfree-access範囲でbilateral、上下級または隣接部隊corroborationが成立しうるかを評価できること。

### 28.4 T-4. Negative evidence test

同一Claimで§6.6の正準7状態（`not searched`、`not found`、`non-survival supported`、`source identified but not acquired`、`actor-blocked`、`source-restricted`、`illegible`）を誤って同一状態へ潰さず、conflictを別概念として保持すること。

### 28.5 T-5. Lineage / numerical test

同一原報告Xを引用する派生資料A/Bと独立資料Yを与えたとき、A/Bを独立観測として二重計上せず、Foundation §5適用前にlineage問題を検出できること。

### 28.6 T-6. Time-reference test

同一事象を異なるtime basisで記録した史料を照合する際、原表記を保持したまま正規化値とconversion uncertaintyを分離できること。

### 28.7 T-7. Formation-instance test

同一部隊番号の再編・再建等がある場合に、effective period / superior commandを用いて異なるformation instanceを誤接続しないこと。

### 28.8 T-8. Map derivation test

historical mapをgeoreferenceする場合に、元grid、control points、transformation、estimated errorを追跡でき、source scaleを超える精度を確定値として出さないこと。

### 28.9 T-9. Rights / privacy test

閲覧可能だが再配布不可、個人情報を含む、利用条件未確認等の各ケースでbinaryを既定commitしないこと。

### 28.10 T-10. Pilot exit-gate test

Spatial / Temporal / Numericalの3類型をPilotで処理し、重大なTraceability欠陥が残る場合はformalizationせずprovisional Policy / SOPへ戻せること。

### 28.11 T-11. Free-access eligibility test

次の各caseを一意に判定できること。

1. online public accessで本文・画像を確認可能：他要件充足時の適格候補。
2. 無料登録後にonlineで本文・画像を確認可能：他要件充足時の適格候補。
3. 公開された請求手続き、無料条件、第三者一般への適用可否および応答実績の根拠があり、無料remote requestで第三者にも同条件のdigital copy / online accessが提供される：他要件充足時の適格候補。
4. 無料の現地閲覧のみ：Historical Data根拠として不適格、discovery / 所在確認には利用可。
5. metadataだけ無料で本文有料、または購入・download・複写料が必要：Historical Data根拠として不適格。
6. 特定個人だけが取得した再現不能な無料copy：Historical Data根拠として不適格。

### 28.12 T-12. Access-axis orthogonality test

同一Sourceに§6.6の探索・取得状態とfree-access eligibility / exclusionを同時に付与でき、正準7状態へ第8状態を追加しないこと。excluded candidateについて§11.2の情報要件を欠落なく保持し、remote requestを適格候補とする場合は第三者再現可能性の判定根拠を再確認できること。

### 28.13 T-13. Potential / formal conflict boundary test

同一Claimに対し、(a)有料Sourceの所在だけ・内容未確認、(b)無料metadata / 二次資料によるClaim-specificな反証可能性、(c)無料Evidenceによる対立内容の具体的裏付けを与えたとき、それぞれexcluded candidate、potential conflict、formal conflictへ区別できること。(a)だけでconfidenceを下げず、(b)(c)を有料Sourceから直接確認した事実として扱わないこと。

### 28.14 T-14. MVP Source Feasibility / asymmetry test

D-2がIssue #26 / HPO-8 / HPO-9を参照し、Tier見込み、online free-access eligibility、HPO-9適用後のGerman-side Tier 1残存度、German / Soviet coverage差およびVisualizer誤読防止用の制約情報を含むこと。high-risk Claim family別にbilateral、上下級、隣接部隊corroborationの成立見込みを示し、成立しない場合の終端候補をsingle-source support、Scope縮小、Unknownまたはomissionとして記録できること。Issue #25の再現対象期間・作戦・粒度Scopeを拡張せず、HPO-11による明示的AC拡張とD-2による暗黙拡張禁止を区別できること。

### 28.15 T-15. Cross-structure and availability test

次の対応関係がRequirements / Constraints / Acceptance Criteria / Test間で矛盾せず、採用時条件と将来availabilityを混同しないこと。

| Concern | Requirement | Constraint | Acceptance Criteria | Test |
|---|---|---|---|---|
| online free-access boundary | R-11 | C-8 | 30 / 34 / 35 / 38 | T-11 / T-15 |
| access eligibility / exclusion | R-12 | C-9 | 31 / 32 | T-12 |
| potential / formal conflict | R-13 | C-2 / C-9 | 33 | T-13 |
| Issue #25 input / evidence asymmetry | R-14 | C-8 / C-10 | 36 / 37 | T-3 / T-14 |
| Issue #25 explicit vs implicit AC change | R-9 | C-10 | 27 | T-14 / T-15 |

---

## Appendix A. External Archive Findings Re-verified for v0.2 / carried through v1.0

以下は2026-08-14にv0.2作成時点で再確認した外部情報である。Stage 1着手時には必ず再確認し、access状況・規約・URLの変化を記録する。

### A-1. Bundesarchiv

- invenioはBundesarchiv holdingsの検索、デジタル化資料の閲覧、閲覧室利用準備に使用できる。
- online catalogで検索可能であることと、資料が利用制限なしで閲覧できることは同義ではない。
- digitised recordsは増加中であり、未デジタル資料も存在する。

References:
- https://www.bundesarchiv.de/en/research-our-records/research-archive-material/search-systems/invenio/
- https://www.bundesarchiv.de/en/research-our-records/research-archive-material/digitised-records/

### A-2. U.S. National Archives — RG 242

- RG 242はCaptured German Recordsのmicrofilm publicationsを案内している。
- Army系列としてT78、T311、T312、T313、T314、T315等が確認できる。
- NARAのfinding aidには`Guides to German Records Microfilmed at Alexandria VA`等がある。
- 元紙資料の多くはorigin countryへ返還され、microfilmが残るため、Bundesarchiv資料とのlineage重複に注意する。

References:
- https://www.archives.gov/research/captured-german-records/foreign-records-seized.html
- https://www.archives.gov/research/captured-german-records

### A-3. Память народа — corrected rights source

v0.1で参照していた`gwar.mil.ru`は当該portalの利用条件典拠として不適切であったため削除する。

2026-08-14に`Память народа`自身の利用規約を再確認した。規約は`Память народа`、`Мемориал`、`Подвиг народа`を対象とし、掲載archive documentのelectronic copiesのrightsholderをロシア連邦（ロシア連邦国防省）とする旨を記載している。また、個別電子copyの個人・研究利用と、情報contentの大量copy後の配布・出版等を区別している。

Reference:
- https://pamyat-naroda.ru/agreement/

### A-4. German Documents in Russia

- ロシア連邦各archiveに保存されたドイツ文書のdigital collectionsを研究・教育用途向けに提供する。
- 利用規約はpersonal data、private lifeに関する情報、個人に関する文書のreproduction等へ明示的な制約を置く。
- rights / privacy metadataをSource intake時に別軸で記録する必要性を裏付ける。

References:
- https://tsamo.germandocsinrussia.org/de/docs/2-ber-das-projekt
- https://germandocsinrussia.org/

---

## Appendix B. v0.2 SOL Self-Review

**Nature of review:** 著者自己点検。`SOL Independent Review`ではない。

### B-1. Review questions

1. Foundation §§2–9, 12, 15–17を弱めていないか。
2. Issue #25のScopeを拡張していないか。
3. `main`正本とIssue #24上の未Merge決定を混同していないか。
4. Overall LeadのBLOCKER / MUST FIXを全件処理したか。
5. SHOULD FIXを反映または明示的に後続化したか。
6. FOLLOW-UPを失っていないか。
7. HPO-1〜7の承認内容を反映したか。
8. schema / ID / enum / Technology Selectionを先取りしていないか。
9. 研究methodology上、Unknown / non-survival / not-found / conflictを混同していないか。
10. collectionが無限探索にならず終端できるか。
11. rights / privacy / access capabilityを別問題として扱っているか。
12. 節番号と相互参照が一意か。

### B-2. Findings

- **SR-v0.2-1 — Current governance wording:** `main` Policy §15はまだ旧freeze文言であるため、Issue #24の決定を「pending canonicalization」として分離した。PASS。
- **SR-v0.2-2 — Access blocker:** actor capabilityをGate 0化し、SOL / Human併用とactor-side / source-side分離を導入。PASS。
- **SR-v0.2-3 — Foundation §5:** Source independenceを追加適用規則と訂正し、完全重複・部分独立・Tier混在を明示。PASS。
- **SR-v0.2-4 — Negative evidence:** §6.6と§13へ単一概念集合を統合し、conflictを分離。PASS。
- **SR-v0.2-5 — Stop Rule:** 探索尽力後のsingle-source / Unknown終端を導入。PASS。
- **SR-v0.2-6 — Time / unit identity:** time referenceとformation instanceを追加。PASS。
- **SR-v0.2-7 — Tier boundary:** surrogate、edited publication、translation、unprovenanced scanの骨格を追加。PASS。
- **SR-v0.2-8 — Rights source:** Память народаの典拠を同portal利用規約へ訂正。PASS。
- **SR-v0.2-9 — Pilot sequencing:** provisional → Pilot → formalizationをSource Acceptance Phase内に再配置。PASS。
- **SR-v0.2-10 — Verification floor / privacy / georeferencing:** 3点を明文化。PASS。
- **SR-v0.2-11 — Issue #25:** D-2を支援inputとし、Acceptance Criteriaを暗黙に増やさないと明示。PASS。
- **SR-v0.2-12 — Numbering:** 親節と小節番号を一致させ、重複見出し・親節不一致を機械チェックした。PASS。
- **SR-v0.2-13 — Project design structure:** Objective / Scope / Out of Scopeに加え、Requirements / Constraints / Acceptance Criteria / Test viewpointsを明示構造として追加。PASS。

### B-3. Self-review conclusion

**Author self-review result: READY FOR OVERALL LEAD RE-REVIEW**

著者自己点検上、Overall Leadの8 MUST FIXはすべて本文へ反映済みである。10 SHOULD FIXも本文へ反映し、6 FOLLOW-UPは後続決定事項として明示的に保持した。v0.1 Review / BLOCKER-1は「全Projectでarchive access不能」という一般化をせず、Research Actor / Channel Capability Gateへ置換し、実行前実測を必須とした。

本判定は独立レビューではない。Overall Leadまたは別担当による再レビューを必要とする。

---

## Appendix C. v0.2.1 Human Project Owner Correction

2026-08-14、Human Project Ownerは以下を追加決定した。

1. Historical Dataの根拠として採用する史料は、Evidence本文・画像まで無料で確認できるものに限定する。
2. 無料アカウント登録は許容する。
3. 有料会員登録、subscription、購入、閲覧料、download料、複写注文その他の支払いが必要な史料は採用不可とする。
4. 有料Sourceは購入判断へエスカレーションせず、無料代替Source探索・Scope縮小・Unknown / omissionで処理する。
5. `v0.2 Re-Review / SHOULD FIX-A`（negative evidence 7状態の転記漏れ）をStage 1前修正として同時に是正した。

---

## Appendix D. v0.2.1 SOL Self-Review

**Review type:** Author self-review. `SOL Independent Review`ではない。

### D.1 Review scope

v0.2に対するOverall Lead Re-Review後のHuman Project Owner correctionについて、以下を確認した。

1. HPO-8 free-access-only制約がGate 0、Core Principle、Access metadata、Verification floor、Risk、Requirements、Constraints、Acceptance Criteria、Testへ横断反映されていること。
2. HPO-1のHuman escalationから有料購入・有料請求が除去されていること。
3. `v0.2 Re-Review / SHOULD FIX-A`のnegative evidence 7状態欠落が§21 / §28で再発していないこと。
4. Issue #26にHPO-1〜8およびHPO-R1〜R4が記録され、`v0.2 Re-Review / MUST FIX-A`のTraceability欠落が解消されたこと。
5. 新たなSource Acceptance詳細基準、schema、ID、enumを先取りしていないこと。
6. Issue #25のAcceptance Criteriaを拡張していないこと。

### D.2 Findings

- **SR-v0.2.1-1 — Free-access eligibility:** Evidence本文・画像まで無償確認できることを採用必須条件として反映。PASS。
- **SR-v0.2.1-2 — Paid-source exclusion:** 有料SourceをHuman購入判断へ回さず、無料代替Source / Scope縮小 / Unknown / omissionへ終端する。PASS。
- **SR-v0.2.1-3 — Negative evidence canonical set:** §21 / §28とも§6.6の正準7状態を参照し、`source identified but not acquired`の欠落を解消。PASS。
- **SR-v0.2.1-4 — Decision traceability:** GitHub Issue #26を親Issueとして作成し、HPO決定を記録。PASS。
- **SR-v0.2.1-5 — Phase boundary:** Historical Source Acceptance Policy詳細を先取りせず、Stage 3A以降へ委譲。PASS。
- **SR-v0.2.1-6 — Structural numbering:** 数値見出しの重複なし。PASS。

### D.3 Remaining follow-up from Overall Lead Re-Review

Stage 3Aまでに、Issue #26で`v0.2 Re-Review / SHOULD FIX-B〜F`を追跡する。`v0.2 Re-Review / FOLLOW-UP-A〜C`も同Issueで保持する。本v0.2.1でこれらを無断確定しない。

### D.4 Self-review conclusion

**READY FOR OVERALL LEAD RE-REVIEW**

---

## Appendix E. v0.2.1 Overall Lead 2nd Re-Review and HPO-9〜HPO-12

### E.1 Overall Lead 2nd Re-Review

- **Reviewed version:** v0.2.1
- **Decision date:** 2026-08-14
- **Review Decision:** `CHANGES_REQUIRED`
- **BLOCKER:** 0
- **MUST FIX:** 4
- **SHOULD FIX:** 4
- **FOLLOW-UP:** 2

指摘の内訳とv0.2.2での処理先は§24.3を正とする。v0.2.1はこのReview後に承認済みとは扱わない。

### E.2 HPO-9〜HPO-12 decision record

- **Decision date:** 2026-08-14
- **Decision authority:** Human Project Owner
- **Correct GitHub record:** Issue #26 `#issuecomment-5292982327`
- **Superseded erroneous record:** Issue #26 `#issuecomment-5292851625`

| ID | Decision reflected in v0.2.2 |
|---|---|
| HPO-9 | Option (a)。online free-access-onlyとし例外条項を設けない。適格4類型、不適格3類型、on-site-onlyのdiscovery限定利用、Gate 0の8観測区分を採用する。 |
| HPO-10 | Option (a) with clarification。正準7状態へ第8状態を追加せず、access eligibility / exclusion recordを独立させる。excluded candidate / potential conflict / formal conflictの3段階を区別し、Sourceの存在や探索量だけでconfidenceを下げない。 |
| HPO-11 | Issue #25へIssue #26 / HPO-8 / HPO-9を参照させ、史料成立可能性の判断軸へonline free-access eligibilityを含める。Issue本文更新はPMO担当。 |
| HPO-12 | Option (a)。v0.2.1を差し戻し、v0.2.2を作成してOverall Lead独立再レビューへ渡す。v0.2.1をFramework承認済みと扱わない。 |

---

## Appendix F. v0.2.2 SOL Author Self-Review

**Review type:** Document implementer self-verification. `Independent Review`でも承認判断でもない。

### F.1 Verification result

1. **Version:** 現行文書のtitle / status / recommendation / decision recordをv0.2.2へ統一し、v0.2.1は履歴上のReviewed versionとしてのみ記載した。PASS。
2. **HPO Traceability:** HPO-9〜HPO-12を決定日・決定主体・訂正コメント識別子付きで§23 / Appendix Eへ記録した。PASS。
3. **Orthogonality:** free-access eligibilityをTierおよび§6.6の正準7状態と別軸にし、第8状態を追加していない。PASS。
4. **No automatic confidence downgrade:** 有料Sourceの存在または探索量だけでconfidenceを下げる規則を禁止した。PASS。
5. **Conflict boundary:** excluded candidate / potential conflict / formal conflictの境界を§6.11 / §14.5へ定義した。PASS。
6. **On-site-only:** Historical Data確定根拠として不適格、discovery / 所在確認には利用可とした。PASS。
7. **Enum reservation:** Stage 1の8観測区分を明示し、canonical enum / 正式field値域はHistorical Data Modelへ留保した。PASS。
8. **CommonMark:** 説明文とthematic break `---`の間に空行を置き、文書全体の同型箇所を機械検証対象とした。PASS。
9. **Review history:** §24 / T-2でv0.1 Review、v0.2 Re-Review、v0.2.1 2nd Re-Reviewの全3回を追跡した。PASS。
10. **Cross-structure consistency:** RISK / Requirements / Constraints / Acceptance Criteria / Testの対応を§28.15で確認可能にした。PASS。

### F.2 Self-review conclusion

**READY FOR OVERALL LEAD INDEPENDENT RE-REVIEW**

本結論は文書実装担当による自己検証であり、`PASS`、Framework承認またはMerge可否の判断ではない。Overall Lead（Claude Code Opus）がv0.2.2を独立再レビューする。

---

## Appendix G. v0.2.2 Overall Lead Independent Re-Review

- **Reviewed version:** v0.2.2（2026-08-14 / GPT SOL）
- **Reviewer:** Overall Lead（Claude Code Opus）
- **Review date:** 2026-08-14
- **Nature:** HPO-12に基づく独立再レビュー。実装担当の自己承認ではない。
- **Review Decision:** `CHANGES_REQUIRED`
- **BLOCKER:** 0
- **MUST FIX:** 3
- **SHOULD FIX:** 4
- **FOLLOW-UP:** 2

Review直前のGitHub実取得値は、`main` HEAD `6626e7c3aea4c9eb24d0e87a965a5c0c2e0da7e8`、Open Pull Request 0件、Open Issue #16 / #24 / #25 / #26、Issue #26 `updated_at 2026-08-14T12:10:42Z`、Issue #25 `updated_at 2026-08-14T12:11:14Z`である。

Overall LeadはFrameworkの方向性、Foundation §17のフェーズ境界維持、HPO-9 / HPO-10の反映精度を妥当と評価し、指摘は局所的で骨格再設計を要しないとした。MUST FIX 3件、SHOULD FIX 4件およびFOLLOW-UP 2件の処理先は§24.4を正とする。本ReviewはFramework承認判断ではなく、v0.2.2を承認済みとは扱わない。

---

## Appendix H. v0.2.3 SOL Document-Implementer Verification

**Review type:** Document implementer self-verification. `Independent Review`でもFramework承認判断でもない。

### H.1 Verification result

1. **Version / review metadata:** title、Status、Executive Summary、§23、§25および現行自己検証をv0.2.3へ統一し、v0.2.2はReviewed version / historyとしてのみ記載した。v0.2.2 Independent Re-Reviewの`CHANGES_REQUIRED`と`BLOCKER 0 / MUST FIX 3 / SHOULD FIX 4 / FOLLOW-UP 2`を追跡した。PASS。
2. **v0.2.2 Independent Re-Review / MUST FIX-1:** v0.2→v0.2.1で「現地閲覧」を削除した時期、実施主体、当時の明示根拠なし、およびHPO-9による事後的正当化・正式化を§7.1 / §24.3 / §24.4へ記録した。PASS。
3. **v0.2.2 Independent Re-Review / MUST FIX-2:** `main` HEAD、Open PR / Issue、Issue #25 / #26 `updated_at`をGitHubから再取得し、§19.1 / §19.2 / §23 / §24.2 / C-10を現在状態へ更新した。HPO-9 / HPO-10の出典をIssue #26本文と訂正コメントへ結び、誤記コメントの上書き関係を維持した。PASS。
4. **v0.2.2 Independent Re-Review / MUST FIX-3:** D-IDはIssue #26本文を正と明示し、D-4〜D-8を整合した。Review ChecklistはD-5の構成物・D-6の検証対象とし、Issue #26側のD-1版表記等の同期をPMO作業として残した。PASS。
5. **v0.2.2 Independent Re-Review / SHOULD FIX-1:** free-access制約が網羅性を削り、トレーサビリティを強化し、史実性を下げる代替・推測を許容しない関係を§2.1 / R-1へ明記した。PASS。
6. **v0.2.2 Independent Re-Review / SHOULD FIX-2:** reproducible remote requestの判定根拠を§7.1 / §11.2 / R-12 / AC 32 / T-11 / T-12へ追加し、正式field名・値域をData Modelへ留保した。PASS。
7. **v0.2.2 Independent Re-Review / SHOULD FIX-3:** high-risk Claim family別corroboration成立見込みと不成立時の終端候補をStage 1 / D-2 / RISK-1 / R-14 / AC 37 / T-3 / T-14へ追加した。PASS。
8. **v0.2.2 Independent Re-Review / SHOULD FIX-4:** HPO-11に基づくIssue #25 ACの明示的拡張と、D-2経由の暗黙拡張禁止を§19.2 / §23.12 / R-9 / C-10 / AC 27 / T-14へ明記した。PASS。
9. **Regression / CommonMark:** §24 / T-2で全4 Review roundを追跡し、v0.1 / v0.2 / v0.2.1分の退行がないことを確認した。テキスト直後に空行なしで`---`が続く箇所は0件である。PASS。
10. **Authority / follow-up:** `v0.2.2 Independent Re-Review / FOLLOW-UP-1`および`v0.2.2 Independent Re-Review / FOLLOW-UP-2`を未解決として保持し、Foundation、Data Model schema、Policy閾値、Repository pathを先取り確定していない。自己検証をIndependent Reviewまたは承認として扱っていない。PASS。

### H.2 Self-verification conclusion

**READY FOR OVERALL LEAD INDEPENDENT RE-REVIEW**

本結論はGPT SOLによる文書実装後の自己検証であり、`PASS`、Framework承認、Integration DecisionまたはMerge可否の判断ではない。Overall Lead（Claude Code Opus）がv0.2.3を独立再レビューする。

---

## Appendix I. v0.2.3 Overall Lead Independent Re-Review

- **Reviewed version:** v0.2.3（2026-08-14 / GPT SOL）
- **Artifact SHA-256:** `cf489722c4d1a00745117305e8bd6f3b3198694fb559ab5b79e72f604b910c70`
- **Reviewer:** Overall Lead（Claude Code Opus）
- **Review date:** 2026-08-14
- **Nature:** HPO-12に基づく独立再レビュー。実装担当の自己承認ではなく、Framework承認判断でもない。
- **Review Decision / Integration Decision:** `APPROVE`
- **BLOCKER:** 0
- **MUST FIX:** 0
- **SHOULD FIX:** 2
- **FOLLOW-UP:** 1

Overall Leadは、v0.2.2 Independent Re-ReviewのMUST FIX 3件・SHOULD FIX 4件がすべて解消し、FOLLOW-UP 2件が適切に保持されていること、ならびにv0.1 / v0.2 / v0.2.1分の非退行を確認した。新規の`v0.2.3 Independent Re-Review / SHOULD FIX-1〜2`および`v0.2.3 Independent Re-Review / FOLLOW-UP-1`は局所的であり、Stage 1着手を妨げない。

Review時点のGitHub実取得値は、`main` HEAD `6626e7c3aea4c9eb24d0e87a965a5c0c2e0da7e8`、Open Pull Request 0件、Open Issue #16 / #24 / #25 / #26、Issue #25 `updated_at 2026-08-14T12:11:14Z`、Issue #26 `updated_at 2026-08-14T12:10:42Z`である。

Overall Leadは後続作業として、v0.2.2 Independent Re-ReviewをIssue #26コメント`#issuecomment-5293751543`、本v0.2.3 Independent Re-Reviewを`#issuecomment-5293761279`へ投稿済みである。v0.2.4改訂完了時のIssue #26本文はFramework Status、D-1版表記およびreview follow-up checklistをv0.2.3まで同期済みであるが、Review未投稿とする旧記述と投稿作業の未チェック項目が残る。

本`APPROVE`はOverall LeadのIntegration判断であり、Human Project OwnerによるFramework承認ではない。

---

## Appendix J. v0.2.4 SOL Document-Implementer Verification

**Review type:** Document implementer self-verification. `Independent Review`、Integration DecisionまたはFramework承認判断ではない。

### J.1 Verification result

1. **Version / immutable reviewed artifact:** v0.2.3のレビュー済みSHAを変更せず、v0.2.4を別artifactとして作成した。title、Status、Executive Summary、§23、§25および現行自己検証をv0.2.4へ統一した。PASS。
2. **v0.2.3 Independent Re-Review / SHOULD FIX-1:** §2.1の参照をFoundation §2の品質優先順位および§4の史料Tier順位へ訂正した。論旨、R-1およびfree-access境界は変更していない。PASS。
3. **v0.2.3 Independent Re-Review / SHOULD FIX-2:** §24へ回次修飾ID規則を追加し、全5 Review MatrixのIDおよび§24外のfinding参照を一意化した。original finding IDと過去自己レビューの実質的内容は維持した。PASS。
4. **v0.2.3 Independent Re-Review / FOLLOW-UP-1:** §24.3のAppendix時系列をB〜Jの現構成へ更新し、Appendix I / Jを時系列順に追加した。PASS。
5. **GitHub state / review records:** 改訂開始時・完了時に`main`、Open PR / Issue、Issue #25 / #26を再取得した。Overall Leadによるv0.2.2 / v0.2.3 Reviewコメントの投稿済み状態、改訂中に実施されたIssue #26本文のFramework Status / D-1 / follow-up checklist同期、および本文内に残るReview未投稿記述・未チェック項目を分離して記録した。PASS。
6. **Regression:** §6.6正準7状態、§6.11適格4類型・不適格3類型・3段階境界、§14.5 potential / formal conflict境界、D-1〜D-8体系およびFoundation §17フェーズ境界を変更していない。PASS。
7. **Review traceability:** §24 / T-2で全5 Review roundを回次修飾IDにより追跡し、`v0.2.3 Independent Re-Review / SHOULD FIX-1〜2`と`v0.2.3 Independent Re-Review / FOLLOW-UP-1`の処理先を§24.5へ記録した。PASS。
8. **CommonMark / structure:** テキスト直後に空行なしで`---`が続く箇所、重複見出し、親節を欠く小節番号、未解決の`§x.y`相互参照および旧D-ID残存がないことを機械検証対象とした。PASS。
9. **Authority:** Overall Leadの`APPROVE`をv0.2.3に対するIntegration判断として保持し、v0.2.4の自己承認またはFramework承認へ拡張していない。Framework承認をHuman Project Ownerへ留保した。PASS。
10. **GitHub non-write:** 本改訂でIssue / Pull Request / Repositoryを更新せず、Merge、Auto Merge、`main` direct push、Branch Protection変更または正本path確定を行っていない。PASS。

### J.2 Self-verification conclusion

**READY FOR HUMAN PROJECT OWNER FRAMEWORK APPROVAL DECISION**

本結論はGPT SOLによる文書実装後の自己検証であり、Framework承認またはMerge可否の判断ではない。Human Project Ownerがv0.2.3 Overall Lead Independent Re-Reviewの`APPROVE`と本v0.2.4の局所差分を踏まえて承認を判断する。

---

## Appendix K. v0.2.4 Overall Lead Independent Re-Review

- **Reviewed version:** v0.2.4（2026-08-14 / GPT SOL）
- **Artifact SHA-256:** `7bdf6e89614fe844cc9204f262d0a539ca93ecd8bb6e76afe54ef1fdd074c5de`
- **Reviewer:** Overall Lead（Claude Code Opus）
- **Review date:** 2026-08-14
- **Nature:** HPO-12に基づく独立再レビュー。実装担当の自己承認ではなく、Framework承認判断でもない。
- **Review Decision / Integration Decision:** `APPROVE`
- **BLOCKER:** 0
- **MUST FIX:** 0
- **SHOULD FIX:** 2
- **FOLLOW-UP:** 0（新規）

Overall Leadは、v0.2.3 Independent Re-ReviewのSHOULD FIX 2件・FOLLOW-UP 1件がv0.2.4で解消され、過去Review分に退行がないことを確認した。新規の`v0.2.4 Independent Re-Review / SHOULD FIX-1〜2`はmetadata / 記録同期に限定され、Frameworkの規定内容、判定境界、フェーズ境界およびDeliverable体系を変更しない。指摘の処理先は§24.6を正とする。

Review時のGitHub実取得値は、`main` HEAD `6626e7c3aea4c9eb24d0e87a965a5c0c2e0da7e8`、Open Pull Request 0件、Open Issue #16 / #24 / #25 / #26、Issue #24 `updated_at 2026-08-14T09:22:37Z`、Issue #25 `updated_at 2026-08-14T12:11:14Z`、Issue #26 `updated_at 2026-08-14T13:29:22Z`・コメント4件である。

Review本体はIssue #26コメント`#issuecomment-5299189860`へ投稿済みである。この投稿後のIssue #26 `updated_at`・コメント数および修正指示§5のPMO同期後本文状態は本改訂へ供給されていないため、現在値を推測しない。

本`APPROVE`はOverall LeadのIntegration判断であり、Human Project OwnerによるFramework承認ではない。

---

## Appendix L. v0.2.5 SOL Document-Implementer Verification

**Review type:** Document implementer self-verification. `Independent Review`、Integration Decision、Framework承認またはMerge可否判断ではない。

### L.1 Verification result

1. **Version:** title / Status / Prepared / §1 / §23 / §25 / Appendix A見出し / 現行自己検証をv0.2.5へ統一し、v0.2.4をReviewed version / historyとしてのみ記載した。v0.2.4 artifact SHA-256 `7bdf6e89614fe844cc9204f262d0a539ca93ecd8bb6e76afe54ef1fdd074c5de`を維持した。PASS。
2. **M-1:** header `Related`へ6 Review round、HPO-1〜HPO-12・HPO-R1〜R4およびGitHub記録済み3 Reviewのコメント識別子を記載し、存在しない識別子を付していない。PASS。
3. **M-2:** Appendix B.3のOverall Lead finding IDを`v0.1 Review / BLOCKER-1`へ回次修飾し、過去自己レビューの件数、評価および処理内容を変更していない。PASS。
4. **ID一意性:** 文書全体の`MUST FIX-` / `SHOULD FIX-` / `FOLLOW-UP-` / `BLOCKER-`に識別子が続く参照を走査し、回次修飾または§24.x節参照による一意化を欠く箇所が0件である。自己レビュー独自IDは別名前空間として維持した。PASS。
5. **Review traceability:** §24で6 roundを区別し、§24.6へv0.2.4 Independent Re-ReviewのSHOULD FIX 2件を記録した。§28.2 T-2を6 roundへ更新し、§24.3 FOLLOW-UP-AをAppendix B〜Lの現構成へ同期した。PASS。
6. **Appendix時系列:** Appendix A〜Lを時系列順に配置し、Kをv0.2.4 Overall Lead Independent Re-Review、Lをv0.2.5文書実装担当自己検証とした。PASS。
7. **Regression:** §6.6正準7状態、§6.11適格4類型・不適格3類型・3段階境界、§14.5 potential / formal conflict境界、§18.2の2主張分離、§19 Stage体系、§20 D-1〜D-8、§21 AC 1〜38、§26 R-1〜R-14、§27 C-1〜C-10、§28 T-1〜T-15およびFoundation §17フェーズ境界を変更していない。PASS。
8. **GitHub state:** §19.1 / §20 / §23 / §24には修正指示§3.4で供給された実取得値だけを使用した。v0.2.4 Reviewコメント投稿後のIssue #26 `updated_at`・コメント数とPMO同期後本文状態は未供給のため、現在値として推測せず未確認と明記した。PASS。
9. **CommonMark / structure:** テキスト直後に空行なしで`---`が続く箇所0件、重複見出し0件、親節を欠く小節番号0件、自文書見出しに解決しない`§x.y`参照0件、旧D-ID体系の残存0件を機械検証した。H1は1件、H2は40件である。PASS。
10. **Authority:** Framework承認をHuman Project Ownerへ留保し、本自己検証をIndependent Review、Integration Decision、Framework承認またはMerge可否判断として扱っていない。Issue / Pull Request / Repositoryへの書き込み、Merge、Auto Merge、`main` direct push、Branch Protection変更または正本path確定を行っていない。PASS。

### L.2 Self-verification conclusion

**READY FOR OVERALL LEAD INDEPENDENT RE-REVIEW**

本結論はGPT SOLによる文書実装後の自己検証であり、`PASS`、Framework承認、Integration DecisionまたはMerge可否判断ではない。Overall Lead（Claude Code Opus）がv0.2.5を独立再レビューする。

---

## Appendix M. v0.2.5 Overall Lead Independent Re-Review

**Reviewed version:** v0.2.5（2026-08-15 / GPT SOL）  
**Artifact SHA-256:** `04c5a4ff50f4d4f3456f3eae3f09d511538315e6e657dae72854df205f9fa60b`  
**Reviewer:** Overall Lead（Claude Code Opus）  
**Review date:** 2026-08-15  
**GitHub record:** Issue #26 `#issuecomment-5299304890`  
**Nature:** HPO-12に基づく独立再レビュー。実装担当の自己承認ではなく、Framework承認判断でもない。

### M.1 Review decision

**`APPROVE` — `BLOCKER 0 / MUST FIX 0 / SHOULD FIX 0 / FOLLOW-UP 1`**

Overall Leadは、v0.2.4 Independent Re-ReviewのSHOULD FIX 2件が解消され、過去Review分、規定上の判定境界、Stage体系およびD-ID体系に退行がないことを確認した。本`APPROVE`はIntegration判断であり、Human Project OwnerによるFramework承認を代替しない。

Review時のGitHub Current Stateは2026-08-14T23:53Zに実取得され、`main` HEAD `6626e7c3aea4c9eb24d0e87a965a5c0c2e0da7e8`、Open Pull Request 0件、Open Issue #16 / #24 / #25 / #26、Issue #26 `updated_at 2026-08-14T23:49:51Z`・コメント5件であった。これはReview時の事実記録であり、v1.0の現在値主張には用いない。

### M.2 Finding and disposition

| Class / ID | Finding | Disposition |
|---|---|---|
| v0.2.5 Independent Re-Review / FOLLOW-UP-1 | §19.1 / §20 / §23 / §24.5 / §24.6等でIssue #26のsnapshotを反復保持すると、Review投稿やPMO同期のたびに記述が陳腐化する | 次回の実質改訂でCurrent Stateを1箇所へ集約し、Issue #26をFramework同期状態のSOTとする。本v1.0の§19.1および§24.7で処理。 |

Review時点では、直前のPMO作業P-1〜P-5がIssue #26本文へ反映済みであることが確認された一方、Framework Status冒頭の対象Proposal行がv0.2.3のまま残っていた。この状態も後続同期を要する事実として記録され、本文同期はPMO作業へ分離された。

---

## Appendix N. HPO-13 / HPO-14 Decision Record

**Decision maker:** Human Project Owner  
**Decision date:** 2026-08-15  
**GitHub record:** Issue #26 `#issuecomment-5299352830`

### N.1 HPO-13 — Framework approval

Human Project OwnerはFramework Proposal v0.2.5（SHA-256 `04c5a4ff50f4d4f3456f3eae3f09d511538315e6e657dae72854df205f9fa60b`）を承認した。承認が確定する事項と確定しない事項は§23.14を正とする。承認済みFrameworkおよびHPO-R4の条件下でStage 1へ進めるが、Data Model schema、Acceptance Policyの詳細基準・閾値、MVP Scope、Repository登録完了またはFoundation §17の順序変更を先取りしない。

### N.2 HPO-14 — Canonical registration path policy

Human Project Ownerは、承認済みFrameworkを非governance pathへ先行登録する方針を決定した。その後のHuman Project Owner決定により、登録版をv1.0、pathを`docs/research/historical-source-framework_v1.0.md`とした。Overall Leadが付した5条件と、方法論文書と実Historical Dataのpath分離が未決であることは§23.15を正とする。本登録はPolicy §15のgovernance freeze解除でも例外規定の援用でもない。

---

## Appendix O. v1.0 PMO Document-Implementer Verification

**Verification type:** PMO（Claude Code Sonnet）による文書実装担当の自己検証。Independent Review、Integration Decision、Framework承認またはMerge可否判断ではない。

**担当分離（`docs/governance/merge-authority.md` §2.6の充足構成）**

| 役割 | 担当 |
|---|---|
| v1.0実装（残修正の反映） | PMO（Claude Code Sonnet） |
| Independent Review | GPT SOL |
| 文書レベル独立再レビューおよびIntegration Decision | Overall Lead（Claude Code Opus） |
| Merge | Human Project Ownerのみ |

実装担当とIndependent Review担当が分離されるため、上記構成はmerge-authority §2.6の例外を要しない。

**作成経緯（正本として記録する事実）**

1. v1.0初稿はCodexが作成した（artifact SHA-256 `7187a6eb5ec51540c93bf4e61994ddb7d65af5b9a39413b8cb2dedf9e61a37ca`）。
2. Overall Leadのv1.0 Independent Re-Review（Issue #26 `#issuecomment-5299527450`）が`CHANGES_REQUIRED`（MUST FIX 1 / SHOULD FIX 3）と判定した。
3. 当該指摘の反映をPMOが担当した。根拠はHPO-15（Issue #26 `#issuecomment-5299561829`）である。

### O.1 Verification result

1. **実装担当記載:** 見出しを「Appendix O. v1.0 PMO Document-Implementer Verification」とし、冒頭をPMO（Claude Code Sonnet）による自己検証と明記した。上記の担当分離表と作成経緯を本Appendixへ記載し、O.2を後述のとおり更新した。header の`Prepared by`と矛盾しない。**PASS**。
2. **Prepared by:** 「GPT SOL（v0.1〜v0.2.5の著述）/ Codex（v1.0初稿）/ PMO — Claude Code Sonnet（v1.0正本登録版の実装）」とし、著述・初稿・実装の3者を区別した。行末のMarkdown hard breakを保持した。**PASS**。
3. **Current State provenance:** §19.1を「PMO — Claude Code Sonnetが2026-08-15T00:47:24Z実取得」とし、取得主体・取得時刻を明記したうえで、`main` HEAD、Open Pull Request数、Issue #16 / #24 / #25 / #26の状態・`updated_at`、Issue #26のコメント数を実取得値として記載した。`main` HEAD・Open Pull Request数・Issue #24 / #25の`updated_at`について、Overall Leadが2026-08-15T00:32Zに実測した値と一致することを確認した。**PASS**。
4. **自称の統一:** §2.1 / §2.2 / §13.1 / §15.1 / §19.2の5箇所に限定して「本提案」「本Proposal」を「本Framework」へ統一した。§19.1のStage 0成果物を指す履歴記述は任意扱いとし変更していない。上記5箇所以外および規定文言は書き換えていない。**PASS**。
5. **HPO-15の記録:** §23.16としてHPO-15（v1.0実装担当の変更、記録先Issue #26 `#issuecomment-5299561829`）を追加した。§23.14 HPO-13および§23.15 HPO-14の記述と矛盾せず、Framework承認内容を再審査していない。§24.3 FOLLOW-UP-AのAppendix範囲記述（Appendix B〜O）は現構成と一致しており、本改訂はAppendixを追加しないため変更を要しないことを確認した。**PASS**。
6. **規定内容の非変更:** §6 / §7 / §10 / §11 / §12 / §13（自称を除く）/ §14 / §15（自称を除く）/ §16 / §17 / §18、§19 Stage体系、§20 D-1〜D-8表、§21 AC 1〜38、§22 RISK-1〜11、§26 R-1〜R-14、§27 C-1〜C-10、§28 T-1〜T-15について、v1.0初稿（SHA-256 `7187a6eb5ec51540c93bf4e61994ddb7d65af5b9a39413b8cb2dedf9e61a37ca`）とのdiffで差分がないことを確認した。本改訂の変更範囲はheader Prepared by、§19.1 Current State provenance、§2.1 / §2.2 / §13.1 / §15.1 / §19.2の自称5箇所、§23.16の追加、およびAppendix Oに限定される。新規Scope / Deliverable / AC / R / C / Tは追加していない。**PASS**。
7. **v0.2.5規定内容への退行なし:** 本改訂はv1.0初稿からの限定的修正であり、HPO-13承認対象であるv0.2.5（SHA-256 `04c5a4ff50f4d4f3456f3eae3f09d511538315e6e657dae72854df205f9fa60b`）からv1.0初稿への変更範囲を超えて規定内容を追加・変更していない。**PASS**。
8. **Finding ID一意性:** 本改訂で参照するfinding ID（`v1.0 Independent Re-Review / MUST FIX-1`、`v1.0 Independent Re-Review / SHOULD FIX-1〜3`）はすべて回次修飾形式であり、既存finding IDとの衝突はない。**PASS**。
9. **Mechanical structure:** テキスト直後に空行なしで`---`が続く箇所0件、重複見出し0件、親節を欠く小節番号0件、自文書見出しに解決しない`§x.y`参照0件、旧D-ID残存0件である。H1は1件、H2は43件である（v1.0初稿の自己申告値と一致し、退行がないことを確認した）。**PASS**。
10. **権限:** 本自己検証をIndependent Review、Integration Decision、Framework承認またはMerge可否判断として扱っていない。Issue / Pull Request / Repositoryへの書き込み、Merge、Auto Merge、`main` direct pushまたはBranch Protection変更は、本自己検証の時点では行っていない。**PASS**。

### O.2 Self-verification conclusion

**READY FOR OVERALL LEAD INDEPENDENT RE-REVIEW**

本結論はPMO（Claude Code Sonnet）による文書実装後の自己検証である。v1.0修正版の文書レベル独立再レビューはOverall Lead（Claude Code Opus）が行う。正本登録Pull RequestのSOL Independent Review欄はGPT SOLが記入する。GPT SOLはv1.0の実装担当ではないため、当該記入は自己承認に該当しない（HPO-15 / 2026-08-15、Issue #26 `#issuecomment-5299561829`）。Merge判断はHuman Project Ownerに留保される。
