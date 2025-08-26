---
allowed-tools: ["Task", "mcp__goldfish__checkpoint", "mcp__goldfish__remember", "mcp__goldfish__recall", "mcp__goldfish__update_todo", "mcp__codenav__*", "mcp__codesearch__*"]
description: "Run individual TDD phase: test|implement|refactor|review - for advanced users"
---

Execute a specific TDD phase individually.

Usage: `/tdd-phase [test|implement|refactor|review|validate] [description]`

$ARGUMENTS

## Individual TDD Phase Execution

For advanced users who want to run specific TDD phases independently or when continuing from a specific point in the TDD cycle.

### 🎯 PERFECT FOR:
- **Surgical Precision**: Focusing on one specific aspect of TDD
- **Continuing Work**: Resuming interrupted TDD workflows
- **Partial Implementation**: When you have some phases already done
- **Advanced Control**: Fine-grained control over the TDD process
- **Learning TDD**: Understanding each phase individually
- **Iterative Improvement**: Cycling through specific phases multiple times

### 🚫 NOT FOR:
- Complete feature development (use `/tdd-new` instead)
- Complete bug fixes (use `/tdd-fix` instead) 
- Beginners who need guided full-cycle workflow
- When you want automatic phase transitions

### 💡 INTEGRATES WITH FULL CYCLES:
- Uses same handoff system as `/tdd-new` and `/tdd-fix`
- Can continue where full cycles left off
- Perfect for iterative refinement of specific aspects

### Phase Options:

## 🔴 TEST Phase (Red)
```
Task({
  subagent_type: "test-designer",
  description: "Design comprehensive test suite",
  prompt: `Design comprehensive test suite for: [description from $ARGUMENTS]

CRITICAL REQUIREMENTS:
- Use CodeNav MCP to understand existing types and interfaces  
- Find similar implementations for consistency patterns
- Write tests that fail for RIGHT reasons (clear spec, not compilation errors)
- Cover all scenarios: happy paths, edge cases, error conditions
- Use exact type signatures from CodeNav - never guess!
- Create handoff data for next phase

WORKFLOW:
1. Use CodeNav to explore related code and understand domain
2. Design test strategy covering comprehensive scenarios
3. Write failing tests with proper type safety
4. Verify tests fail with meaningful error messages
5. Store handoff for implementation phase

Remember: Tests ARE the specification - make them comprehensive!`
})
```

## 🟢 IMPLEMENT Phase (Green)  
```
Task({
  subagent_type: "test-implementer",
  description: "Implement code to pass tests",
  prompt: `Write minimal code to make tests pass: [description from $ARGUMENTS]

CRITICAL REQUIREMENTS:
- Retrieve handoff from test-designer if available
- Use CodeNav aggressively for exact type information
- Write SIMPLEST code that makes tests green
- Apply YAGNI principle - You Aren't Gonna Need It
- Focus on one failing test at a time
- Never modify tests to make them pass

WORKFLOW:
1. Check for handoff context from test phase
2. Run tests to confirm current failures  
3. Use CodeNav for precise type requirements
4. Implement one test at a time with minimal code
5. Store handoff for refactoring phase

Remember: Perfect code comes later - focus on GREEN tests!`
})
```

## 🔵 REFACTOR Phase (Refactor)
```
Task({
  subagent_type: "refactoring-expert", 
  description: "Improve code quality while keeping tests green",
  prompt: `Refactor code for quality while maintaining green tests: [description from $ARGUMENTS]

CRITICAL REQUIREMENTS:
- Retrieve handoff from test-implementer if available
- ALL tests must pass before starting
- Use CodeNav's refactoring tools when available
- Make incremental changes, testing after each one
- Apply SOLID principles and design patterns appropriately
- Never break existing tests

WORKFLOW:
1. Check for handoff context from implementation phase
2. Use CodeNav to analyze dependencies and references
3. Apply automated refactorings where possible  
4. Make small improvements, testing continuously
5. Store handoff for review phase

