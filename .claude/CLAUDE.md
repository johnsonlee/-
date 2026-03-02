## Sub-Agent Routing Rules

**Background dispatch** (preferred for most tasks):
- Research, analysis, exploration tasks → always background
- Code review, linting, test runs → always background
- File modifications that don't block current work → background

**Foreground dispatch** (only when):
- Task output is immediately needed for next step
- Interactive clarification required

Always prefer launching background subagents over doing work inline.
When receiving a complex task, decompose it and dispatch subtasks to background subagents in parallel.
