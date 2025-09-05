# Claude Code Development Standards

## Core Principles

1. **Verify before coding** - Always use CodeSearch tools to check types and signatures
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
mcp__codesearch__index_workspace - Build/update search index
```

### Advanced CodeSearch Tools

**Use for precise type verification and navigation:**

```
mcp__codesearch__symbol_search - Find classes, interfaces, methods by name
mcp__codesearch__goto_definition - Jump to symbol definitions
mcp__codesearch__find_references - Find all usages of symbols
mcp__codesearch__line_search - Line-by-line search (replaces grep)
mcp__codesearch__directory_search - Find directories
mcp__codesearch__similar_files - Find similar code
mcp__codesearch__search_and_replace - Bulk find & replace
mcp__codesearch__batch_operations - Multiple operations at once
```

### Goldfish MCP (C:\source\COA Goldfish MCP)

**PROACTIVELY use for session management (Unified Tools):**

```
mcp__goldfish__checkpoint - Save progress or restore sessions (unified tool)
mcp__goldfish__todo - Manage tasks efficiently with smart keywords
mcp__goldfish__plan - Strategic planning and feature design 
mcp__goldfish__standup - Daily work summaries and progress reports
```

**Support Tools:**
```
mcp__goldfish__search_history - Find past work and solutions
mcp__goldfish__timeline - Review work progress chronologically  
mcp__goldfish__recall - Restore working context after breaks
```

**Use Goldfish instead of TodoWrite for all task management**

### Unified Tool Usage Patterns

**Smart Keywords Work Everywhere:**
- `listId: "latest"` - Most recent TODO list
- `listId: "active"` - Current work list
- `planId: "latest"` - Most recent plan
- `since: "yesterday"` - Natural time ranges

**Action Inference:**
- `checkpoint({ description: "..." })` → automatically saves
- `todo({ newTask: "..." })` → automatically adds to latest list
- `plan({ title: "...", description: "..." })` → automatically creates

**Quick Commands:**
- `todo({ action: "quick", quick: "add implement auth" })`
- `todo({ action: "quick", quick: "done 3" })`

## Development Standards

### Before Making Changes

1. **Search first** with CodeSearch MCP
2. **Verify types** with CodeSearch MCP navigation tools
3. **Create checkpoint** with Goldfish MCP
4. **Follow existing patterns** in the codebase

### CodeSearch Best Practices

**Index Management:**
- Always run `mcp__codesearch__index_workspace` for new workspaces
- Use `forceRebuild: true` if search results seem outdated

**Smart Search Strategy:**
- Start with `text_search` for general code patterns
- Use `symbol_search` for specific classes/methods
- Use `file_search` when you know approximate file names
- Use `find_references` before refactoring to see usage

**Multi-workspace Support:**
- Each workspace gets isolated index in `.coa/codesearch/`
- Can search multiple workspaces simultaneously
- Cross-platform compatible with reliable locking

### Code Organization

- **One class/type per file** (exceptions: closely related types)
- **Keep files under 300 lines** (500 max)
- **Filename matches type name exactly**

### Type Verification Examples

```
❌ WRONG: Assume User has fullName property
✅ RIGHT: mcp__codesearch__goto_definition → See actual properties

❌ WRONG: Assume array.Contains() exists
✅ RIGHT: mcp__codesearch__symbol_search → Verify language-specific methods

❌ WRONG: Guess async method names
✅ RIGHT: mcp__codesearch__text_search → Find actual method signatures
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
- [ ] Run mcp__goldfish__checkpoint (action="restore") if continuing
- [ ] Check mcp__codesearch__recent_files for context

**Before coding:**

- [ ] Used CodeSearch MCP to find existing code
- [ ] Used CodeSearch navigation tools to verify types
- [ ] Created Goldfish checkpoint

**Task management:**

- [ ] Use mcp__goldfish__todo for all task management
- [ ] Use mcp__goldfish__plan for strategic planning
- [ ] Create checkpoints at milestones

**Before submitting:**

- [ ] Tests pass with evidence
- [ ] Created final Goldfish checkpoint
- [ ] Documented decisions

## When Uncertain

- "Let me search for that with CodeSearch MCP"
- "I'll verify the exact type with CodeSearch navigation tools"
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

_Remember: 30 seconds with CodeSearch MCP saves 30 minutes of debugging_
