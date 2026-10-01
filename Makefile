# サイトを組み立てる手順．使い方は README.md にある．
# コマンドの行の先頭はタブ．空白にすると missing separator で止まる．

# Material for MkDocs が毎回出す，MkDocs 2.0 についての知らせを出さない．
# このサイトの組み立てには関係しない（README.md の「道具について」）
export NO_MKDOCS_2_WARNING = 1

.PHONY: check serve clean help

# make だけで実行される（最初のターゲット）．CIも同じ make check を実行する．
# サイトを site/ に組み立てる．--strict は，リンク切れなどの注意（WARNING）が
# 1つでもあれば失敗にする指定
check:
	uv run mkdocs build --strict

# 手元で http://127.0.0.1:8000 を開いて確かめる．保存すると表示も変わる．Ctrl+C で止める
serve:
	uv run mkdocs serve

clean:
	rm -rf site

help:
	@echo "make        サイトを組み立てて検査する（CIと同じ）"
	@echo "make serve  手元で http://127.0.0.1:8000 を開いて確かめる"
	@echo "make clean  組み立てたサイト（site/）を消す"
