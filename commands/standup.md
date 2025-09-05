---
allowed-tools: ["mcp__goldfish__standup"]
description: "Generate daily standup report with yesterday's work, today's todos, and blockers"
---

Generate a daily standup report using the unified standup tool with intelligent relationship mapping.

$ARGUMENTS

## Standup Process:

### 1. Generate Comprehensive Standup Report
Use the unified standup tool which automatically aggregates data from checkpoints, todos, and plans:

```
standup({ 
  action: "daily",
  scope: "all",
  outputStyle: "meeting"
})
```

The unified standup tool will automatically:
- Gather timeline data from the last 24 hours
- Collect TODO lists across all workspaces
- Map relationships between plans, todos, and checkpoints
- Identify blockers and stalled work
- Format everything into a meeting-ready report

### 2. Alternative Options

For different standup formats, use these variations:

**Weekly Standup:**
```
standup({ 
  action: "weekly",
  scope: "all",
  outputStyle: "meeting"
})
```

**Written Report (for async teams):**
```
standup({ 
  action: "daily",
  scope: "all",
  outputStyle: "written"
})
```

**Executive Summary:**
```
standup({ 
  action: "project",
  scope: "all",
  outputStyle: "executive"
})
```

### 3. What the Tool Provides

The unified standup tool automatically handles:
- **Yesterday**: Extracts accomplishments from checkpoints and completed todos
- **Today**: Shows active and pending TODO items with IDs
- **Blockers**: Identifies stalled tasks, overdue items, and failing dependencies
- **Relationships**: Maps connections between plans, todos, and checkpoints
- **Metrics**: Shows progress percentages and completion rates

The output is formatted and ready for standup meetings without additional processing.