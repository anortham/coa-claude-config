---
allowed-tools: ["Task", "mcp__goldfish__create_todo_list", "mcp__goldfish__update_todo", "mcp__goldfish__checkpoint", "mcp__goldfish__remember", "mcp__codenav__*", "mcp__codesearch__*"]
description: "Complete TDD cycle for new features: design tests → implement → refactor → review"
---

Complete Test-Driven Development cycle for new functionality.

$ARGUMENTS

## TDD New Feature Development

This command orchestrates your TDD team through the complete Red-Green-Refactor cycle for new features, enhancements, or functionality.

### 🎯 PERFECT FOR:
- **Greenfield Development**: Building new features from scratch
- **New Components**: Adding new services, controllers, or modules  
- **API Development**: Creating new endpoints with comprehensive testing
- **Feature Extensions**: Adding substantial functionality to existing systems
- **Test-First Architecture**: When you want rigorous specification through tests

### 🚫 NOT FOR:
- Bug fixes (use `/tdd-fix` instead)
- Simple changes that don't need comprehensive testing
- Quick patches or hotfixes
- Refactoring existing code without new functionality

### Workflow: 🔴 RED → 🟢 GREEN → 🔵 REFACTOR → ✅ REVIEW

## Execution Steps:

### Step 1: Initialize TDD Session
```
create_todo_list({
  title: "TDD New Feature: $ARGUMENTS",
  items: [
    "🔴 Design comprehensive test suite (RED phase)",
    "🟢 Implement minimal code to pass tests (GREEN phase)", 
    "🔵 Refactor and improve code quality (REFACTOR phase)",
    "✅ Review test coverage and validate (REVIEW phase)"
  ]
})
```

### Step 2: 🔴 RED Phase - Design Tests
```
Task({
  subagent_type: "test-designer",
  description: "Design comprehensive test suite",
  prompt: `Design a comprehensive test suite for new feature: $ARGUMENTS

CRITICAL REQUIREMENTS:
- Use CodeNav MCP to understand existing types and interfaces
- Find similar implementations in codebase for patterns  
- Write tests that fail for the RIGHT reasons (not compilation errors)
- Cover all scenarios: happy paths, edge cases, error conditions
- Use exact type signatures from CodeNav - no guessing!

WORKFLOW:
1. Use CodeNav to explore related code and understand domain
2. Design test strategy covering all scenarios  
3. Write comprehensive failing tests with proper type safety
4. Verify tests fail with meaningful error messages
5. Store handoff data for implementation phase
6. **Mark RED phase as completed:** update_todo() with status: "done"

Remember: Your tests ARE the specification!`
})
```

### Step 3: 🟢 GREEN Phase - Minimal Implementation
```
Task({
  subagent_type: "test-implementer", 
  description: "Implement minimal code to pass tests",
  prompt: `Make failing tests pass with MINIMAL implementation: $ARGUMENTS

CRITICAL REQUIREMENTS:
- First retrieve handoff from test-designer
- Use CodeNav aggressively for exact type information  
- Write SIMPLEST code that makes tests green
- Focus on one failing test at a time
- Apply YAGNI principle - You Aren't Gonna Need It
- Never modify tests to make them pass

WORKFLOW:
1. Get handoff context from previous phase
2. Run tests to confirm current failures
3. Use CodeNav for precise type requirements
4. Implement one test at a time with minimal code
5. Store handoff data for refactoring phase
6. **Mark GREEN phase as completed:** update_todo() with status: "done"

Remember: Perfect code comes later. Focus on GREEN tests!`
})
```

### Step 4: 🔵 REFACTOR Phase - Improve Quality
```
Task({
  subagent_type: "refactoring-expert",
  description: "Refactor while keeping tests green", 
  prompt: `Improve code quality while maintaining all passing tests: $ARGUMENTS

CRITICAL REQUIREMENTS:
- Retrieve handoff from test-implementer
- ALL tests must pass before starting refactoring
- Use CodeNav's refactoring tools when available
- Make incremental changes, testing after each one
- Apply SOLID principles and design patterns
- Never break existing tests

WORKFLOW:  
1. Get handoff context from implementation phase
2. Use CodeNav to analyze dependencies and references
3. Apply automated refactorings where possible
4. Make small improvements, testing continuously
5. Store handoff data for review phase
6. **Mark REFACTOR phase as completed:** update_todo() with status: "done"

Remember: Internal quality without changing external behavior!`
})
```

### Step 5: ✅ REVIEW Phase - Validate & Document
```
Task({
  subagent_type: "test-reviewer",
  description: "Review test coverage and quality",
  prompt: `Comprehensive review for new feature: $ARGUMENTS

CRITICAL REQUIREMENTS:
- Retrieve handoff from refactoring-expert
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
  * Create specific TODO items for any improvements needed
  * Verify TDD practices were followed

WORKFLOW:
1. Get handoff context from refactoring phase
2. **CLEANUP FIRST**: Fix infrastructure, build warnings, linting issues
3. Use CodeNav to map all code paths and interfaces
4. Analyze test coverage comprehensively
5. Review test quality and identify improvements
6. Generate actionable improvement plan
7. **Mark REVIEW phase as completed:** update_todo() with status: "done"

Remember: Good tests enable confident future changes!`
})
```

```
Task({
  subagent_type: "doc-validator", 
  description: "Validate documentation accuracy",
  prompt: `Validate documentation matches implementation: $ARGUMENTS

CRITICAL REQUIREMENTS:
- Use CodeNav as source of truth for all validations
- Check every documented method, parameter, and behavior
- Test all code examples to ensure they work
- Update any outdated documentation
- Never trust docs over actual code

WORKFLOW:
1. Identify all documentation related to new feature
2. Use CodeNav to verify every claim in docs
3. Test all code examples for accuracy
4. Fix discrepancies (update docs, not code)
5. Ensure examples work with current implementation

Remember: Stale docs are worse than no docs!`
})
```

### Step 6: Create Final Checkpoint
```
checkpoint({
  description: "TDD New Feature Complete: $ARGUMENTS",
  highlights: [
    "🔴 RED: Comprehensive test suite designed and failing",
    "🟢 GREEN: Minimal implementation passes all tests", 
    "🔵 REFACTOR: Code quality improved while tests stay green",
    "✅ REVIEW: Coverage validated and documentation updated"
  ],
  workContext: "New feature ready for integration and deployment"
})
```

## Success Criteria:
- ✅ Comprehensive test suite covering all scenarios
- ✅ All tests passing with clean implementation
- ✅ Code refactored for quality and maintainability
- ✅ Test coverage validated and gaps addressed
- ✅ Documentation accurate and up-to-date

## Next Steps After Completion:
- Integration testing with existing features
- Performance testing if applicable  
- Security review for new functionality
- Deployment planning

**Use this command for all new feature development to ensure rigorous TDD practices.**