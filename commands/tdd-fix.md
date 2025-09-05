---
allowed-tools: ["Task", "mcp__goldfish__todo", "mcp__goldfish__checkpoint", "mcp__goldfish__recall", "mcp__codesearch__*"]
description: "TDD approach for fixing bugs and issues: write test for bug → fix → refactor → validate"
---

Apply Test-Driven Development to fix bugs, issues, and problems.

**CRITICAL: 100% COMPLETION REQUIRED**
This workflow costs 200k+ tokens - agents MUST complete ALL items in TodoLists.
NO partial completion allowed - one cycle = 100% of issues fixed.

$ARGUMENTS

## TDD Bug Fix & Issue Resolution

This command uses TDD principles to systematically fix bugs, address audit findings, and resolve issues while preventing regressions.

### 🎯 PERFECT FOR:
- **Bug Fixes**: Systematic resolution with regression prevention
- **Security Patches**: Fixing vulnerabilities with comprehensive testing
- **Performance Issues**: Addressing bottlenecks with measurable improvements  
- **Audit Findings**: Fixing issues discovered by `/audit` command
- **Production Issues**: Critical fixes that need thorough validation
- **Technical Debt**: Addressing shortcuts and workarounds systematically

### 🚫 NOT FOR:
- New feature development (use `/tdd-new` instead)
- Simple configuration changes
- Documentation-only updates
- Cosmetic changes that don't affect functionality

### 💡 INTEGRATES WITH `/audit`:
- Automatically retrieves audit findings and context
- Uses codebase-auditor handoff data for targeted fixes
- Perfect workflow: `/audit` → `/tdd-fix [critical issue]` → repeat

### Workflow: 🔴 REPRODUCE → 🟢 FIX → 🔵 REFACTOR → ✅ VALIDATE

## Execution Steps:

### Step 1: Check for Context
```javascript
// Check if this fix has context from codebase audit
const handoffs = todo();
recall({ 
  tags: ['handoff', 'to-tdd-fix', 'audit-phase'],
  since: '24h'
});
// If no audit handoff found, proceed with user's description of the issue
```

### Step 2: Initialize Fix Session  
```
todo({
  title: "TDD Bug Fix: $ARGUMENTS",
  items: [
    "🔴 Write failing test that reproduces the issue",
    "🟢 Implement minimal fix to make test pass",
    "🔵 Refactor fix for code quality and robustness", 
    "✅ Validate no regressions and update documentation"
  ]
})
```

### Step 3: 🔴 RED Phase - Reproduce Issue
```
Task({
  subagent_type: "test-designer",
  description: "Write test that reproduces the bug",
  prompt: `Write failing test that reproduces the issue: $ARGUMENTS

CRITICAL REQUIREMENTS FOR BUG REPRODUCTION:
- **GET COMPLETE CONTEXT**: Use todo() and recall() for ALL audit findings or issues
- Use CodeSearch to understand current implementation and locate issue
- Write test that FAILS in same way the bug manifests
- Test should demonstrate expected vs actual behavior
- Include edge cases that might be related
- Use exact type information from CodeSearch

WORKFLOW:
1. Check for auditor handoff with tags ['handoff', 'to-tdd-fix'] to get specific issue details
2. Use CodeSearch to locate relevant code and understand current behavior  
3. Research the issue - what should happen vs what actually happens
4. Write test that expects correct behavior but fails with current code
5. Ensure test fails for RIGHT reason (demonstrates the bug)
6. Store handoff data with bug analysis for implementer using tags ['handoff', 'from-test-designer', 'to-test-implementer']
7. **Mark REPRODUCE phase as completed:** todo() to mark status: "done"

EXAMPLE FOR AUDIT FINDINGS:
If audit found "SQL injection in UserService.cs:147":
- Use CodeSearch to examine UserService.GetUsers method  
- Write test that injects malicious SQL and expects it to be handled safely
- Verify test fails because current code is vulnerable
- Document the exact vulnerability pattern found

Remember: This test should FAIL and demonstrate the exact issue!`
})
```

### Step 4: 🟢 GREEN Phase - Fix the Issue
```
Task({
  subagent_type: "test-implementer",
  description: "Fix the issue minimally",
  prompt: `Fix the issue with minimal, focused changes: $ARGUMENTS

CRITICAL REQUIREMENTS FOR ISSUE FIXING:
- Retrieve handoff from test-designer using tags ['handoff', 'to-test-implementer'] (includes any audit context)
- Run failing test first to confirm it reproduces the issue
- Use CodeSearch to understand exact implementation details
- Make SMALLEST change possible to fix the root cause
- Focus ONLY on making the failing test pass
- Don't fix other potential issues (separate them)
- Verify all existing tests still pass

WORKFLOW:
1. Get handoff context from test design phase
2. Confirm test fails and reproduces issue exactly  
3. Use CodeSearch to trace code path causing the problem
4. Identify root cause (not just symptoms)
5. Implement minimal fix addressing root cause
6. Run all tests to ensure no regressions
7. Store handoff data about what was changed and why using tags ['handoff', 'from-test-implementer', 'to-refactoring-expert']
8. **Mark FIX phase as completed:** todo() to mark status: "done"

BUG FIX PRINCIPLES:
- Fix the cause, not symptoms
- Minimal change that solves the problem  
- Preserve all existing functionality
- No scope creep or "while I'm here" fixes

EXAMPLE FOR SECURITY ISSUES:
If fixing SQL injection vulnerability:
- Replace string concatenation with parameterized queries
- Only change the vulnerable method
- Ensure fix doesn't break existing functionality
- Document security improvement made

Remember: Make this ONE test green without breaking anything else!`
})
```

