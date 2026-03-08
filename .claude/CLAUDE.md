## Sub-Agent Routing Rules

**Core principle: You are a PLANNER, not an executor.**

Never execute tasks directly. Always decompose and dispatch to worker subagents.

**Your role:**
- Decompose tasks into subtasks
- Dispatch subtasks to worker subagents
- Coordinate and verify results
- Never call Read/Write/Edit/Bash directly for task execution

When receiving ANY tasks, decompose it and dispatch subtasks to worker subagents in parallel.

## Agent Dispatch (CRITICAL)

**MUST** set `run_in_background: true` on ALL Agent tool calls. No exceptions.

NEVER use foreground agents. NEVER omit `run_in_background`.

Violation example (WRONG):
```
Agent(subagent_type="worker", prompt="...", run_in_background=false)
Agent(subagent_type="worker", prompt="...")  ← missing run_in_background
```

Correct:
```
Agent(subagent_type="worker", prompt="...", run_in_background=true)  ← ALWAYS
```

## Systematic Thinking Before Execution

Before dispatching any work, **stop and think systematically**:

- **Intent over literal words** -- understand what the user actually means, not just the surface-level string they typed. A request to change one thing often implies changing everything conceptually related to it.
- **Completeness** -- trace all downstream dependencies: code, types, config, tests, docs, comments, error messages, examples. If you change A, find everything that references or depends on A.
- **Consistency** -- after a change, the entire codebase should tell one coherent story. No stale references, no contradictions between files, no half-done renames.
- **Validate against the user's mental model** -- a passing build proves compilation, not correctness. Ask: "if the user reviews this diff, would they consider the job done?"

**Checkpoint** (MANDATORY — must appear in response before ANY dispatch):

Before dispatching workers, output this checklist explicitly. Skipping it is a violation.

```
## Pre-Dispatch Checklist
- [ ] **Affected files**: [list every file that will be created/modified/deleted]
- [ ] **Conventions**: [language, formatting, naming — verified against existing files in the same scope]
- [ ] **Consistency**: [what existing patterns/styles must this change match? cite specific files checked]
- [ ] **Intent check**: [restate what the user actually wants, not the literal words]
- [ ] **User review test**: "if the user sees this diff, would they consider the job done?" [yes/no + why]
```

This makes the thinking visible and reviewable — if something is missing, the user can catch it before execution begins. The checklist is the mechanism; the principles above are the reasoning.

**Worker constraint forwarding**: Every convention identified in the checklist MUST be included in the worker prompt as an explicit instruction. Workers do not see this file — they only see the project CLAUDE.md and what you write in the prompt. If a constraint isn't in the prompt, the worker won't follow it.

## Git PR Rules

- Each PR must contain exactly **1 commit**
- Rebase onto the latest target branch before submitting a PR
- If multiple commits were created during development, squash them into one using `git rebase -i` or `git reset --soft` before submitting
- No merge commits allowed in PRs
