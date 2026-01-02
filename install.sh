#!/bin/bash
# Ralph Wiggum Installation Script for macOS/Linux (Antigravity & GeminiCLI Support)

PROJECT_DIR=$(pwd)
WORKFLOWS_DIR="$PROJECT_DIR/.agent/workflows"
SCRIPT_PATH="$PROJECT_DIR/ralph_gemini.py"

echo "🔧 Setting up Ralph Wiggum for Antigravity & GeminiCLI..."

# 1. Create workflows directory for Antigravity
if [ ! -d "$WORKFLOWS_DIR" ]; then
    mkdir -p "$WORKFLOWS_DIR"
    echo "✅ Created .agent/workflows directory for Antigravity."
fi

# 2. Check for Python
if command -v python3 >/dev/null 2>&1; then
    PYTHON_VER=$(python3 --version)
    echo "✅ Found Python: $PYTHON_VER"
else
    echo "❌ Python 3 not found. Please install Python 3.8+."
    exit 1
fi

# 3. Add functions to Shell Profile for GeminiCLI (Terminal) support
# Detect shell profile
if [ -n "$ZSH_VERSION" ]; then
    PROFILE_FILE="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    PROFILE_FILE="$HOME/.bashrc"
else
    # Fallback to .bashrc for common Linux setups
    PROFILE_FILE="$HOME/.bashrc"
fi

FUNCTION_DEFINES="
# --- Ralph Wiggum Functions ---
/ralph-loop() {
    python3 \"$SCRIPT_PATH\" \"\$1\" --max-iterations \"\${2:-50}\" --completion-promise \"\$3\"
}

/cancel-ralph() {
    echo \"Stopping Ralph Loop...\"
    pkill -f \"ralph_gemini.py\"
    echo \"✅ Cancelled.\"
}
# --- End Ralph Wiggum ---
"

if ! grep -q "# --- Ralph Wiggum Functions ---" "$PROFILE_FILE" 2>/dev/null; then
    echo "$FUNCTION_DEFINES" >> "$PROFILE_FILE"
    echo "✅ Added /ralph-loop and /cancel-ralph to $PROFILE_FILE."
    echo "💡 Please restart your terminal or run: source $PROFILE_FILE"
else
    echo "ℹ️  Slash commands already exist in your shell profile."
fi

echo -e "\n🚀 Setup Complete!"
echo "Commands available in both Antigravity and GeminiCLI (Terminal):"
echo "  /ralph-loop \"<prompt>\" <max_iterations> \"<completion_promise>\""
echo "  /cancel-ralph"
echo -e "\nEnjoy your autonomous loops! 🍩"
