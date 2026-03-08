---
name: deep-review
description: >
  Performs a comprehensive project review that evaluates whether the current implementation
  achieves its original goals, identifies gaps, and proposes a prioritized roadmap for
  improvement. Use this skill whenever the user asks to "review the project", "check if
  we've achieved our goals", "do a deep review", "audit the codebase against requirements",
  "are we on track", or wants a holistic assessment of project health vs. original intent.
  Also trigger when the user seems uncertain about project direction or wants strategic
  clarity before the next phase of development.
---

# Deep Review Skill

A structured methodology for reviewing whether a project's current implementation achieves
its original goals, and for charting a clear path forward.

---

## Phase 0: Scope the Review

Before diving in, determine what is being reviewed:

- **Whole project** — single repo, single deliverable
- **Module-level** — one package, service, or subsystem within a larger project
- **Monorepo** — multiple packages/services that may need independent assessment

If the scope is ambiguous, **ask the user** before proceeding:
> "This looks like a monorepo with multiple packages. Should I review the entire repo, a specific package, or a subset? Please clarify the boundary."

Once scope is agreed, all subsequent phases operate within that boundary.

---

## Phase 1: Discover the Original Goal

> **Parallelization hint:** Phase 1 and Phase 2 are independent of each other and can be dispatched to worker subagents in parallel.

Start by reconstructing what the project was *supposed to do*. Search in priority order:

1. **CLAUDE.md** — project context, constraints, decisions
2. **README.md / README.*** — stated purpose, features, non-goals
3. **Design docs** — `docs/`, `design/`, `spec/`, `*.md` files in root or subdirs
4. **Issue trackers / changelogs** — `CHANGELOG.md`, `TODO.md`, `ROADMAP.md`
5. **Package metadata** — `package.json` description, `pyproject.toml`, `Cargo.toml`
6. **Git history** — first commit message and early commits often reveal original intent
7. **Test files** — test names and descriptions are implicit specs

If the goal is ambiguous or undocumented, **ask the user** before proceeding:
> "I couldn't find a clear statement of the original goal. Could you describe what this project was meant to achieve?"

### User Checkpoint

After reconstructing the goals, **present them to the user for confirmation** before proceeding with the full analysis:

> "Here are the goals I reconstructed from the codebase. Please confirm these are accurate, correct anything I got wrong, and add any goals I missed."

List the goals clearly and wait for the user to confirm or amend them. Do not proceed to Phase 3 or beyond until the user has signed off on the goal list.

---

## Phase 2: Map the Current Implementation

> **Parallelization hint:** Phase 1 and Phase 2 are independent of each other and can be dispatched to worker subagents in parallel.

Do a structured inventory of what actually exists:

```
- Directory structure (2-3 levels deep)
- Core modules and their responsibilities
- External dependencies (what they're used for)
- Test coverage (what's tested vs. what's not)
- Configuration / environment requirements
- Entry points (CLI, API, UI, etc.)
- Known TODOs and FIXMEs in the code
```

Look for signals of incompleteness:
- Stubbed functions (`pass`, `TODO`, `raise NotImplementedError`)
- Dead code or unused imports
- Missing error handling
- Hardcoded values that should be config
- Test files that are empty or have skipped tests

### Dependency Health Check

Assess the health of external dependencies:

- **Outdated versions** — are dependencies significantly behind their latest releases?
- **Known CVEs** — do any dependencies have published security vulnerabilities?
- **Abandoned packages** — are any dependencies unmaintained (no commits/releases in 12+ months)?
- **License issues** — are there any copyleft or incompatible licenses relative to the project's own license?

---

## Phase 3: Goal vs. Reality Analysis

For each stated goal or requirement, assess:

