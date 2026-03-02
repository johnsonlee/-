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

## Git PR Rules

- Each PR must contain exactly **1 commit**
- Rebase onto the latest target branch before submitting a PR
- If multiple commits were created during development, squash them into one using `git rebase -i` or `git reset --soft` before submitting
- No merge commits allowed in PRs
