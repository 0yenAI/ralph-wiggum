# Ralph Wiggum for Gemini CLI & Google IDE Antigravity

**Ralph Wiggum (ラルフ・ウィガム)** は、**Google IDE Antigravity** および **Gemini CLI** のための、自律反復型開発支援ツールです。「Ralph Loop（ラルフ・ループ）」と呼ばれる手法を実装しており、AIエージェントに「特定の完了シグナル（言葉）」が出るまでタスクを粘り強く試行させ続けることができます。

> "Ralph is a Bash loop." — Geoffrey Huntley
> （ラルフはただのBashループに過ぎない、だがそれが強力だ）

## 🌟 特徴

- **自動反復実行**: あなたの指示（プロンプト）に基づいて、AIコマンドを自動的に繰り返し実行します。
- **完了検知**: AIが「完了しました」「ALL TESTS PASSED」といった特定の言葉を出力した瞬間, 自動的に停止します。
- **粘り強いデバッグ**: 一度でうまくいかなくても、何度も再試行させることで、AI自身にエラーログを読ませ、自己修正させるワークフローを実現します。
- **クロスプラットフォーム**: Pythonが動作する Windows, Mac, Linux すべてで動作します。

## 🚀 インストール

このツールは単体の Python スクリプトです。

### 前提条件
- **Google IDE Antigravity** または **Gemini CLI** (PowerShell)
- **Python 3.8 以降**: [python.org](https://www.python.org/) からインストールしてください。
- **Gemini CLI** (または任意のAI CLIツール): パスが通っていることを確認してください。

### 導入手順 (Windows)
1. このフォルダを任意の場所に配置します。
2. ターミナル（PowerShell）で `.\install.ps1` を実行してセットアップします。

## 🤖 スラッシュコマンド (Antigravity / Gemini CLI 共通)

セットアップが完了すると、Antigravity のチャット欄、および通常のターミナル（Gemini CLI）で以下のコマンドが使用可能になります。

### `/ralph-loop`
現在のセッションで Ralph Loop を開始します。

**構文**:
```text
/ralph-loop "<指示>" --max-iterations <回数> --completion-promise "<完了キーワード>"
```

**例**:
```text
/ralph-loop "コードのバグを修正して" --max-iterations 10 --completion-promise "FIX_DONE"
```

### `/cancel-ralph`
現在実行中の Ralph Loop を停止します。

---

## 📖 使い方 (手動実行)

基本構文:
```bash
python ralph_gemini.py "<AIへの指示>" --completion-promise "<完了の合図>"
```

### 具体的な使用例

**シナリオ**: `app.py` にバグがあり、テストに通らない。AIに修正させ、テストが通ったら終了させたい。

**手順**:
1. AIへの指示（プロンプト）: 「app.pyのバグを直して。修正が終わってテストが通ったら『FIX_COMPLETE』と出力して」
2. 実行するコマンド:

```bash
# Windows / Mac / Linux 共通
python ralph_gemini.py "app.pyのバグを修正し、テストを実行してください。成功したら FIX_COMPLETE とだけ出力してください" --completion-promise "FIX_COMPLETE" --command "gemini"
```

### オプション引数 (手動用)

- `--command`: AIを実行するコマンド名（デフォルト: `gemini`）。`python my_agent.py` のように指定も可能。
- `--completion-promise`: 必須。タスク完了とみなすキーワード。
- `--max-iterations`: 最大試行回数（デフォルト: 50）。無限ループ防止用。
- `--interval`: 再試行までの待機秒数（デフォルト: 2）。
- `--verbose`: 詳細ログを表示します。

## 📜 ライセンス

本プロジェクトは **MITライセンス** の下で公開されています。

Copyright (c) 2025 **0yenAI**

MITライセンスの規定により、ソフトウェアの全ての複製または重要な部分には、上記の著作権表示および本許諾表示を含める必要があります。これにより、**0yenAI** のお名前を削除して配布することはできません。

詳細は [LICENSE](LICENSE) ファイルをご覧ください。
