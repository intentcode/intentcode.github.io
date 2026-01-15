#!/bin/bash
# Intent Hooks - Test Suite
# Compatible with macOS and Linux
# Run: ./test-hooks.sh

HOOKS_DIR="$(dirname "$0")"
PASSED=0
FAILED=0

echo "⚡ Testing Intent hooks..."
echo ""

# Helper functions (POSIX compatible)
test_case() {
  local name="$1"
  local expected="$2"
  local actual="$3"

  if echo "$actual" | grep -q "$expected"; then
    echo "✅ $name"
    PASSED=$((PASSED + 1))
  else
    echo "❌ $name"
    echo "   Expected to contain: $expected"
    echo "   Got: $actual"
    FAILED=$((FAILED + 1))
  fi
}

test_empty() {
  local name="$1"
  local actual="$2"

  if [ -z "$actual" ]; then
    echo "✅ $name"
    PASSED=$((PASSED + 1))
  else
    echo "❌ $name"
    echo "   Expected: (empty)"
    echo "   Got: $actual"
    FAILED=$((FAILED + 1))
  fi
}

# Create temp hooks for testing
TEMP_DIR=$(mktemp -d)
cleanup() { rm -rf "$TEMP_DIR"; }
trap cleanup EXIT

# Create context hook
cat > "$TEMP_DIR/intent-context.sh" << 'EOF'
#!/bin/bash
cat << 'CONTENT'
## Intent Documentation

This project may use Intent files for code documentation.
When making significant code changes, consider generating an intent file.

Quick reference:
- Intent files go in `.intent/intents/`
- Use semantic anchors: @function:name, @class:Name, @method:Class.method
- Explain WHY, not just WHAT
- Full spec: https://intentcode.github.io/prompt.md
CONTENT
EOF

# Create reminder hook
cat > "$TEMP_DIR/intent-reminder.sh" << 'EOF'
#!/bin/bash
INPUT=$(cat)
FILE=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)"$/\1/' | head -1)

if echo "$FILE" | grep -qE '\.(ts|tsx|js|jsx|py|go|rs|java|rb|php|cs|cpp|c|h)$'; then
  if ! echo "$FILE" | grep -qE '(node_modules|dist|build|\.git)'; then
    echo '{"hookSpecificOutput":{"additionalContext":"💡 Code modified. Consider documenting with an intent file."}}'
  fi
fi
EOF

chmod +x "$TEMP_DIR"/*.sh

echo "--- Context Hook ---"
OUTPUT=$(bash "$TEMP_DIR/intent-context.sh")
test_case "Shows Intent documentation" "Intent Documentation" "$OUTPUT"
test_case "Contains spec URL" "intentcode.github.io/prompt.md" "$OUTPUT"
test_case "Mentions semantic anchors" "@function:name" "$OUTPUT"

echo ""
echo "--- Reminder Hook ---"

# Test: .tsx file should trigger reminder
OUTPUT=$(echo '{"tool_input":{"file_path":"/src/app.tsx"}}' | bash "$TEMP_DIR/intent-reminder.sh")
test_case "Triggers on .tsx files" "additionalContext" "$OUTPUT"

# Test: .py file should trigger reminder
OUTPUT=$(echo '{"tool_input":{"file_path":"/src/main.py"}}' | bash "$TEMP_DIR/intent-reminder.sh")
test_case "Triggers on .py files" "additionalContext" "$OUTPUT"

# Test: .go file should trigger reminder
OUTPUT=$(echo '{"tool_input":{"file_path":"/cmd/server.go"}}' | bash "$TEMP_DIR/intent-reminder.sh")
test_case "Triggers on .go files" "additionalContext" "$OUTPUT"

# Test: .md file should NOT trigger
OUTPUT=$(echo '{"tool_input":{"file_path":"/README.md"}}' | bash "$TEMP_DIR/intent-reminder.sh")
test_empty "Ignores .md files" "$OUTPUT"

# Test: .json file should NOT trigger
OUTPUT=$(echo '{"tool_input":{"file_path":"/package.json"}}' | bash "$TEMP_DIR/intent-reminder.sh")
test_empty "Ignores .json files" "$OUTPUT"

# Test: node_modules should be ignored
OUTPUT=$(echo '{"tool_input":{"file_path":"/node_modules/lodash/index.js"}}' | bash "$TEMP_DIR/intent-reminder.sh")
test_empty "Ignores node_modules" "$OUTPUT"

# Test: dist folder should be ignored
OUTPUT=$(echo '{"tool_input":{"file_path":"/dist/bundle.js"}}' | bash "$TEMP_DIR/intent-reminder.sh")
test_empty "Ignores dist folder" "$OUTPUT"

# Test: build folder should be ignored
OUTPUT=$(echo '{"tool_input":{"file_path":"/build/app.js"}}' | bash "$TEMP_DIR/intent-reminder.sh")
test_empty "Ignores build folder" "$OUTPUT"

echo ""
echo "================================"
echo "Results: $PASSED passed, $FAILED failed"
echo "================================"

if [ $FAILED -gt 0 ]; then
  exit 1
fi

echo ""
echo "✅ All tests passed!"
