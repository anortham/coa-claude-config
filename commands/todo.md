---
allowed-tools: ["mcp__goldfish__create_todo_list", "mcp__goldfish__update_todo", "mcp__goldfish__view_todos"]
description: "Quick todo management - add, complete, or view tasks"
---

Manage todo items quickly.

$ARGUMENTS

## Todo Management

Parse the arguments to determine the action:

### For "add [task description]" or just a task description:
Create a new todo item in the current list (or create a new list if needed).

### For "done [id]" or "complete [id]" or "finish [id]":
Mark the specified todo item as completed.

### For "list" or no arguments:
Show the current todo list with IDs.

### For "active [id]":
Mark the specified item as currently being worked on.

### For "delete [id]" or "remove [id]":
Delete the specified todo item.

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