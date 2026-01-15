---
id: claude-hooks
from: main
author: claude
date: 2025-01-15
status: active
risk: low
tags: [integration, claude-code, automation, hooks]
files:
  - install-hooks.sh
  - test-hooks.sh
---

# Claude Code Hooks Integration
# fr: Intégration des Hooks Claude Code

## Summary
en: One-liner installer for Claude Code hooks that inject Intent documentation context and remind users to document code changes.
fr: Installateur en une commande pour les hooks Claude Code qui injectent le contexte de documentation Intent et rappellent aux utilisateurs de documenter leurs changements.

## Motivation
en: Make Intent adoption frictionless by automatically reminding developers to document significant code changes without requiring manual setup.
fr: Rendre l'adoption d'Intent sans friction en rappelant automatiquement aux développeurs de documenter les changements significatifs sans configuration manuelle.

## Chunks

### @pattern:curl -fsSL | One-Liner Install
### fr: Installation en Une Commande

en: Users can install Intent hooks with a single command that fetches and executes the installer script from GitHub Pages.

```bash
curl -fsSL https://intentcode.github.io/install-hooks.sh | bash
```

> Decision: curl pipe to bash is standard for developer tools (homebrew, nvm, etc.) and provides instant setup.
> fr: curl pipe vers bash est standard pour les outils développeur et permet une configuration instantanée.

### @function:intent-context.sh | Session Start Hook
### fr: Hook de Démarrage de Session

en: Injects Intent documentation reminder when Claude Code starts a new session. Shows quick reference for intent file location and semantic anchors.

```bash
#!/bin/bash
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
```

> Decision: Minimal context injection - just enough to remind without being intrusive.

### @function:intent-reminder.sh | Post-Edit Hook
### fr: Hook Post-Édition

en: Triggers after Write or Edit tool use on code files. The hook receives JSON input from Claude Code via stdin, extracts the file path, and decides whether to show a reminder.

> Decision: No jq dependency - pure POSIX shell for maximum compatibility across Mac/Linux.
> fr: Pas de dépendance jq - shell POSIX pur pour une compatibilité maximale Mac/Linux.

@link @pattern:matcher | Triggers on Write|Edit tools only

### @pattern:INPUT=$(cat) | Reading Hook Input
### fr: Lecture de l'Entrée du Hook

en: Claude Code passes tool context as JSON via stdin. The hook captures this with `cat` to process it.

```bash
INPUT=$(cat)
# Example input: {"tool_input":{"file_path":"/src/app.tsx","content":"..."}}
```

> Decision: Reading all stdin at once allows multiple grep operations on the same data.

### @pattern:grep -o.*sed | JSON Parsing Without jq
### fr: Parsing JSON Sans jq

en: Extracts file_path from JSON using grep and sed instead of jq. This avoids requiring users to install additional dependencies.

```bash
FILE=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)"$/\1/' | head -1)
```

Breakdown:
- `grep -o` extracts only the matching part: `"file_path": "/src/app.tsx"`
- `sed 's/.*"\([^"]*\)"$/\1/'` captures the last quoted string: `/src/app.tsx`
- `head -1` ensures only first match if multiple file_path keys exist

> Decision: POSIX regex with `[[:space:]]` instead of `\s` for portability across sed implementations.
> fr: Regex POSIX avec `[[:space:]]` au lieu de `\s` pour la portabilité entre les implémentations sed.

### @pattern:grep -qE '\.(ts|tsx' | Code File Detection
### fr: Détection des Fichiers Code

en: Only triggers reminder for actual source code files, not configs or docs.

```bash
if echo "$FILE" | grep -qE '\.(ts|tsx|js|jsx|py|go|rs|java|rb|php|cs|cpp|c|h)$'; then
```

Supported extensions:
- JavaScript/TypeScript: `.js`, `.jsx`, `.ts`, `.tsx`
- Python: `.py`
- Go: `.go`
- Rust: `.rs`
- Java: `.java`
- Ruby: `.rb`
- PHP: `.php`
- C#: `.cs`
- C/C++: `.c`, `.cpp`, `.h`

> Decision: Intentionally excludes `.json`, `.yaml`, `.md`, `.html`, `.css` - config and content files don't need intent documentation.
> fr: Exclut intentionnellement `.json`, `.yaml`, `.md`, `.html`, `.css` - les fichiers de config et contenu n'ont pas besoin de documentation intent.

### @pattern:grep -qE '(node_modules' | Build Artifact Exclusion
### fr: Exclusion des Artefacts de Build

en: Prevents reminder from triggering on generated or vendored code.

```bash
if ! echo "$FILE" | grep -qE '(node_modules|dist|build|\.git)'; then
```

Excluded paths:
- `node_modules/` - npm dependencies
- `dist/` - build output
- `build/` - build output (alternative name)
- `.git/` - git internals

> Decision: Simple substring match is sufficient - these folders shouldn't appear in normal source paths.

### @pattern:hookSpecificOutput | Claude Code Response Format
### fr: Format de Réponse Claude Code

en: Hook output must be valid JSON with specific structure for Claude Code to display it.

