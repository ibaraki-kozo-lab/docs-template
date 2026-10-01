# docs-template

研究室で，Markdownで書いた資料をWebサイトにするためのテンプレートである．MkDocsとMaterial for MkDocsで組み立て，`make` でリンク切れなどを検査する．PRを出すと，GitHub Actionsが同じ `make` を実行して検査する．公開するかどうかと公開先は，リポジトリの設定で選ぶ（[公開する](#公開する)）．

## 準備

uv，Make，Gitを使う．入れ方は，[研究室ハンドブック][hb]の「[環境構築（uv）][hb-uv-install]」「[Make][hb-make-install]」「[はじめてのGit・GitHub][hb-git]」にある．このテンプレートは，ハンドブックの「[Markdown][hb-markdown]」と「[実践：ドキュメントサイト][hb-docs-site]」まで読んだ前提で書いてある．ハンドブックは研究室の人だけが読めるサイトで，開くときは，管理者が登録した大学のメールアドレスを使う．

VS Codeでフォルダを開くと，おすすめの拡張機能（YAML）を入れるか尋ねられる．入れると，`mkdocs.yml` を書くときに，書ける項目の候補と誤りが示される．

## はじめにやること

このテンプレートから新しいリポジトリを作るときは，次を1度だけ行う．終わったら，この節は消してよい．

1. テンプレートのページ（`ibaraki-kozo-lab/docs-template`）で **Use this template** → **Create a new repository** を選び，リポジトリを作る．研究で使うリポジトリは，管理者が研究室のorganizationに作る．練習なら，自分のアカウントに作ってよい
2. 作ったリポジトリをクローンし，その中で `make serve` を実行して，ブラウザで http://127.0.0.1:8000 を開く．見本のサイトが表示されれば，準備はできている
3. `mkdocs.yml` の `site_name`（サイトの名前）と，`docs/index.md`（トップページ）を書き換える
4. 見本のページ（`docs/writing.md`，`docs/notes/beam.md`，`docs/img/beam.svg`）は，読み終えたら消すか，自分のページに置き換える．ページを消したら，`mkdocs.yml` の `nav` からその行を外し，ページが1つもなくなった見出しの行（`- ノート:`）も外す．`docs/index.md` の，消したページへのリンクも消す
5. この `README.md` の見出し（`# docs-template`）と最初の段落を，何をまとめるサイトかの説明に書き換える

## このリポジトリの地図

| 場所 | 中身 | 扱い |
|------|------|------|
| `docs/` | サイトのページ．1つの `.md` のファイルが1ページになる | 書く |
| `docs/img/` | ページに入れる画像 | 置く |
| `docs/assets/` | サイトの部品（数式を表示するための設定） | 触らない |
| `mkdocs.yml` | サイトの設定．サイトの名前と，左に並ぶページの一覧（`nav`） | ページを足したら直す |
| `README.md` | この説明 | 書く |
| `pyproject.toml` | サイトを組み立てる道具（Material for MkDocs） | ふだんは触らない |
| `uv.lock` | 入れた道具のバージョンの記録 | 触らない（コミットはする） |
| `.python-version` | 使うPythonのバージョン（3.12） | 触らない |
| `Makefile` | 組み立てと検査の手順 | ふだんは触らない |
| `AGENTS.md` | このリポジトリの決まり（人とAIエージェント向け） | ときどき直す |
| `CLAUDE.md` | Claude Codeに `AGENTS.md` を読ませる1行（`@AGENTS.md`） | 触らない |
| `.github/` | CI（`workflows/docs.yml`．公開もここで行う）とPRのひな形 | ふだんは触らない |
| `.vscode/` | VS Codeのおすすめの拡張機能と設定 | ふだんは触らない |
| `.gitignore` | Gitに記録しないものの一覧 | ふだんは触らない |
| `site/` | `make` が組み立てたサイト（HTML） | Gitに記録しない |
| `.venv/` | uvが作る仮想環境 | Gitに記録しない |

`site/` は `make` を，`.venv/` は最初の `make` か `make serve` を実行するとできる．どちらもいつでも作り直せるので，Gitには記録しない．

## 使い方

```sh
make serve
```

手元でサイトを組み立て，http://127.0.0.1:8000 で開けるようにする．ファイルを保存するたびに，ブラウザの表示も変わる．止めるときは Ctrl+C を押す．

| コマンド | すること |
|----------|----------|
| `make serve` | 手元で http://127.0.0.1:8000 を開いて確かめる |
| `make` | サイトを `site/` に組み立てて検査する（CIと同じ） |
| `make clean` | 組み立てたサイト（`site/`）を消す |
| `make help` | この一覧を表示する |

`make` は `mkdocs build --strict` を実行する．`--strict` は，注意（`WARNING`）が1つでもあれば失敗にする指定である．このテンプレートの `mkdocs.yml` では，次のどれでも止まる．

- 存在しないページへのリンク
- ページの中の，存在しない見出しへのリンク
- `docs/` にあるのに，`nav` に書いていないページ

```output
WARNING -  The following pages exist in the docs directory, but are not included in the "nav" configuration:
  - samples.md

Aborted with 1 warnings in strict mode!
```

`WARNING` の行を読んで直す．上は，`docs/samples.md` を作ったのに `nav` に書いていないときの表示である．

## ページを足す

1. `docs/` に `.md` のファイルを作る．種類ごとにフォルダを分けてもよい（`docs/notes/` など）
2. `mkdocs.yml` の `nav` に，`表示する名前: docs/ からの場所` の形で1行足す
3. `make serve` で表示を確かめ，`make` が通ることを確かめる

囲み，数式，表，画像，Mermaidの図，コードの注釈の書き方は，見本のページ `docs/writing.md` にある．`make serve` で開くと，書き方と表示を見比べられる．画像は `docs/img/` に置く．

## 公開する

公開するかどうかと公開先は，リポジトリの変数 `DOCS_PUBLISH` で選ぶ．作らなければ公開しない．公開すると，`main` にpushするたび（PRを取り込んだときも）にサイトが更新される．PRでは公開せず，組み立てと検査だけを行う．

| `DOCS_PUBLISH` | 公開先 | 見られる人 | 設定する人 |
|----------------|--------|------------|------------|
| （作らない） | 公開しない | － | － |
| `github-pages` | GitHub Pages | インターネットの誰でも | リポジトリのadmin |
| `cloudflare` | Cloudflare Pages ＋ Cloudflare Access | 研究室の人（Accessで許可したメールアドレス） | 研究室の管理者 |

値を書き間違えると，CIの最初の手順が `変数 DOCS_PUBLISH は github-pages か cloudflare にする` と表示して止まる．

### GitHub Pages（誰でも見られる）

GitHub Pagesのサイトは，リポジトリが非公開でも，インターネットの誰でも見られる．未発表の研究や，研究室の内部の情報を書くサイトでは使わない．また，無料のプラン（GitHub Free）ではPublicのリポジトリでしか使えない．有料のプラン（GitHub Teamなど）なら，Privateのリポジトリからも公開できる（サイトはやはり誰でも見られる）．

1. リポジトリの **Settings** → **Pages** → **Build and deployment** の **Source** で，**GitHub Actions** を選ぶ
2. **Settings** → **Secrets and variables** → **Actions** → **Variables** のタブ → **New repository variable** で，Nameを `DOCS_PUBLISH`，Valueを `github-pages` にして作る
3. `mkdocs.yml` の `# site_url:` の行の先頭の「`# `」（`#` と空白）を消し，公開先のアドレス（`https://アカウントの名前.github.io/リポジトリの名前/`）を書いてコミットし，`main` にpushする

**Actions** のタブで `github-pages` のジョブに緑の ✓ が付いたら，公開先のアドレスを開く．公開をやめるときは，変数 `DOCS_PUBLISH` を消してから，**Settings** → **Pages** で **Unpublish site** を選ぶ．

### Cloudflare Pages ＋ Access（研究室の人だけ）

研究室のCloudflareのアカウントを使うので，研究室の管理者が設定する．頼むときは，リポジトリの名前を伝える．管理者は次を行う．

1. CloudflareでPagesのプロジェクトを作る（Direct Upload）．名前はリポジトリと同じにする．違う名前にしたときは，手順4で変数 `CLOUDFLARE_PROJECT` にその名前も入れる
2. Cloudflare Accessのアプリケーションに，`サブドメイン.pages.dev` と `*.サブドメイン.pages.dev` の**両方**を登録し，研究室の人のPolicyを付ける．サブドメインはプロジェクトの画面に出る（ほかで使われている名前なら，末尾に文字が足される）．ワイルドカードがないと，デプロイごとに発行されるアドレスが認証なしで見える
3. リポジトリのシークレットに，`CLOUDFLARE_API_TOKEN`（Cloudflare Pagesを編集できるトークン）と `CLOUDFLARE_ACCOUNT_ID` を登録する
4. リポジトリの変数 `DOCS_PUBLISH` を `cloudflare` にして作る
5. `mkdocs.yml` の `site_url` に公開先のアドレス（`https://サブドメイン.pages.dev/`）を書き，`main` にpushする

Cloudflare Pagesを編集できるトークンは，アカウントにあるすべてのPagesのプロジェクトを作成・編集・削除でき，プロジェクトごとには絞れない．また，リポジトリにWriteを持つ人は，ワークフローを書き換えればシークレットを使える．ほかのサイトを任せてよい人だけが書くリポジトリに設定する（ハンドブックの「[GitHub Actions（CI）][hb-actions]」の「[コラム：シークレットは誰が使えるか][hb-actions-secrets]」）．

## 困ったとき

| 表示や様子 | 原因と対処 |
|------------|------------|
| `OSError: [Errno 98] Address already in use`（macOSでは `[Errno 48]`）と出て，`make serve` が始まらない | ほかのプログラム（前に起動した `make serve` など）が8000番を使っている．前のものを Ctrl+C で止めるか，`uv run mkdocs serve --dev-addr 127.0.0.1:8001` で別の番号を使う |
| `WARNING -  Doc file '…' contains a link '…', but the target is not found among documentation files.` | リンク先のページがない．ファイルの名前と，このページからの場所を確かめる |
| `WARNING -  The following pages exist in the docs directory, but are not included in the "nav" configuration:` | `mkdocs.yml` の `nav` にページを書いていない（[ページを足す](#ページを足す)） |
| `ERROR   -  Config value 'nav': Expected nav to be a list, got None` | `nav` に，下にページが1つもない見出しの行（`- ノート:` など）が残っている．その行も消す |
| 枠で囲まれた `Warning from the Material for MkDocs team` が出る | `make` を通さずに `mkdocs` を実行すると出る，道具の今後についての知らせで，このサイトには関係しない（[道具について](#道具について)） |

## 変更の流れ

変更はブランチで作り，PRを出す．PRではCIが `make` を実行する．✗ が付いたら，**Details** からログを開き，`WARNING` の行を読んで直す（ハンドブックの「[ブランチとPR][hb-branches]」と「[実践：ドキュメントサイト][hb-docs-site]」）．PRの本文は，ひな形のChecklistを埋める．このリポジトリの決まりは `AGENTS.md` にある．

## 道具について

Material for MkDocsは，新しい機能が足されない保守だけの状態になっている．同じ開発元の後継のZensicalは，`mkdocs.yml` をそのまま読める．[研究室ハンドブック][hb]と同じ時期にZensicalへ移る予定で，そのときは，このテンプレート（`ibaraki-kozo-lab/docs-template`）に移り方を書く．テンプレートから作ったリポジトリには，テンプレートの変更が自動では届かないので，そのときに見に来る．

Material for MkDocsは，MkDocsの次のバージョン（2.0）についての知らせを，組み立てるたびに枠で囲んで表示する．このテンプレートは今のMkDocs（1.x）を使い続けるので関係しない．`make` と `make serve` では，`Makefile` の `NO_MKDOCS_2_WARNING` で表示しないようにしてある．

<!-- 研究室ハンドブックへのリンク．ハンドブックのページの場所が変わったら，ここを直す -->

[hb]: https://lab-handbook-ein.pages.dev/
[hb-uv-install]: https://lab-handbook-ein.pages.dev/python/uv/#install
[hb-make-install]: https://lab-handbook-ein.pages.dev/dev/make/#install
[hb-git]: https://lab-handbook-ein.pages.dev/dev/git/
[hb-markdown]: https://lab-handbook-ein.pages.dev/dev/markdown/
[hb-docs-site]: https://lab-handbook-ein.pages.dev/practice/docs-site/
[hb-actions]: https://lab-handbook-ein.pages.dev/dev/actions/
[hb-actions-secrets]: https://lab-handbook-ein.pages.dev/dev/actions/#who-can-use-secrets
[hb-branches]: https://lab-handbook-ein.pages.dev/dev/branches/
