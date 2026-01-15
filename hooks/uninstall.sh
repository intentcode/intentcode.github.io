#!/bin/bash
# Intent - Uninstall Claude Code hooks
# Run: curl -fsSL https://intentcode.github.io/uninstall-hooks.sh | bash

set -e

CLAUDE_DIR="$HOME/.claude"
HOOKS_DIR="$CLAUDE_DIR/hooks"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

echo "⚡ Uninstalling Intent hooks..."

# Remove hook scripts
if [ -f "$HOOKS_DIR/intent-context.sh" ]; then
  rm "$HOOKS_DIR/intent-context.sh"
  echo "✅ Removed: $HOOKS_DIR/intent-context.sh"
fi

if [ -f "$HOOKS_DIR/intent-reminder.sh" ]; then
  rm "$HOOKS_DIR/intent-reminder.sh"
  echo "✅ Removed: $HOOKS_DIR/intent-reminder.sh"
fi

# Remove hooks from settings.json
if [ -f "$SETTINGS_FILE" ] && command -v jq &> /dev/null; then
  # Remove Intent hooks from settings
  UPDATED=$(jq '
    .hooks.SessionStart = [.hooks.SessionStart[]? | select(.hooks[0].command != "~/.claude/hooks/intent-context.sh")] |
    .hooks.PostToolUse = [.hooks.PostToolUse[]? | select(.hooks[0].command != "~/.claude/hooks/intent-reminder.sh")] |
    if .hooks.SessionStart == [] then del(.hooks.SessionStart) else . end |
    if .hooks.PostToolUse == [] then del(.hooks.PostToolUse) else . end |
    if .hooks == {} then del(.hooks) else . end
  ' "$SETTINGS_FILE")
  echo "$UPDATED" > "$SETTINGS_FILE"
  echo "✅ Cleaned: $SETTINGS_FILE"
fi

echo ""
echo "⚡ Intent hooks uninstalled successfully!"
echo ""
echo "To reinstall: curl -fsSL https://intentcode.github.io/install-hooks.sh | bash"
