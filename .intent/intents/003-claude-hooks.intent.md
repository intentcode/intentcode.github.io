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

en: Triggers after Write or Edit tool use on code files. Uses regex to detect programming languages and excludes build artifacts.

```bash
if echo "$FILE" | grep -qE '\.(ts|tsx|js|jsx|py|go|rs|java|rb|php|cs|cpp|c|h)$'; then
  if ! echo "$FILE" | grep -qE '(node_modules|dist|build|\.git)'; then
    echo '{"hookSpecificOutput":{"additionalContext":"💡 Code modified..."}}'
  fi
fi
```

> Decision: No jq dependency - pure POSIX shell for maximum compatibility across Mac/Linux.
> fr: Pas de dépendance jq - shell POSIX pur pour une compatibilité maximale Mac/Linux.

@link @pattern:matcher | Triggers on Write|Edit tools only

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
