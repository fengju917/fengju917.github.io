#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/Users/juju/fengju917.github.io"
FILE="101.html"
LOG_FILE="$REPO_DIR/auto-sync.log"

cd "$REPO_DIR"

echo "开始监听 $REPO_DIR/$FILE，文件变化后会自动同步到 GitHub。"
echo "日志文件：$LOG_FILE"

while true; do
  fswatch -1 "$FILE"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] 检测到 $FILE 变化，等待 15 秒防抖..." | tee -a "$LOG_FILE"
  sleep 15
  if ./auto-sync-101.sh >> "$LOG_FILE" 2>&1; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 同步完成" | tee -a "$LOG_FILE"
  else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] 同步失败，请查看日志" | tee -a "$LOG_FILE"
  fi
done
