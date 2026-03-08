#!/usr/bin/env python3
"""
Fix Chinese/English quotes in Markdown blog post files.

Rules:
- If quoted content contains any CJK character, use Chinese double quotes ""
- If quoted content is pure ASCII/English, use English straight quotes ""
- Nested quotes in Chinese context use Chinese single quotes ''
- Skip code blocks (fenced and inline) and YAML front matter
"""

import re
import sys


# Unicode ranges for CJK characters
CJK_PATTERN = re.compile(
    r"[\u4e00-\u9fff"       # CJK Unified Ideographs
    r"\u3400-\u4dbf"        # CJK Unified Ideographs Extension A
    r"\u3000-\u303f"        # CJK Symbols and Punctuation
    r"\uf900-\ufaff"        # CJK Compatibility Ideographs
    r"\ufe30-\ufe4f"        # CJK Compatibility Forms
    r"\U00020000-\U0002a6df"  # CJK Unified Ideographs Extension B
    r"\uff00-\uffef]"       # Halfwidth and Fullwidth Forms
)

# All quote characters we care about
LEFT_DOUBLE_CURLY = "\u201c"   # "
RIGHT_DOUBLE_CURLY = "\u201d"  # "
LEFT_SINGLE_CURLY = "\u2018"   # '
RIGHT_SINGLE_CURLY = "\u2019"  # '
STRAIGHT_DOUBLE = '"'

# Pattern to match any pair of double quotes (straight, curly, or mismatched)
# Captures: opening quote, content, closing quote
QUOTE_PAIR_PATTERN = re.compile(
    r'(["\u201c\u201d])'    # opening quote (straight, left curly, or right curly)
    r'([^"\u201c\u201d]*?)'  # content (non-greedy, no quote chars inside)
    r'(["\u201c\u201d])'    # closing quote
)


def has_cjk(text):
    """Check if text contains any CJK character."""
    return bool(CJK_PATTERN.search(text))


def fix_nested_quotes(content, is_cjk_context):
    """Fix single quotes inside already-matched double-quoted content."""
    if not is_cjk_context:
        # In English context, leave inner quotes alone (standard English)
        return content

    # In CJK context, replace inner single straight quotes or curly singles
    # with Chinese single quotes
    # Match pairs of single quotes (straight or curly)
    def replace_inner(m):
        return LEFT_SINGLE_CURLY + m.group(2) + RIGHT_SINGLE_CURLY

    result = re.sub(
        r"(['\u2018\u2019])"
        r"([^'\u2018\u2019]*?)"
        r"(['\u2018\u2019])",
        replace_inner,
        content,
    )
    return result


def fix_quotes_in_text(text):
    """Fix quotes in a single piece of text (not code, not front matter)."""

    def replacer(m):
        open_q = m.group(1)
        content = m.group(2)
        close_q = m.group(3)

        # Skip empty quotes
        if not content.strip():
            return m.group(0)

        is_cjk = has_cjk(content)

        # Fix nested quotes first
        content = fix_nested_quotes(content, is_cjk)

        if is_cjk:
            return LEFT_DOUBLE_CURLY + content + RIGHT_DOUBLE_CURLY
        else:
            return STRAIGHT_DOUBLE + content + STRAIGHT_DOUBLE

    return QUOTE_PAIR_PATTERN.sub(replacer, text)


def process_file(filepath):
    """Process a Markdown file, fixing quotes while preserving code blocks and front matter."""
    with open(filepath, "r", encoding="utf-8") as f:
        original_lines = f.readlines()

    # Parse the file into segments: front matter, code blocks, and regular text
    lines = list(original_lines)
    in_front_matter = False
    front_matter_count = 0
    in_fenced_code = False
    changes = []

    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.rstrip("\n").rstrip("\r")

        # Handle YAML front matter (only at the very top of file)
        if i == 0 and stripped == "---":
            in_front_matter = True
            front_matter_count = 1
            i += 1
            continue

        if in_front_matter:
            if stripped == "---":
                in_front_matter = False
            i += 1
            continue

        # Handle fenced code blocks (``` or ~~~)
        if re.match(r"^(`{3,}|~{3,})", stripped):
            if not in_fenced_code:
                in_fenced_code = True
                # Store the fence marker to match closing
                i += 1
                continue
            else:
                in_fenced_code = False
                i += 1
                continue

        if in_fenced_code:
            i += 1
            continue

        # For regular text lines, fix quotes but skip inline code spans
        new_line = fix_line_preserving_inline_code(line)

        if new_line != line:
            changes.append((i + 1, line.rstrip("\n"), new_line.rstrip("\n")))
            lines[i] = new_line

        i += 1

    return lines, changes


def fix_line_preserving_inline_code(line):
    """Fix quotes in a line while preserving inline code spans."""
    # Split the line into segments: inline code vs regular text
    # Handle backtick code spans (possibly with multiple backticks)
    segments = []
    pos = 0
    text = line

    while pos < len(text):
        # Look for backtick-delimited code span
        match = re.search(r"(`+)(.+?)\1", text[pos:])
        if match:
            start = pos + match.start()
            end = pos + match.end()

            # Text before the code span
            if start > pos:
                segments.append(("text", text[pos:start]))

            # The code span itself (preserved as-is)
            segments.append(("code", text[start:end]))
            pos = end
        else:
            # Rest of the line is plain text
            segments.append(("text", text[pos:]))
            break

    # Now fix quotes only in the "text" segments
    result_parts = []
    for seg_type, seg_content in segments:
        if seg_type == "text":
            result_parts.append(fix_quotes_in_text(seg_content))
        else:
            result_parts.append(seg_content)

    return "".join(result_parts)


def main():
    if len(sys.argv) != 2:
        print(f"Usage: python3 {sys.argv[0]} <file.md>", file=sys.stderr)
        sys.exit(1)

    filepath = sys.argv[1]

    try:
        lines, changes = process_file(filepath)
    except FileNotFoundError:
        print(f"Error: File not found: {filepath}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)

    if not changes:
        print("No quote issues found.")
        return

    # Write changes back
    with open(filepath, "w", encoding="utf-8") as f:
        f.writelines(lines)

    # Print summary
    print(f"Fixed {len(changes)} line(s):\n")
    for lineno, before, after in changes:
        print(f"  Line {lineno}:")
        print(f"    Before: {before}")
        print(f"    After:  {after}")
        print()


if __name__ == "__main__":
    main()