### Step 5: 🔵 REFACTOR Phase - Strengthen Fix
```
Task({
  subagent_type: "refactoring-expert",
  description: "Improve fix quality and robustness",
  prompt: `Refactor the fix for robustness while keeping tests green: $ARGUMENTS

CRITICAL REQUIREMENTS FOR FIX IMPROVEMENT:
- Retrieve handoff from test-implementer using tags ['handoff', 'to-refactoring-expert']
- All tests must pass before refactoring
- Use CodeSearch to understand all dependencies of the fix
- Look for similar issues that might exist elsewhere
- Ensure fix follows established security/quality patterns
- Make fix more maintainable and robust

WORKFLOW:
1. Get handoff context from fix implementation  
2. Use CodeSearch to analyze fixed code and dependencies
3. Look for similar patterns that might have same issue
4. Refactor for clarity, security, and maintainability
5. Check for related vulnerabilities or problems
6. Run tests after each change
7. Store handoff data about improvements made using tags ['handoff', 'from-refactoring-expert', 'to-test-reviewer']
8. **Mark REFACTOR phase as completed:** todo() to mark status: "done"

REFACTORING FOCUS FOR FIXES:
- Is the fix clear and self-documenting?
- Does it follow security best practices?
- Are there similar code paths with same potential issue?
- Can error handling be improved?
- Should this be a reusable pattern?

EXAMPLE FOR SECURITY FIXES:
- Extract parameterized query pattern into reusable utility
- Apply same security fix to similar methods
- Add input validation patterns consistently
- Improve error messages without exposing internal details

Remember: Make the fix robust and prevent similar issues!`
})
```

### Step 6: ✅ VALIDATE Phase - Comprehensive Check  
```
Task({
  subagent_type: "test-reviewer",
  description: "Validate fix and check for regressions",
  prompt: `Comprehensive validation of the fix: $ARGUMENTS

CRITICAL REQUIREMENTS FOR FIX VALIDATION:
- Retrieve handoff from refactoring-expert using tags ['handoff', 'to-test-reviewer']
- **PHASE 1: CLEANUP** - You are THE cleanup specialist:
  * Fix any test infrastructure issues left behind by previous phases
  * Run build and fix ALL warnings/errors introduced during fix
  * Run linting and fix ALL issues introduced during fix  
  * Remove unused imports, variables, and dead code
  * Ensure all test data and setup code works correctly
- **PHASE 2: VALIDATION** - Comprehensive fix verification:
  * Use CodeSearch to ensure all related code paths are tested
  * Verify no regressions in existing functionality
  * Check if similar issues exist elsewhere in codebase
  * Ensure test coverage around fix area is comprehensive
  * Validate that root cause is truly addressed

WORKFLOW:  
1. Get handoff context from refactoring phase
2. **CLEANUP FIRST**: Fix infrastructure, build warnings, linting issues
3. Use CodeSearch to map all code paths related to fix
4. Run full test suite to check for regressions
5. Search for similar code patterns that might have same issue
6. Verify edge cases around the fix are covered
7. Create additional tests if gaps found
8. Generate fix validation report
9. **Mark VALIDATE phase as completed:** todo() to mark status: "done"

VALIDATION CHECKLIST:
- [ ] Original issue test passes
- [ ] All existing tests still pass  
- [ ] No similar issues exist in codebase
- [ ] Edge cases are covered
- [ ] Root cause is documented
- [ ] Fix doesn't introduce new vulnerabilities

Remember: Issues often come in clusters. Find and prevent related problems!`
})
```

### Step 6: 📖 DOCUMENTATION Phase - Final Validation
```
Task({
  subagent_type: "doc-validator",
  description: "Final validation and cleanup", 
  prompt: `FINAL STEP: Validate documentation for fix: $ARGUMENTS

CRITICAL REQUIREMENTS:
- **Get handoff context** from previous TDD phases using goldfish recall
- Use CodeSearch to verify documented behavior matches fixed implementation
- Update any documentation affected by the bug fix
- Document the fix if it changes public behavior or APIs
- **Mark all handoffs complete** when done - you are the final step

WORKFLOW:
1. **Get handoff context** from previous phases to understand the scope of the fix
2. Use CodeSearch to verify current behavior matches docs
3. Update documentation that was affected by the bug
4. Add security notes if fix addressed vulnerability
5. **Mark handoffs complete** - workflow closed

Remember: You are the final step - clean up after yourself!`
})
```

### Step 7: Create Fix Completion Checkpoint
```
checkpoint({
  description: "TDD Fix Complete: $ARGUMENTS",
  highlights: [
    "🔴 Issue reproduced with failing test",
    "🟢 Minimal fix implemented and tested",
    "🔵 Fix refactored for robustness and maintainability", 
    "✅ No regressions found, similar issues checked"
  ],
  workContext: "Issue fixed using TDD - ready for deployment"
})
```

## Success Criteria:
- ✅ Failing test demonstrates the exact issue
- ✅ Minimal fix makes test pass without regressions
- ✅ Fix is robust and follows best practices  
- ✅ Similar issues identified and prevented
- ✅ Documentation reflects fixed behavior
- ✅ No new vulnerabilities introduced

## Integration with Codebase Auditor:
This command automatically retrieves audit findings and uses them to:
- Focus testing on specific issues found by auditor
- Understand exact locations and patterns of problems
- Apply systematic fixes with full context
- Prevent similar issues across the codebase

## Next Steps After Fix:
- Monitor for regression in production
- Update security documentation if applicable
- Consider adding automated checks to prevent similar issues
- Review related code areas for preventive improvements

**Use this command for all bug fixes and issue resolution to ensure systematic, test-driven repairs.**