| Goal | Status | Evidence | Gap | Priority |
|------|--------|----------|-----|----------|
| [goal] | Done / Partial / Missing | [file:line or "no evidence"] | [what's missing] | P0 / P1 / P2 |

**Status definitions:**
- **Done** — Implemented, tested, working
- **Partial** — Exists but incomplete, untested, or has known issues
- **Missing** — No implementation found

**Priority definitions:**
- **P0** — Core to the project's reason for existing; must be addressed
- **P1** — Important for production readiness or reliability; should be addressed soon
- **P2** — Valuable but not urgent; address when bandwidth allows

Also note anything that was **built but not in the original goal** (scope creep, or valuable additions).

---

## Phase 4: Qualitative Assessment

Beyond feature completeness, assess:

**Architecture**
- Does the structure make the codebase easy to extend?
- Are there obvious coupling problems or god objects?
- Is the separation of concerns clean?

**Reliability**
- Error handling: are failure modes handled gracefully?
- Are external dependencies (APIs, DBs) handled with retries/fallbacks?
- What happens at edge cases?

**Maintainability**
- Is the code self-documenting or does it need comments that aren't there?
- Would a new contributor understand the flow within 30 minutes?
- Are there dangerous patterns (e.g., eval, shell injection, unvalidated input)?

**Testability**
- Can core logic be tested in isolation?
- What's the ratio of unit vs. integration vs. manual-only testing?

**Security**
- Are there dependency vulnerabilities (cross-reference with Phase 2 dependency health check)?
- Are secrets, API keys, or credentials present in code or committed config files?
- Is input validated at trust boundaries (API endpoints, CLI arguments, file uploads, user-provided data)?
- Are auth and authorization patterns correct — proper session handling, role checks, token validation?

**Performance**
- Are there N+1 query patterns in database access?
- Are there unnecessary allocations or copies in hot paths?
- Is caching used where appropriate, and are cache invalidation strategies sound?
- Are there obvious bottlenecks (synchronous I/O in async contexts, unbounded loops, missing pagination)?

**CI/CD and Deployment**
- Is there a build pipeline, and does it run tests, linting, and security checks?
- Is the deployment configuration (Dockerfiles, IaC, manifests) present and correct?
- Is there environment parity between development, staging, and production?
- Are there deployment risks (manual steps, missing rollback strategy, no health checks)?

---

## Phase 5: Verdict

Give a clear, honest summary:

```
OVERALL VERDICT: [On Track / Needs Work / Off Track]

Core goal achieved: [Yes / Partially / No]
Most critical gap: [one sentence]
Biggest strength: [one sentence]
```

Don't hedge. Be direct about the state of the project.

---

## Phase 6: Improvement Roadmap

Propose improvements in three tiers:

### 🔴 Must Do (Blockers)
Things that prevent the core goal from being achieved or that create serious risk.
- Each item: **what** to fix, **why** it matters, **relative size** (S/M/L)

### 🟡 Should Do (High Value)
Improvements that significantly improve reliability, maintainability, or feature completeness.
- Each item: **what** to do, **expected benefit**, **relative size** (S/M/L)

### 🟢 Nice to Have (Future)
Enhancements worth considering once the above are done — new features, optimizations,
developer experience improvements.
- Each item: **what** it enables, **when** it makes sense to tackle

**Size definitions:**
- **S** — A focused change; one file or a small cluster of related edits
- **M** — Touches multiple files or modules; requires some design thought
- **L** — Cross-cutting change; significant refactor, new subsystem, or architectural shift

---

## Output Format

Structure the final report as:

```
# Deep Review: [Project Name]
Date: [today]
Scope: [whole project / module name / monorepo subset]

## Original Goal
[Reconstructed goal, 2-5 sentences. Note source.]

## Implementation Summary
[What exists today, 3-8 bullet points]

## Dependency Health
[Summary of outdated, vulnerable, abandoned, or license-problematic dependencies]

## Goal Achievement Analysis
[Table from Phase 3, including Priority column]

## Qualitative Assessment
[Architecture / Reliability / Maintainability / Testability / Security / Performance / CI/CD - 2-4 sentences each]

## Verdict
[Clear verdict from Phase 5]

## Improvement Roadmap
[Tiered list from Phase 6, with S/M/L sizing]

## Recommended Next Steps
[Top 3 concrete actions the user should take this week, in order of priority]
```

---

## Principles

- **Be honest, not diplomatic.** The user needs the truth about their project, not validation.
- **Cite evidence.** Every claim should reference a file, function, or test. Don't assert — show.
- **Distinguish "done" from "done well."** A feature that exists but is fragile is partial, not complete.
- **Respect constraints.** If the user mentioned time/resource constraints, weight recommendations accordingly.
- **Don't over-review.** Focus on what matters for the goal. Don't nitpick style if it's not blocking anything.
