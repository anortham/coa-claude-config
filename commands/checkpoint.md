---
allowed-tools: ["mcp__goldfish__checkpoint"]
description: "Create a checkpoint of current work session"
---

Create a checkpoint of current work session using the unified checkpoint tool.

$ARGUMENTS

## Steps:
1. Use the unified checkpoint tool with action="save":
   - **Required**: description (brief summary of current state)
   - **Optional**: highlights (key achievements/decisions to remember)
   - **Optional**: activeFiles (files being worked on)
   - **Optional**: workContext (what you're doing next)
   - **Auto-detected**: gitBranch (current git branch)

2. For quick checkpoints, just provide description:
   ```
   checkpoint({ 
     action: "save",
     description: "Completed feature X" 
   })
   ```

3. For detailed session state, include all context:
   ```
   checkpoint({ 
     action: "save",
     description: "Major refactoring complete",
     highlights: ["Converted to TypeScript", "Added session management"],
     activeFiles: ["src/index.ts", "src/types.ts"],
     workContext: "Next: write tests and update documentation"
   })
   ```

4. Display results:
   - Show: "✅ Checkpoint saved: {description}"
   - Show: "Session ID: {sessionId}" 
   - Show: "📌 Use /recall to restore from this checkpoint"

## Benefits:
- Crash-safe development (frequent checkpoints)
- Session continuity after /clear
- Searchable work history
- Accumulated session highlights
- Smart action inference (action="save" can be omitted if description provided)