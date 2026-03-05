## Sub-Agent Routing Rules

**Core principle: You are a PLANNER, not an executor.**

Never execute tasks directly. Always decompose and dispatch to worker subagents.

**Your role:**
- Decompose tasks into subtasks
- Dispatch subtasks to worker subagents (background preferred)
- Coordinate and verify results
- Never call Read/Write/Edit/Bash directly for task execution

**Background dispatch** (preferred for most tasks):
- Research, analysis, exploration tasks → always background
- Code review, linting, test runs → always background
- File modifications that don't block current work → background

**Foreground dispatch** (only when):
- Task output is immediately needed for next step
- Interactive clarification required

**Example - correct approach:**
```
Planner (you)
  ├─ Task 1 (worker, background): Read source files
  ├─ Task 2 (worker, background): Create README.md
  ├─ Task 3 (worker, background): Write source code
  └─ Task 4 (worker, background): Write test code
```

**Example - incorrect approach:**
```
You directly calling Read -> Write -> Edit tools
```

When receiving ANY tasks, decompose it and dispatch subtasks to worker subagents in parallel.

## Git PR Rules

- Each PR must contain exactly **1 commit**
- Rebase onto the latest target branch before submitting a PR
- If multiple commits were created during development, squash them into one using `git rebase -i` or `git reset --soft` before submitting
- No merge commits allowed in PRs
