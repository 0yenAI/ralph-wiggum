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
- **Google IDE Antigravity** または **Gemini CLI**
- **Python 3.8 以降**: [python.org](https://www.python.org/) からインストールしてください。
- **Gemini CLI** (または任意のAI CLIツール): パスが通っていることを確認してください。

### 導入手順

#### Windows
1. このフォルダを任意の場所に配置します。
2. ターミナル（PowerShell）で `.\install.ps1` を実行します。

#### macOS / Linux
1. このフォルダを任意の場所に配置します。
2. ターミナル（Bash/Zsh）で `chmod +x install.sh && ./install.sh` を実行します。

## 🤖 スラッシュコマンド (Antigravity / Gemini CLI 共通)

セットアップが完了すると、Antigravity のチャット欄、および通常のターミナル（Gemini CLI）で以下のコマンドが使用可能になります。

### `/ralph-loop`
現在のセッションで Ralph Loop を開始します。

**構文 (Windows)**:
```text
/ralph-loop "<指示>" --max-iterations <回数> --completion-promise "<完了キーワード>"
```

**構文 (macOS/Linux)**:
```bash
/ralph-loop "<指示>" <回数> "<完了キーワード>"
```

### `/cancel-ralph`
現在実行中の Ralph Loop を停止します。

---

## ⚙️ Gemini CLI グローバル設定

Gemini CLI および Antigravity において、AI エージェントが Ralph Loop のコマンドを正しく認識し実行できるようにするため、以下の設定を推奨します。

### 設定ファイルの場所
- **Windows**: `C:\Users\<ユーザー名>\.gemini\settings.json`
- **macOS / Linux**: `~/.gemini/settings.json`

### 推奨設定内容
`.gemini/settings.json` に以下の内容を記述（または追記）してください：

```json
{
    "gemini.context": {
        "preferredLanguage": "Japanese",
        "codingStandard": "PEP8",
        "allowedTerminalCommands": [
            "python",
            "python3",
            "gemini",
            "/ralph-loop",
            "/cancel-ralph",
            "powershell.exe",
            "bash",
            "pkill"
        ]
    },
    "gemini.safety": {
        "allowBackgroundExecution": true
    }
}
```

---

## 📖 使い方 (手動実行)

基本構文:
```bash
python ralph_gemini.py "<AIへの指示>" --completion-promise "<完了の合図>"
```

## 📜 ライセンス

本プロジェクトは **MITライセンス** の下で公開されています。

Copyright (c) 2025 **0yenAI**
