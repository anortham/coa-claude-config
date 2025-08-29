---
allowed-tools: ["Task", "mcp__goldfish__create_todo_list", "mcp__goldfish__view_todos", "mcp__goldfish__recall", "mcp__codenav__*", "mcp__codesearch__*"]
description: "Comprehensive codebase audit to find technical debt, security issues, and hidden problems"
---

Run comprehensive codebase audit to expose hidden problems and technical debt.

$ARGUMENTS

## Codebase Health Assessment

This command uses the codebase-auditor to investigate code quality within the requested scope, finding issues that need systematic fixes.

Perfect for:
- Pre-release health checks
- Technical debt assessment  
- New team member onboarding
- Quarterly code reviews
- Before major refactoring efforts

## Execution:

### Step 1: Launch Comprehensive Audit
```
Task({
  subagent_type: "codebase-auditor",
  description: "Comprehensive codebase audit",
  prompt: `Perform comprehensive audit of codebase: $ARGUMENTS

AUDIT MISSION:
- Find problems within the requested audit scope
- Use CodeNav and CodeSearch for systematic investigation
- Create user-visible TODO list of significant issues found
- Create goldfish handoff with structured details for TDD team to fix issues
- Report code quality issues relevant to the audit scope

SYSTEMATIC INVESTIGATION PROCESS:

**Phase 1: Surface Problems**
- Search for TODO, FIXME, HACK, XXX comments
- Find NotImplementedException or equivalent stubs
- Locate commented-out code blocks  
- Search for console.log/print debug statements

**Phase 2: CodeNav Deep Dive**
- Map inheritance hierarchies (find god classes)
- Trace method calls (find dead code)
- Check interfaces for implementations
- Identify circular dependencies
- Find tightly coupled components

**Phase 3: Security & Performance Scan**
- Search for hardcoded credentials/API keys
- Find SQL concatenation (injection risks)
- Identify potential memory leaks
- Find inefficient queries or loops
- Locate error suppression patterns

**Phase 4: Test Coverage Reality Check**
- Find code with no test coverage
- Identify tests with no assertions
- Find commented-out or skipped tests
- Check for superficial testing

**MANDATORY DELIVERABLES:**
1. User-visible TODO list with critical/serious issues found
2. **Create goldfish handoff** with structured data for TDD team
3. Project health score out of 100
4. Clear priority order for fixing issues

**SUCCESS CRITERIA:**
- Every problem found is documented with file:line references
- User can immediately see what needs fixing
- TDD team has complete context to start systematic fixes
- Issues are prioritized by actual risk level

Remember: Your job is to find problems AND prepare the way for systematic fixes!`
})
```

### Step 2: Create Audit Summary Checkpoint
```
checkpoint({
  description: "Codebase Audit Complete: $ARGUMENTS",
  highlights: [
    "Comprehensive code quality assessment completed",
    "Critical and serious issues identified and documented", 
    "TODO list created for user visibility",
    "TDD team handoff data stored for systematic fixes"
  ],
  workContext: "Audit complete - ready for systematic issue resolution using /tdd-fix"
})
```

## After Audit Completion:

### Next Steps:
1. **Review TODO List**: Check the created TODO list to see discovered issues
2. **Start Fixing Critical Issues**: Use `/tdd-fix [critical issue]` to systematically address problems  
3. **Track Progress**: Monitor issue resolution over time
4. **Schedule Regular Audits**: Prevent technical debt accumulation

### Integration with TDD Workflow:
- **Audit findings** available in goldfish handoff for `/tdd-fix` command
- **Structured handoff** includes CodeNav analysis and search patterns stored in metadata
- **Priority order** guides which issues to fix first
- **Evidence trail** provides exact locations and patterns in todo items
- **doc-validator** runs after fixes to ensure documentation updated

### Success Criteria:
- ✅ All technical debt and issues exposed
- ✅ Clear action plan with priorities
- ✅ User can see exactly what needs fixing
- ✅ TDD team ready to systematically address problems

## When to Use This Command:

**Before Major Releases:**
- Find showstopper issues early
- Assess deployment readiness
- Identify last-minute fixes needed

**Quarterly Health Checks:**
- Prevent technical debt accumulation
- Track code quality over time
- Plan improvement sprints

**New Team Member Onboarding:**
- Understand real codebase state
- Identify learning priorities
- Set realistic expectations

**Before Large Refactoring:**
- Understand current quality baseline
- Identify high-risk areas
- Plan systematic improvements

**After Inheriting Codebase:**
- Discover undocumented problems
- Assess maintenance burden
- Plan quality improvements

**The Brutal Truth:**
This command doesn't sugarcoat problems. It finds every shortcut, hack, and issue in your code. Use it when you're ready to face reality and systematically improve your codebase quality.

**Ready for systematic fixes? Run `/tdd-fix [issue]` after the audit to address problems using proper TDD methodology.**