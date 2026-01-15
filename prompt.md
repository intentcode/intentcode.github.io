# Intent - LLM Prompt for Code Documentation

> Fetch this file: `https://intentcode.github.io/prompt.md`

## Quick Start

Add this to your system prompt or CLAUDE.md:

```markdown
## Intent Documentation

When making significant code changes, generate an intent file to explain the "why" behind your changes.

### Intent File Format

Store intents in `.intent/intents/` with a manifest at `.intent/manifest.yaml`.

**File structure:**

```markdown
---
id: feature-name
from: main
author: claude
date: 2024-01-15
status: active
risk: low|medium|high
tags: [feature, bugfix, refactor]
files:
  - src/file.ts
---

# Feature Title

## Summary
What this change accomplishes.

## Motivation
Why this change was needed.

## Chunks

### @function:functionName | Chunk Title
Description of what this code does and WHY.

> Decision: Why this approach was chosen over alternatives.

@link @function:otherFunction | Related code
```

### Semantic Anchors (prefer these over line numbers!)

| Anchor | Use for | Example |
|--------|---------|---------|
| `@function:name` | Functions/methods | `@function:validateUser` |
| `@class:Name` | Classes | `@class:UserService` |
| `@method:Class.method` | Specific method | `@method:UserService.validate` |
| `@pattern:text` | Code pattern search | `@pattern:if __name__` |
| `@chunk:id` | Conceptual (no code) | `@chunk:architecture` |
| `@line:10-20` | Line range (fragile!) | `@line:42-58` |

### Rules

1. **Explain WHY, not just WHAT**
   - ❌ "Added validation"
   - ✅ "Added validation because user input could contain SQL injection"

2. **One chunk per concept** - don't over-document

3. **Use links** to connect related code:
   - `@link @function:helper` - same file
   - `@link utils.py@function:parse` - cross-file

4. **Assess risk honestly**:
   - `low`: Isolated, easy to revert
   - `medium`: Multiple files, needs testing
   - `high`: Architectural, security, data

### When to Generate Intent

✅ Generate for:
- New features
- Non-trivial bug fixes
- Refactoring
- Architectural decisions

❌ Skip for:
- Typos, formatting
- One-line obvious fixes
```

---

## One-Shot Prompt

Copy-paste this into any LLM:

```
You are a code documentation expert. Generate an intent.md file for the following changes.

REQUIRED FORMAT:
- YAML frontmatter: id, from, date, status, risk, tags, files
- Summary and Motivation sections
- Chunks with semantic anchors (@function:name, @class:Name, etc.)
- Decisions (> Decision: ...) explaining choices
- Links (@link ...) connecting related code

ANCHOR TYPES (prefer first ones):
1. @function:name - for functions
2. @class:Name - for classes
3. @method:Class.method - for methods
4. @pattern:text - for text search
5. @chunk:id - for conceptual content
6. @line:10-20 - AVOID if possible (fragile)

RULES:
- Explain WHY, not just WHAT
- One chunk = one concept
- Risk: low/medium/high based on impact

DIFF TO ANALYZE:
<diff>
{paste your diff here}
</diff>

Generate the complete intent.md file.
```

---

## Links

- Website: https://intentcode.github.io
- Format spec: https://github.com/intentcode/intent/blob/main/spec/intent-format.md
- Examples: https://github.com/intentcode/intent/tree/main/.intent/intents
