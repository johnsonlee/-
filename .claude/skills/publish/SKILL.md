# Publish Skill
1. Ask the user: "What version bump? (patch/minor/major)" - Do NOT guess.
2. Identify the project type and update the version in the appropriate manifest file(s) (e.g., package.json, Cargo.toml, pyproject.toml, build.gradle, etc.).
3. Commit the version bump.
4. Create a git tag matching the new version (e.g., `v1.2.3`).
5. Push the commit and tag to origin — the tag push triggers the GitHub Actions release workflow.
6. Show the user the tag name and a link to the GitHub Actions runs page.

Never run publish commands (e.g., `npm publish`, `cargo publish`, `twine upload`) directly. Publishing is handled by CI via tag-triggered workflows.
