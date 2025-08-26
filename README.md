# COA Claude Configuration Repository

This repository contains global Claude Code configurations including agents, commands, and settings for the COA development team.

## Contents

### Agents (`/agents`)
- **codebase-auditor.md** - Comprehensive codebase analysis and quality assessment
- **doc-validator.md** - Documentation accuracy validation
- **refactoring-expert.md** - Code refactoring and cleanup specialist  
- **strategic-research-planner.md** - Research and planning for complex projects
- **test-designer.md** - TDD test specification design
- **test-implementer.md** - TDD implementation specialist
- **test-reviewer.md** - TDD quality assurance and final review

### Commands (`/commands`)
- **audit.md** - `/audit` - Comprehensive codebase audit using auditor agent
- **checkpoint.md** - `/checkpoint` - Save session state with Goldfish MCP
- **commit.md** - `/commit` - Smart git commit with validation
- **resume.md** - `/resume` - Resume from previous session state
- **standup.md** - `/standup` - Generate daily standup report
- **tdd-fix.md** - `/tdd-fix` - Fix bugs using TDD methodology
- **tdd-new.md** - `/tdd-new` - Implement new features using TDD
- **tdd-phase.md** - `/tdd-phase` - Execute specific TDD phase
- **todo.md** - `/todo` - Manage TODO lists with Goldfish MCP

### Configuration Files
- **settings.json** - Clean Claude Code settings (hooks removed)
- **CLAUDE.md** - Global development standards and instructions
- **claude-status.ps1** - PowerShell status line script

## Installation

### Option 1: PowerShell Install Script (Recommended)
```powershell
.\install.ps1
```

### Option 2: Manual Installation
1. Backup existing configurations:
   ```powershell
   Move-Item ~/.claude ~/.claude.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')
   ```

2. Create symbolic links (requires admin PowerShell):
   ```powershell
   New-Item -ItemType SymbolicLink -Path ~/.claude/agents -Target "C:\source\coa-claude-config\agents"
   New-Item -ItemType SymbolicLink -Path ~/.claude/commands -Target "C:\source\coa-claude-config\commands"
   Copy-Item "C:\source\coa-claude-config\settings.json" ~/.claude/settings.json
   Copy-Item "C:\source\coa-claude-config\CLAUDE.md" ~/.claude/CLAUDE.md
   Copy-Item "C:\source\coa-claude-config\claude-status.ps1" ~/.claude/claude-status.ps1
   ```

3. Copy credentials and local settings (if they exist):
   ```powershell
   Copy-Item ~/.claude.backup.*/.credentials.json ~/.claude/ -ErrorAction SilentlyContinue
   Copy-Item ~/.claude.backup.*/statusline.json ~/.claude/ -ErrorAction SilentlyContinue
   ```

## Configuration Management

### Global vs Project-Specific
- **Global configurations** (this repo): Agents, core commands, development standards
- **Project-specific** (`.claude/` in project repos): Project-specific commands and overrides

### Command Precedence
1. Project-local commands (`.claude/commands/`)
2. Global commands (`~/.claude/commands/`)

### Updating Configurations
```bash
cd C:\source\coa-claude-config
git pull origin main
# Re-run install.ps1 if needed
```

## TDD Team Workflow

The configuration includes a complete TDD team:

1. **Audit Phase**: `/audit` - Identify issues using codebase-auditor
2. **Design Phase**: `/tdd-fix` or `/tdd-new` - Create failing tests with test-designer
3. **Implementation Phase**: Continue with test-implementer
4. **Refactor Phase**: Clean up code with refactoring-expert  
5. **Review Phase**: Final validation with test-reviewer

## Hooks - DEPRECATED

Previous hook-based functionality has been migrated to:
- TDD team agents for quality assurance
- Improved command structure for workflows
- Goldfish MCP for memory and state management

See `hooks/README.md` for migration details.

## Requirements

- Claude Code with MCP support
- Goldfish MCP server (for memory/state management)
- PowerShell (for status line and install script)
- Git (for version control)

## Contributing

1. Make changes to configurations in this repo
2. Test changes locally
3. Commit and push to share with team
4. Team members pull updates and re-run installation

## Support

For issues or questions about these configurations, create an issue in this repository or discuss with the development team.