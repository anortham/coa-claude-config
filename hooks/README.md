# Hooks Directory - DEPRECATED

The hooks in this directory have been deprecated in favor of the new TDD team agents and commands.

## Previous Hooks (Archived)
- `cache-builder.ps1` - Type verification cache builder
- `cache-management.ps1` - Cache management utilities 
- `guard_rails_pre.py` - Pre-execution guard rails
- `prompt-analyzer.ps1` - Prompt analysis hook
- `session-initializer.ps1` - Session initialization
- `test-file-enforcer.ps1` - Test file enforcement
- `type-verification.ps1` - Type verification hook

## Why Deprecated?
These hooks were experimental and have been superseded by:
- TDD team agents (test-designer, test-implementer, test-reviewer, refactoring-expert)
- Improved command structure (/audit, /tdd-fix, /tdd-new, /tdd-phase)
- Better integration with Goldfish MCP memory system

## Migration
If you need functionality from old hooks:
1. Check if equivalent exists in TDD agents
2. Convert to command format if needed
3. Use Goldfish memory system for state tracking

The cleaned `settings.json` no longer includes hook configurations.