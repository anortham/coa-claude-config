---
allowed-tools: ["Bash", "mcp__goldfish__checkpoint", "mcp__scribe__scribe_record"]
description: "Create a git commit with smart message generation and knowledge storage"
---

Create a git commit with an auto-generated message based on the changes.

$ARGUMENTS

## Commit Process:

### 0. Parse Arguments
Check if arguments contain:
- `--push` - Will push after committing
- `--amend` - Will amend the last commit
- Custom message - Use as commit message if provided
- Extract these flags and remaining text as the message

### 1. Analyze Changes
Run these commands in parallel to understand what's being committed:
- `git status --porcelain` - Get list of changed files
- `git diff --cached --stat` - See staged changes summary  
- `git diff --stat` - See unstaged changes summary
- `git log --oneline -1` - Get last commit for context

### 2. Stage Changes
Based on the changes found:
- If files are already staged, commit those
- If no files are staged but changes exist, stage all changes with `git add -A`
- If no changes at all, inform user and exit

### 3. Generate Commit Message
Analyze the changes and create a descriptive commit message:
- For single file: "Update {filename}: {brief description of change}"
- For multiple files in same directory: "Refactor {directory}: {what changed}"
- For feature work: "Add/Implement {feature description}"
- For fixes: "Fix {what was broken}"
- For cleanup: "Clean up {what was cleaned}"

Add emoji prefix based on change type:
- ✨ Features/new functionality
- 🐛 Bug fixes  
- 📝 Documentation
- ♻️ Refactoring
- 🧹 Cleanup/removal
- 🔧 Configuration

### 4. Create Commit
```bash
git commit -m "$(cat <<'EOF'
{emoji} {message}

{optional details if many files changed}

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>
EOF
)"
```

### 5. Store Documentation
After successful commit:
```
# Try to record in Scribe (optional - continues silently if unavailable)
scribe_record({
  title: "Git Commit: {brief commit message}",
  content: "## Commit Details\n\n**Message:** {commit message}\n\n**Files:**\n{list of changed files}\n\n**Hash:** {commit hash}",
  type: "commit",
  tags: ["git-commit", "{feature-area}"]
})

checkpoint({
  description: "Committed: {brief commit message}",
  highlights: ["{main change}"],
  gitBranch: "{current branch}"
})
```

### 6. Push if Requested
If arguments contain `--push`:
```bash
git push origin {current_branch}
```

If push fails due to no upstream:
```bash
git push --set-upstream origin {current_branch}
```

### 7. Show Result
Display (if pushed):
```
✅ Committed and pushed successfully!

📝 {commit message}
🔢 {number} files changed
#️⃣ {commit hash short}
🌿 Branch: {branch name}
🚀 Pushed to: origin/{branch name}

💾 Saved to Goldfish memory and Scribe (if available)
```

Display (if not pushed):
```
✅ Committed successfully!

📝 {commit message}
🔢 {number} files changed
#️⃣ {commit hash short}
🌿 Branch: {branch name}

💾 Saved to Goldfish memory and Scribe (if available)
💡 Use `/commit --push` next time to also push to remote
```

## Examples:
- `/commit` - Auto-detect and commit all changes
- `/commit Fixed authentication bug` - Use provided message
- `/commit --amend` - Amend the last commit
- `/commit --push` - Commit and push to remote
- `/commit --push Fixed auth bug` - Commit with message and push

## Important Notes:
- Always check for uncommitted changes first
- Generate meaningful commit messages based on actual changes
- Store commit info for future reference
- Never commit sensitive files (.env, secrets, keys)