# Claude Code Development Standards

## Core Principles

1. **Verify before coding** - Always use CodeNav tools to check types and signatures
2. **Evidence-based development** - Support all claims with concrete proof
3. **Pragmatic simplicity** - Choose the simplest solution that meets requirements
4. **Incremental progress** - Test frequently, save progress regularly
5. **Ask for help** - User is an experienced developer and architect, if you get stuck, ask for help

## Session Protocol

- **Start**: State "Today is [YYYY-MM-DD]" and use only this date
- **During**: Document decisions, test changes, track modified files
- **End**: Summarize changes, list pending issues, provide next steps

## CRITICAL: Use MCP Tools First

### CodeSearch MCP (C:\source\COA CodeSearch MCP)

**ALWAYS use before writing code to:**

- Find type definitions and method signatures
- Search for existing implementations
- Locate similar patterns in codebase
- Verify imports and dependencies

**Essential searches:**

```
mcp__codesearch__text_search - Find code patterns
mcp__codesearch__file_search - Locate files by name
mcp__codesearch__recent_files - See what changed recently
```

### CodeNav MCP

**Use for precise type verification:**

```
mcp__codenav__csharp_symbol_search - Find C# symbols
mcp__codenav__ts_symbol_search - Find TypeScript symbols
mcp__codenav__[lang]_goto_definition - Jump to definitions
mcp__codenav__[lang]_find_all_references - Find usages
```

### Goldfish MCP (C:\source\COA Goldfish MCP)

**PROACTIVELY use for session management:**

```
mcp__goldfish__checkpoint - Save progress frequently
mcp__goldfish__restore_session - Resume after breaks
mcp__goldfish__create_todo_list - Track complex tasks
mcp__goldfish__update_todo - Mark progress
```

**Use Goldfish instead of TodoWrite for task management**

## Development Standards

### Before Making Changes

1. **Search first** with CodeSearch MCP
2. **Verify types** with CodeNav MCP
3. **Create checkpoint** with Goldfish MCP
4. **Follow existing patterns** in the codebase

### Code Organization

- **One class/type per file** (exceptions: closely related types)
- **Keep files under 300 lines** (500 max)
- **Filename matches type name exactly**

### Type Verification Examples

```
❌ WRONG: Assume User has fullName property
✅ RIGHT: mcp__codenav__ts_goto_definition → See actual properties

❌ WRONG: Assume array.Contains() exists
✅ RIGHT: Verify language-specific method (includes() in JS)

❌ WRONG: Guess async method names
✅ RIGHT: mcp__codenav__csharp_get_type_members → See actual methods
```

## Language-Specific Notes

### TypeScript/JavaScript

- Array/String: `includes()` not `Contains()`
- Always verify imports exist
- Check actual export names

### C#/.NET

- LINQ needs `using System.Linq;`
- Not all async methods have `Async` suffix
- Check nullable reference types

## Error Handling Protocol

```
Error: [exact message]
Location: [file:line]
Cause: [specific reason]
Fix: [concrete solution]
Verified: [proof it works]
```

## Testing Requirements

1. **Reproduce** issue first
2. **Apply** fix
3. **Verify** with evidence
4. **Check** for regressions
5. **Document** what changed

## Quick Reference Checklist

**Session start:**

- [ ] State today's date
- [ ] Run mcp**goldfish**restore_session if continuing
- [ ] Check mcp**codesearch**recent_files for context

**Before coding:**

- [ ] Used CodeSearch MCP to find existing code
- [ ] Used CodeNav MCP to verify types
- [ ] Created Goldfish checkpoint

**Task management:**

- [ ] Use mcp**goldfish**create_todo_list for complex tasks
- [ ] Update progress with mcp**goldfish**update_todo
- [ ] Create checkpoints at milestones

**Before submitting:**

- [ ] Tests pass with evidence
- [ ] Created final Goldfish checkpoint
- [ ] Documented decisions

## When Uncertain

- "Let me search for that with CodeSearch MCP"
- "I'll verify the exact type with CodeNav"
- "Creating a checkpoint before this change"

## Pragmatic Engineering

**DO:**
✅ Use MCP tools before assuming
✅ Follow existing patterns
✅ Keep solutions simple
✅ Save progress with Goldfish

**DON'T:**
❌ Create unnecessary abstractions
❌ Add "future flexibility" without need
❌ Skip type verification
❌ Forget to checkpoint progress

---

_Remember: 30 seconds with CodeSearch/CodeNav saves 30 minutes of debugging_
