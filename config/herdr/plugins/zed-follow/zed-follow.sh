#!/bin/sh
# Switch Zed to the git checkout of the focused herdr workspace.
# Runs as a herdr plugin event hook; the herdr server's PATH may be minimal.
export PATH="/etc/profiles/per-user/$USER/bin:/run/current-system/sw/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"

herdr="${HERDR_BIN_PATH:-herdr}"

ws_id=$(printf '%s' "${HERDR_PLUGIN_EVENT_JSON:-}" |
  jq -r '[.. | objects | .workspace_id? // empty] | first // empty' 2>/dev/null)
ws_id="${ws_id:-${HERDR_WORKSPACE_ID:-}}"
[ -n "$ws_id" ] || exit 0

# The checkout this workspace has open (main repo or linked worktree).
# Unlike `workspace list`, this also works for workspaces outside a herdr worktree group.
path=$("$herdr" worktree list --workspace "$ws_id" 2>/dev/null |
  jq -r --arg id "$ws_id" '[.result.worktrees[] | select(.open_workspace_id == $id) | .path] | first // empty')
[ -n "$path" ] && [ -d "$path" ] || exit 0

# Skip if this checkout was the last one we opened (avoids re-raising Zed on every focus).
state_dir="${HERDR_PLUGIN_STATE_DIR:-${TMPDIR:-/tmp}}"
last_file="$state_dir/last_path"
[ "$(cat "$last_file" 2>/dev/null)" = "$path" ] && exit 0
mkdir -p "$state_dir" && printf '%s' "$path" > "$last_file"

# `zed -e <dir>` activates that project in the existing window's sidebar (adding it if new).
# Keep keyboard focus on the terminal running herdr.
front=$(lsappinfo info -only bundleid "$(lsappinfo front)" 2>/dev/null | sed -n 's/.*="\(.*\)"/\1/p')
# The zed CLI forwards its environment to the opened project's terminals;
# drop this hook's HERDR_* so those terminals don't look like herdr panes.
for v in $(env | sed -n 's/^\(HERDR_[A-Za-z0-9_]*\)=.*/\1/p'); do unset "$v"; done
zed -e "$path"
if [ -n "$front" ]; then
  sleep 0.3
  open -b "$front"
fi
