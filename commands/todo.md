---
allowed-tools: ["mcp__goldfish__todo"]
description: "Quick todo management - add, complete, or view tasks"
---

Manage todo items quickly using the unified todo tool.

$ARGUMENTS

## Todo Management

Parse the arguments to determine the action and use the unified todo tool:

### For "add [task description]" or just a task description:
Use the quick action feature:
```
todo({ action: "quick", quick: "add [task description]" })
```

### For "done [id]" or "complete [id]" or "finish [id]":
Use the quick action to mark items complete:
```
todo({ action: "quick", quick: "done [id]" })
```

### For "list" or no arguments:
Show the current todo list with IDs:
```
todo({ action: "view" })
```

### For "active [id]":
Mark the specified item as currently being worked on:
```
todo({ action: "update", listId: "latest", itemId: "[id]", status: "active" })
```

### For "delete [id]" or "remove [id]":
Delete the specified todo item:
```
todo({ action: "update", listId: "latest", itemId: "[id]", delete: true })
```

## Examples:

- `/todo add implement user authentication` - Adds new task
- `/todo done 3` - Marks item #3 as complete
- `/todo list` - Shows all todos
- `/todo active 2` - Marks item #2 as in progress
- `/todo delete 5` - Removes item #5

## Display Format:

Always show the updated todo list after making changes:

```
📋 {List Title} - {percentage}% ({completed}/{total})
   ✅ [1] {completed task}
   🔄 [2] {active task}
   ⏳ [3] {pending task}
```

Keep responses brief - just show the action taken and updated list.