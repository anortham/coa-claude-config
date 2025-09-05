---
allowed-tools: ["mcp__goldfish__checkpoint", "mcp__goldfish__todo", "mcp__goldfish__recall"]
hide-output: true
description: "Resume work from the most recent checkpoint with enhanced display"
---

Load the most recent checkpoint and continue work from where we left off.

$ARGUMENTS

## Resume Process:

### 1. Gather Session Data
```
checkpoint({ action: "restore", depth: "highlights" })
todo({ action: "view" })
```

### 2. Format and Display Results Manually
**IMPORTANT**: Extract data from tool responses and format it yourself - DO NOT just show tool output.

Display format:
```
═══════════════════════════════════════════════════════════
📍 RESUMING FROM CHECKPOINT: {CHECKPOINT_ID}
═══════════════════════════════════════════════════════════

📝 **Last Work:** {description}
🎯 **Context:** {work_context}
🌿 **Branch:** {git_branch}
📁 **Files:** {active_files}

🌟 **Session Highlights:**
   ✨ {highlight1}
   ✨ {highlight2}
   ✨ {highlight3}

═══════════════════════════════════════════════════════════
📋 ACTIVE TODO LISTS
═══════════════════════════════════════════════════════════

📝 **{list_title}** - {progress}% ({completed}/{total})
   ✅ [1] {completed_task}
   🔄 [2] {active_task}
   ⏳ [3] {pending_task}
   ⏳ [4] {another_pending_task}
   ⏳ [5] {yet_another_task}

═══════════════════════════════════════════════════════════
✅ Session restored successfully
📝 {pending_count} pending tasks ready
🚀 Ready to continue. What would you like to work on?
═══════════════════════════════════════════════════════════
```

### 3. Implementation Notes

**Key Pattern**: 
- Call tools to get data (checkpoint, todo)
- Parse the JSON responses to extract values
- Display formatted information in YOUR message
- This prevents CLI collapse since it's your direct output

**Data Extraction**:
- Parse checkpoint from `data[0].content`: description, workContext, gitBranch, activeFiles, highlights
- Parse todos from `data.items`: iterate through each item showing [id] task with status icon
- Calculate pending count: total - completed
- Format with proper icons: ✅ (done) 🔄 (active) ⏳ (pending)

**Important Formatting Rules**:
- ALWAYS show todo item IDs in brackets: [1], [2], [3], etc.
- Show ALL todo items, not just examples
- Use the exact ID from the item, don't renumber
- Keep task descriptions on one line (truncate if > 70 chars)

### 4. Example TODO Display
When displaying todos, show them exactly like this:
```
📝 **Bug Fixes** - 40% (2/5)
   ✅ [1] Fix authentication error on login
   ✅ [2] Resolve database connection timeout
   🔄 [3] Debug memory leak in session handler
   ⏳ [4] Fix CSS layout issue on mobile
   ⏳ [5] Patch XSS vulnerability in comment form
```

Notice:
- Each item shows its ID in brackets [1], [2], etc.
- Status icons come before the ID
- Items are sorted by ID number, not by status
- All items are shown, not just a subset

### 5. Fallback (No Checkpoint)
If no checkpoint found:
```
⚠️ No recent checkpoint found. Showing recent activity:

[Use recall({ since: "7d" }) and format the results manually]

💡 **Tip:** Create your first checkpoint with `/checkpoint`
```