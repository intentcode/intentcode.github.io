#!/bin/bash
# Intent - Install Claude Code hooks
# Run: curl -fsSL https://intentcode.github.io/install-hooks.sh | bash

set -e

CLAUDE_DIR="$HOME/.claude"
HOOKS_DIR="$CLAUDE_DIR/hooks"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

echo "⚡ Installing Intent hooks for Claude Code..."

# Create directories
mkdir -p "$HOOKS_DIR"

# Create the intent context script (called on SessionStart)
cat > "$HOOKS_DIR/intent-context.sh" << 'SCRIPT'
#!/bin/bash
# Injects Intent documentation context at session start

cat << 'EOF'
## Intent Documentation

This project may use Intent files for code documentation.
When making significant code changes, consider generating an intent file.

Quick reference:
- Intent files go in `.intent/intents/`
- Use semantic anchors: @function:name, @class:Name, @method:Class.method
- Explain WHY, not just WHAT
- Full spec: https://intentcode.github.io/prompt.md
EOF
SCRIPT
chmod +x "$HOOKS_DIR/intent-context.sh"
echo "✅ Created: $HOOKS_DIR/intent-context.sh"

# Create the post-edit reminder script (no jq dependency, POSIX compatible)
cat > "$HOOKS_DIR/intent-reminder.sh" << 'SCRIPT'
#!/bin/bash
# Reminds to document significant code changes

# Read input
INPUT=$(cat)

# Extract file_path using grep/sed (no jq needed)
FILE=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)"$/\1/' | head -1)

# Check if it's a code file worth documenting (POSIX compatible)
if echo "$FILE" | grep -qE '\.(ts|tsx|js|jsx|py|go|rs|java|rb|php|cs|cpp|c|h)$'; then
  # Skip if it's in node_modules, dist, etc.
  if ! echo "$FILE" | grep -qE '(node_modules|dist|build|\.git)'; then
    echo '{"hookSpecificOutput":{"additionalContext":"💡 Code modified. Consider documenting with an intent file."}}'
  fi
fi
SCRIPT
chmod +x "$HOOKS_DIR/intent-reminder.sh"
echo "✅ Created: $HOOKS_DIR/intent-reminder.sh"

# Handle settings.json
HOOKS_CONFIG='{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/intent-context.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/hooks/intent-reminder.sh"
          }
        ]
      }
    ]
  }
}'

if [ -f "$SETTINGS_FILE" ]; then
  # Check if hooks already exist
  if grep -q "intent-context.sh" "$SETTINGS_FILE"; then
    echo "⚠️  Intent hooks already in settings.json, skipping..."
  else
    # Backup and show manual instructions
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
    echo "📦 Backed up: $SETTINGS_FILE.backup"
    echo ""
    echo "⚠️  You have existing settings. Please manually merge these hooks:"
    echo ""
    echo "$HOOKS_CONFIG"
    echo ""
    echo "Edit: $SETTINGS_FILE"
  fi
else
  # Create new settings.json
  echo "$HOOKS_CONFIG" > "$SETTINGS_FILE"
  echo "✅ Created: $SETTINGS_FILE"
fi

echo ""
echo "⚡ Intent hooks installed!"
echo ""
echo "Hooks:"
echo "  • SessionStart → Shows Intent documentation reminder"
echo "  • PostToolUse  → Reminds after editing code files"
echo ""
echo "Verify with: /hooks in Claude Code"
echo "More info: https://intentcode.github.io"
