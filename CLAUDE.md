# Claude Code Development Standards

## Session Initialization
- **ALWAYS** state explicitly at session start: "Today is [YYYY-MM-DD]"
- Use only this stated date for all date/time operations in the session
- Never assume or use system dates

## Development Workflow

### Step 1: Understand Before Acting
When presented with any task:
1. **Read and analyze** existing code structure
2. **Document** current behavior and architecture patterns
3. **Identify** actual vs perceived issues with concrete evidence
4. **Create a plan** that respects existing patterns and conventions

### Step 2: Type Verification Protocol
Before using any type, class, interface, or method:
1. **Locate** the actual definition file using CodeNav tools
2. **Read** the complete definition and implementation
3. **Note** exact property names, method signatures, and return types
4. **Verify** inheritance chains and interface implementations
5. **Only then** write code using that type

#### Verification Examples:
```
❌ WRONG: Assume User has fullName property
✅ RIGHT: Find User.ts → See firstName, lastName → Use exact names

❌ WRONG: Assume array.Contains() exists in TypeScript
✅ RIGHT: Verify TypeScript uses array.includes()

❌ WRONG: Assume async method exists (e.g., HasAsync)
✅ RIGHT: Check actual class definition for available methods
```

### Step 3: Implementation Standards
1. **One class/type per file** (exceptions: closely related types, enums)
2. **Filename must match** the primary type name exactly
3. **Keep files focused** - under 300 lines preferred, 500 lines maximum
4. **Test changes** incrementally - don't accumulate untested modifications
5. **Provide evidence** for all claims (error messages, test outputs, logs)

## Code Investigation Protocol

### Before Claiming an Issue Exists:
- [ ] Located ALL relevant code files
- [ ] Read complete implementation including dependencies
- [ ] Understood design intent and business logic
- [ ] Verified issue with specific evidence (line numbers, error messages)
- [ ] Checked if "issue" is intentional design decision

### Before Making Changes:
- [ ] Understood why current code exists (check git history if needed)
- [ ] Identified all consumers and dependencies
- [ ] Created plan following existing patterns and conventions
- [ ] Verified type definitions and method signatures
- [ ] Considered backward compatibility implications

### Before Declaring "Fixed":
- [ ] Executed and tested the specific fix
- [ ] Ran existing test suite
- [ ] Checked for regressions in related functionality
- [ ] Confirmed root cause addressed (not just symptoms)
- [ ] Provided verification evidence (test output, screenshots)

## Language-Specific Gotchas

### TypeScript/JavaScript
- Array methods: `includes()` not `Contains()`
- String methods: `includes()` not `contains()`
- Async patterns: `async/await` not `Task.Run`
- Import verification: Check actual exports, not assumptions

### C#/.NET
- LINQ requires `using System.Linq;`
- Async methods don't always have `Async` suffix
- Collection types vary (`List<T>`, `IEnumerable<T>`, `ICollection<T>`)
- Nullable reference types change behavior

### Cross-Language
- Case sensitivity differs (C# PascalCase vs JS camelCase)
- Null/undefined handling varies
- Collection iteration patterns differ
- Date/time handling is platform-specific

## Common Pitfalls to Avoid

### Type System Errors
❌ Assuming method names from other languages
❌ Guessing property names from naming conventions
❌ Assuming async variants exist without checking
❌ Using language features without verifying imports/usings
❌ Mixing naming conventions between languages

### Investigation Errors
❌ Changing code without understanding its purpose
❌ Trial-and-error debugging without hypothesis
❌ Modifying tests to pass rather than fixing actual issues
❌ Declaring success without concrete verification
❌ Ignoring existing patterns for "better" solutions

### Communication Errors
❌ Using vague terms like "should work" or "probably fixed"
❌ Not admitting uncertainty when unsure
❌ Making changes without explaining rationale
❌ Skipping verification steps due to confidence

## Testing Requirements

### For Bug Fixes:
1. Reproduce the original issue
2. Apply the fix
3. Verify issue is resolved
4. Check for side effects
5. Document what was wrong and why fix works

### for New Features:
1. Write tests first when possible
2. Cover happy path and edge cases
3. Test error conditions
4. Verify integration with existing code
5. Document expected behavior

## Code Comments and Documentation

### Comment Maintenance:
- **Verify** comment accuracy against actual code
- **Update** stale comments immediately when found
- **Remove** misleading comments rather than leaving them
- **Add** comments for complex logic or non-obvious decisions

### Comment Standards:
```typescript
// ❌ BAD: Increment counter
counter++;

// ✅ GOOD: Retry counter - max 3 attempts before failing
counter++;

// ✅ GOOD: Using setTimeout instead of setInterval to prevent 
//         overlapping calls if processing takes longer than interval
```

## When Uncertain

### Clear Communication:
- State explicitly: "I need to verify [specific item] before proceeding"
- Ask: "Can you show me where [type/method] is defined?"
- Admit: "I'm not certain about [specific aspect], let me investigate"

### Investigation Before Assumption:
- Use CodeNav tools to explore codebase
- Read related files for context
- Check for existing similar patterns
- Look for tests that demonstrate usage

## Error Handling Standards

### When Encountering Errors:
1. **Read** the complete error message
2. **Identify** the exact line and file
3. **Understand** what the error is actually saying
4. **Research** the specific error if unfamiliar
5. **Fix** the root cause, not symptoms

### Error Response Pattern:
```
Error detected: [exact error message]
Location: [file:line]
Cause: [specific reason]
Solution: [concrete fix with rationale]
Verification: [how to confirm it's fixed]
```

## Session Best Practices

### Start of Session:
- State current date
- Confirm project context
- Review recent changes if continuing work
- Verify environment setup

### During Development:
- Save progress incrementally
- Test changes frequently
- Document decisions and rationale
- Keep track of modified files

### End of Session:
- Summarize changes made
- List any pending issues
- Note any assumptions made
- Provide clear next steps

## Feedback Standards

### Provide Objective Feedback:
- Base feedback on code analysis, not assumptions
- Cite specific line numbers and files
- Explain why something is problematic
- Offer concrete alternatives

### Even When It Contradicts Expectations:
- Politely correct misconceptions
- Explain actual behavior vs expected
- Provide evidence for claims
- Suggest better approaches

## Performance Considerations

### Always Consider:
- Algorithm complexity (O(n) vs O(n²))
- Memory usage patterns
- Database query efficiency
- Network request optimization
- Caching opportunities

### Red Flags to Address:
- Nested loops over large datasets
- Unbounded recursive calls
- Memory leaks from unclosed resources
- N+1 query problems
- Synchronous I/O in async contexts

## Version Control Awareness

### Commit Practices:
- Make atomic, focused changes
- Write clear commit messages
- Don't mix refactoring with features
- Test before committing

### Commit Message Format:
```
type: brief description

- Specific change 1
- Specific change 2
- Fixes: [issue reference if applicable]
```

---

## Quick Reference Checklist

Before starting any task:
- [ ] Stated today's date
- [ ] Understood the requirement
- [ ] Investigated existing code
- [ ] Verified all types and methods
- [ ] Created implementation plan

Before submitting changes:
- [ ] Tested all modifications
- [ ] Checked for regressions
- [ ] Updated relevant comments
- [ ] Provided verification evidence
- [ ] Documented decisions made