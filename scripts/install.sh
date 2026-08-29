# Installer for the /lenny router skill (portable, agent-agnostic).
#
# Usage:
#   ./install.sh                  # auto-detect installed agents
#   ./install.sh --agent claude   # claude  -> ~/.claude/skills/lenny
#   ./install.sh --agent codex    # codex   -> ~/.codex/skills/lenny
#   ./install.sh --agent hermes   # hermes  -> $HERMES_HOME or ~/.hermes/skills/lenny
#   ./install.sh --dest DIR       # explicit: copy package into DIR/lenny
#   ./install.sh --library-only   # just populate references/lenny + routing table
#
# Copies the package (SKILL.md, scripts/, references/) — never the git repo.
set -euo pipefail

PKG="$(cd "$(dirname "$0")/.." && { pwd -W 2>/dev/null || pwd; })"
AGENT="auto"; DEST_ROOT=""; LIB_ONLY=0

while [ $# -gt 0 ]; do
  case "$1" in
    --agent) AGENT="$2"; shift 2 ;;
    --dest)  DEST_ROOT="$2"; shift 2 ;;
    --library-only) LIB_ONLY=1; shift ;;
    -h|--help) grep '^#' "$0" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) echo "unknown flag: $1" >&2; exit 1 ;;
  esac
done

PY="$(command -v python3 || command -v python || true)"
[ -n "$PY" ] || { echo "python3 is required" >&2; exit 1; }

ensure_library() {
  if [ ! -f "$PKG/references/routing-table.md" ] || [ ! -d "$PKG/references/lenny/writing-prds" ]; then
    echo ">> Populating skill library (references/lenny + routing table)..."
    if [ -d "$PKG/skills" ]; then
      # Fork layout: the 76 skills are vendored in-repo — sync offline from them.
      "$PY" "$PKG/scripts/sync_lenny_skills.py" --from "$PKG"
    else
      "$PY" "$PKG/scripts/sync_lenny_skills.py"
    fi
  else
    echo ">> Skill library already present."
  fi
}

if [ "$LIB_ONLY" = 1 ]; then ensure_library; exit 0; fi

detect_dest() {
  case "$AGENT" in
    claude) echo "$HOME/.claude/skills" ;;
    codex)  echo "$HOME/.codex/skills" ;;
    hermes) echo "${HERMES_HOME:-$HOME/.hermes}/skills" ;;
    auto)
      if [ -d "$HOME/.claude" ]; then echo "$HOME/.claude/skills"
      elif [ -d "${HERMES_HOME:-$HOME/.hermes}" ]; then echo "${HERMES_HOME:-$HOME/.hermes}/skills"
      elif [ -d "$HOME/.codex" ]; then echo "$HOME/.codex/skills"
      else echo "" ; fi ;;
    *) echo "unknown agent: $AGENT" >&2; exit 1 ;;
  esac
}

TARGET_ROOT="${DEST_ROOT:-$(detect_dest)}"
[ -n "$TARGET_ROOT" ] || { echo "no supported agent dir found; use --dest DIR" >&2; exit 1; }
ensure_library
mkdir -p "$TARGET_ROOT/lenny"
echo ">> Installing $PKG -> $TARGET_ROOT/lenny"
( cd "$PKG" && tar cf - SKILL.md LICENSE.md README.md scripts references ) \
  | ( cd "$TARGET_ROOT/lenny" && tar xf - )
echo ">> Done. Invoke with /lenny <your question> (restart the agent to pick up the new skill)."