```bash
echo '{"hookSpecificOutput":{"additionalContext":"💡 Code modified. Consider documenting with an intent file."}}'
```

- `hookSpecificOutput` - required wrapper object
- `additionalContext` - message shown to Claude after tool execution

> Decision: Single-line echo avoids JSON formatting issues. Emoji adds visual distinction.

### @pattern:settings.json | Hook Configuration
### fr: Configuration des Hooks

en: Claude Code hooks are configured in ~/.claude/settings.json with event matchers.

```json
{
  "hooks": {
    "SessionStart": [{ "hooks": [{ "type": "command", "command": "~/.claude/hooks/intent-context.sh" }] }],
    "PostToolUse": [{ "matcher": "Write|Edit", "hooks": [{ "type": "command", "command": "~/.claude/hooks/intent-reminder.sh" }] }]
  }
}
```

> Decision: PostToolUse with matcher limits hook execution to relevant tools, avoiding noise.

### @pattern:mkdir -p | Directory Setup
### fr: Configuration des Répertoires

en: Creates the hooks directory if it doesn't exist. Uses `-p` flag to avoid errors if directory already exists.

```bash
CLAUDE_DIR="$HOME/.claude"
HOOKS_DIR="$CLAUDE_DIR/hooks"
mkdir -p "$HOOKS_DIR"
```

> Decision: Using $HOME instead of ~ for reliability in scripts.

### @pattern:cat > "$HOOKS_DIR" << 'SCRIPT' | Heredoc Script Creation
### fr: Création de Scripts avec Heredoc

en: Creates hook scripts using heredoc syntax. Single quotes around `'SCRIPT'` prevent variable expansion inside the heredoc.

```bash
cat > "$HOOKS_DIR/intent-context.sh" << 'SCRIPT'
#!/bin/bash
# Script content here - variables like $HOME won't expand
SCRIPT
chmod +x "$HOOKS_DIR/intent-context.sh"
```

> Decision: Heredoc keeps scripts readable in installer. `chmod +x` makes them executable.
> fr: Heredoc garde les scripts lisibles dans l'installateur. `chmod +x` les rend exécutables.

### @pattern:if [ -f "$SETTINGS_FILE" ] | Settings Merge Strategy
### fr: Stratégie de Fusion des Settings

en: Handles three scenarios for settings.json:

1. **File doesn't exist**: Create new settings.json with hooks config
2. **File exists, no Intent hooks**: Backup and show manual merge instructions
3. **File exists, Intent hooks present**: Skip (already installed)

```bash
if [ -f "$SETTINGS_FILE" ]; then
  if grep -q "intent-context.sh" "$SETTINGS_FILE"; then
    echo "Already installed, skipping..."
  else
    cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
    echo "Please manually merge..."
  fi
else
  echo "$HOOKS_CONFIG" > "$SETTINGS_FILE"
fi
```

> Decision: Conservative approach - never auto-modify existing settings to avoid breaking user config.
> fr: Approche conservatrice - ne jamais modifier automatiquement les settings existants pour éviter de casser la config utilisateur.

### @pattern:cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup" | Backup Safety
### fr: Sauvegarde de Sécurité

en: Always creates a backup before showing merge instructions. User can restore with:

```bash
cp ~/.claude/settings.json.backup ~/.claude/settings.json
```

> Decision: Explicit backup path in same directory makes recovery obvious.

### @function:test_case | Test Suite
### fr: Suite de Tests

en: POSIX-compatible test suite validates both hooks work correctly across Mac and Linux.

Tests verify:
- Context hook outputs documentation reference
- Reminder triggers on code files (.tsx, .py, .go, etc.)
- Reminder ignores non-code files (.md, .json)
- Reminder ignores build folders (node_modules, dist, build)

> Decision: No bashisms - uses grep -qE instead of [[ =~ ]] for portability.
> fr: Pas de bashismes - utilise grep -qE au lieu de [[ =~ ]] pour la portabilité.

### @pattern:PASSED=$((PASSED + 1)) | POSIX Arithmetic
### fr: Arithmétique POSIX

en: Uses POSIX-compatible arithmetic instead of bashisms.

```bash
# Bad (bash-only, fails when PASSED=0 with set -e)
((PASSED++))

# Good (POSIX compatible)
PASSED=$((PASSED + 1))
```

> Decision: `((var++))` returns exit code 1 when var=0, breaking scripts with `set -e`. POSIX syntax always succeeds.
> fr: `((var++))` retourne exit code 1 quand var=0, cassant les scripts avec `set -e`. La syntaxe POSIX réussit toujours.

### @pattern:mktemp -d | Isolated Test Environment
### fr: Environnement de Test Isolé

en: Tests create hooks in a temp directory to avoid polluting real ~/.claude folder.

```bash
TEMP_DIR=$(mktemp -d)
cleanup() { rm -rf "$TEMP_DIR"; }
trap cleanup EXIT
```

> Decision: `trap cleanup EXIT` ensures temp files are always removed, even on test failure.
> fr: `trap cleanup EXIT` assure que les fichiers temp sont toujours supprimés, même en cas d'échec des tests.
