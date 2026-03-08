# blog-writer

Claude Code skill for writing and publishing blog posts to [johnsonlee.io](https://johnsonlee.io) (Hexo + GitHub Pages).

## Usage

In Claude Code, say things like:

- "写一篇关于 xxx 的博客"
- "把这个整理成博客"
- "blog about xxx"

The skill will guide you through: topic alignment -> draft generation -> quote fixing -> review -> publish.

## Files

| File | Description |
|---|---|
| `SKILL.md` | Skill definition: workflow, formatting rules, writing style guide |
| `fix_quotes.py` | Auto-fix Chinese/English quote marks in Markdown files |
| `push_to_github.sh` | Push post to `johnsonlee/blog` repo via GitHub API (for Claude Web, where `gh` CLI is unavailable) |

## Scripts

### fix_quotes.py

Automatically normalizes quote marks in a blog post:
- Chinese content -> `""`
- English content -> `""`
- Skips code blocks and YAML front matter

```bash
python3 fix_quotes.py <file.md>
```

### push_to_github.sh

Pushes a Markdown file to `source/_posts/` in the blog repo via GitHub API. This script is for **Claude Web** where `gh` CLI is not available — it requires a `GITHUB_TOKEN`. In Claude Code, use `gh api` directly instead.

```bash
export GITHUB_TOKEN=<token>
bash push_to_github.sh <file.md>
```