Remember: Internal quality without changing external behavior!`
})
```

## ✅ REVIEW Phase (Review)
```
Task({
  subagent_type: "test-reviewer",
  description: "Review test coverage and quality", 
  prompt: `Comprehensive quality review: [description from $ARGUMENTS]

CRITICAL REQUIREMENTS:
- Retrieve handoff from refactoring-expert if available
- **PHASE 1: CLEANUP** - You are THE cleanup specialist:
  * Fix any test infrastructure issues (missing matchers, broken imports)
  * Run build and fix ALL warnings/errors introduced
  * Run linting and fix ALL issues introduced  
  * Remove unused imports, variables, and dead code
  * Ensure all test data and setup code works correctly
- **PHASE 2: REVIEW** - Comprehensive quality assessment:
  * Use CodeNav to trace EVERY code path
  * Generate coverage reports and identify gaps
  * Check test quality and maintainability
  * Create TODO items for improvements needed
  * Verify TDD practices were followed

WORKFLOW:
1. Check for handoff context from refactoring phase
2. **CLEANUP FIRST**: Fix infrastructure, build warnings, linting issues
3. Use CodeNav to map all code paths and interfaces  
4. Analyze test coverage comprehensively
5. Review test quality and identify improvements
6. Generate actionable improvement plan

Remember: Good tests enable confident future changes!`
})
```

## 📝 VALIDATE Phase (Validate Documentation)
```
Task({
  subagent_type: "doc-validator",
  description: "Validate documentation accuracy",
  prompt: `Validate documentation matches implementation: [description from $ARGUMENTS]

CRITICAL REQUIREMENTS:
- Use CodeNav as source of truth for all validations
- Check every documented method, parameter, and behavior
- Test all code examples to ensure they work
- Update any outdated documentation  
- Never trust docs over actual code

WORKFLOW:
1. Identify all documentation related to the feature/change
2. Use CodeNav to verify every claim in documentation
3. Test all code examples for accuracy
4. Fix discrepancies (update docs, not code)
5. Ensure examples work with current implementation

Remember: Stale documentation is worse than no documentation!`
})
```

### Create Phase Checkpoint
```
checkpoint({
  description: "TDD Phase Complete: [phase] for [description]",
  highlights: [
    "Phase [phase] executed successfully",
    "Handoff data stored for next phase",
    "Ready for next step in TDD cycle"
  ],
  workContext: "Individual phase complete - continue with next phase as needed"
})
```

## Usage Examples:

**Start with tests only:**
```
/tdd-phase test "User authentication with email validation"
```

**Implement after tests exist:**
```
/tdd-phase implement "User authentication - make failing tests pass"  
```

**Refactor existing working code:**
```
/tdd-phase refactor "Clean up UserService after basic implementation"
```

**Review and validate coverage:**
```
/tdd-phase review "Validate test coverage for authentication feature"
```

**Validate documentation accuracy:**
```
/tdd-phase validate "Ensure authentication docs match implementation"
```

## When to Use Individual Phases:

- **Test Phase**: When you want to design comprehensive tests before any implementation
- **Implement Phase**: When tests exist but need implementation  
- **Refactor Phase**: When code works but needs quality improvements
- **Review Phase**: When you want to audit test coverage and quality
- **Validate Phase**: When you need to ensure documentation matches implementation

## Integration with Full Cycle Commands:

This command works with `/tdd-new` and `/tdd-fix`:
- Can continue where full cycle left off
- Uses same handoff system for context preservation  
- Maintains same quality standards and tool usage

## Success Criteria:
- ✅ Selected phase executed with high quality
- ✅ Handoff data preserved for next phase
- ✅ TDD principles maintained throughout
- ✅ Ready to continue with next phase when needed

**Use this command when you need fine-grained control over the TDD process or want to focus on improving a specific aspect.**