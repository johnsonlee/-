# Submit PR Skill
1. Ensure you are on a feature branch (never main/master). If on main, create a new branch first.
2. Before committing, run build and test commands. If tests fail, fix the issues and re-run until green.
3. Stage and commit all changes including data files.
4. Push the branch to origin.
5. Create a PR with a description that accurately reflects the actual diff, not the planned changes.
6. Show the PR URL to the user.
7. After submitting the PR, proactively monitor the GitHub Actions workflow status. If any workflow fails, investigate the failure, fix the issue, push the fix, and re-check until all checks are green.

Never force-push to main/master.
