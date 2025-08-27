---
allowed-tools: ["mcp__goldfish__timeline", "mcp__goldfish__view_todos", "mcp__goldfish__recall"]
description: "Generate daily standup report with yesterday's work, today's todos, and blockers"
---

Generate a daily standup report with what was done yesterday, what's planned for today, and any blockers.

$ARGUMENTS

## Standup Process:

### 1. Gather Data
```
timeline({ since: "24h", scope: "all" })
view_todos({ scope: "all" })
recall({ since: "24h", scope: "all" })
```

### 2. Format Standup Report

**CRITICAL**: Process timeline data.byDate thoroughly - do not skip workspaces with few checkpoints!

Example timeline parsing:
```
for (date in timeline.data.byDate) {
  for (workspace in timeline.data.byDate[date]) {
    const highlights = timeline.data.byDate[date][workspace].highlights;
    // Process ALL highlights regardless of count (1 or 100)
    // Single checkpoint with 7 highlights = major work!
  }
}
```

Display a formatted standup report:

```
═══════════════════════════════════════════════════════════
📅 DAILY STANDUP - {TODAY'S DATE}
═══════════════════════════════════════════════════════════

📍 **YESTERDAY** - What I accomplished:
   • {checkpoint/commit from timeline}
   • {another accomplishment}
   • {key work done}

🎯 **TODAY** - What I'm working on:
   • [1] {active todo item}
   • [2] {pending todo item}  
   • [3] {another pending item}

🚧 **BLOCKERS** - Issues preventing progress:
   • {overdue todo items or stalled tasks}
   • {external dependencies or questions}
   • {failing tests or build issues}

═══════════════════════════════════════════════════════════
💡 Ready to discuss in standup!
═══════════════════════════════════════════════════════════
```

### 3. Implementation Notes

**Data Extraction**:
- Parse timeline data.byDate to extract ALL workspace accomplishments
- Process EVERY workspace regardless of checkpoint count (1 important > 10 minor)
- Extract highlights arrays from each checkpoint as accomplishments
- Categorize by actual time: "Today" (last 16 hours), "Yesterday" (16-40 hours ago)
- Sort by significance: highlight count, impact keywords, then recency
- Extract todo items with IDs and status
- Identify actual blockers: failing tests, external dependencies, stalled tasks

**Blocker Identification Rules**:
- Only include items that are PREVENTING progress
- Exclude completed or successfully working items
- Focus on actionable problems needing resolution
- Include overdue tasks (>24h with 0% progress)

**Formatting Rules**:
- Extract accomplishments from timeline data.byDate[date][workspace].highlights arrays
- Don't skip workspaces with single checkpoints - they may be most important work
- Group work by project/workspace: [ProjectName] Major accomplishment description
- Show todo IDs for easy reference  
- Keep blockers section focused on actual impediments
- Keep concise - one line per item
- Weight accomplishments by: highlight count (7 highlights = major), keywords (implemented/completed/fixed), file count