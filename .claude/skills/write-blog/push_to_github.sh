#!/usr/bin/env bash
#
# 将博客文章推送到 johnsonlee/blog repo
#
# 用法: push_to_github.sh <filename>.md
# 要求: 环境变量 GITHUB_TOKEN 已设置
#

set -euo pipefail

REPO="johnsonlee/blog"
BRANCH="master"
POST_DIR="source/_posts"

# --- 参数检查 ---

if [ $# -lt 1 ]; then
  echo "用法: $0 <filename>.md"
  echo "示例: $0 agent-economy-app-future.md"
  exit 1
fi

FILENAME="$1"
# Support both full path and filename-only
if [[ "$FILENAME" = /* ]]; then
  FILEPATH="$FILENAME"
  FILENAME=$(basename "$FILENAME")
else
  FILEPATH="$(pwd)/${FILENAME}"
fi

if [ ! -f "$FILEPATH" ]; then
  echo "错误: 文件不存在: $FILEPATH"
  exit 1
fi

if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "错误: 环境变量 GITHUB_TOKEN 未设置"
  echo "请设置后重试: export GITHUB_TOKEN=ghp_xxxxx"
  exit 1
fi

# --- 编码文件内容 ---

# Cross-platform base64 (macOS vs Linux)
if [[ "$OSTYPE" == "darwin"* ]]; then
  CONTENT_BASE64=$(base64 < "$FILEPATH")
else
  CONTENT_BASE64=$(base64 -w 0 < "$FILEPATH")
fi
TARGET_PATH="${POST_DIR}/${FILENAME}"

# --- 检查文件是否已存在（需要 sha 来更新） ---

HTTP_RESPONSE=$(curl -s -w "\n%{http_code}" \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  "https://api.github.com/repos/${REPO}/contents/${TARGET_PATH}?ref=${BRANCH}")

HTTP_BODY=$(echo "$HTTP_RESPONSE" | sed '$d')
HTTP_CODE=$(echo "$HTTP_RESPONSE" | tail -1)

COMMIT_MSG="post: add ${FILENAME}"

if [ "$HTTP_CODE" = "200" ]; then
  # 文件已存在，获取 sha 用于更新
  EXISTING_SHA=$(echo "$HTTP_BODY" | python3 -c "import sys,json; print(json.load(sys.stdin)['sha'])")
  COMMIT_MSG="post: update ${FILENAME}"
  
  echo "文件已存在，将更新: ${TARGET_PATH}"
  
  RESPONSE=$(curl -s -w "\n%{http_code}" -X PUT \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/${REPO}/contents/${TARGET_PATH}" \
    -d @- <<EOF
{
  "message": "${COMMIT_MSG}",
  "content": "${CONTENT_BASE64}",
  "branch": "${BRANCH}",
  "sha": "${EXISTING_SHA}"
}
EOF
  )
else
  echo "创建新文件: ${TARGET_PATH}"
  
  RESPONSE=$(curl -s -w "\n%{http_code}" -X PUT \
    -H "Authorization: Bearer ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/repos/${REPO}/contents/${TARGET_PATH}" \
    -d @- <<EOF
{
  "message": "${COMMIT_MSG}",
  "content": "${CONTENT_BASE64}",
  "branch": "${BRANCH}"
}
EOF
  )
fi

RESP_BODY=$(echo "$RESPONSE" | sed '$d')
RESP_CODE=$(echo "$RESPONSE" | tail -1)

if [ "$RESP_CODE" = "200" ] || [ "$RESP_CODE" = "201" ]; then
  COMMIT_URL=$(echo "$RESP_BODY" | python3 -c "import sys,json; print(json.load(sys.stdin).get('commit',{}).get('html_url',''))" 2>/dev/null || echo "")
  echo "✅ 推送成功！"
  echo "   文件: ${TARGET_PATH}"
  echo "   分支: ${BRANCH}"
  if [ -n "$COMMIT_URL" ]; then
    echo "   Commit: ${COMMIT_URL}"
  fi
else
  echo "❌ 推送失败 (HTTP ${RESP_CODE})"
  echo "$RESP_BODY" | python3 -c "import sys,json; d=json.load(sys.stdin); print(f'   原因: {d.get(\"message\",\"未知错误\")}')" 2>/dev/null || echo "$RESP_BODY"
  exit 1
fi
