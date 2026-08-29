"""Sync the /lenny router's skill library from RefoundAI/lenny-skills.

Usage:
  python sync_lenny_skills.py                # git clone/pull upstream
  python sync_lenny_skills.py --from DIR     # copy from an existing local clone
                                             # (DIR = the repo root, or the
                                             #  dir that contains skills/)

Idempotent. Copies every skills/<name>/ folder (SKILL.md + references/) plus
LICENSE into <pkg>/references/lenny/, then regenerates routing-table.md.
Stdlib only. Package root = this script's parent's parent, so it works no
matter where the lenny-router package lives.
"""
import argparse
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path


def _win_appdata() -> Path:
    """Robust Windows user-profile dir: LOCALAPPDATA is native-form and is
    immune to MSYS-bash rewriting HOME to a POSIX /c/... path."""
    return Path(os.environ["LOCALAPPDATA"])


def _norm(p: str) -> Path:
    """Normalize a possibly-MSYS path string to a real Path.
    Converts /c/Users/x (and leading //) to C:/Users/x on Windows."""
    if os.name == "nt":
        s = p.replace("\\", "/")
        m = re.match(r"^/([a-zA-Z])(/.*)?$", s)
        if m:
            s = m.group(1).upper() + ":" + (m.group(2) or "/")
        elif s.startswith("/"):
            s = "/" + s  # leave UNC-ish alone
        p = s
    return Path(p).expanduser().resolve()


def _user_home() -> Path:
    if os.name == "nt":
        return _win_appdata().parent.parent  # %LOCALAPPDATA%\..\.. = C:\Users\<u>
    return Path.home()


HERE = _norm(__file__).parent
PKG = HERE.parent                            # the lenny-router package root
LIB = PKG / "references" / "lenny"
CATS = HERE / "categories.json"
OUT = PKG / "references" / "routing-table.md"
REPO = "https://github.com/RefoundAI/lenny-skills.git"
CACHE = _user_home() / ".cache" / "lenny-skills"


def resolve_skills_dir(src: str | None) -> tuple[Path, Path]:
    """Return (skills_dir, repo_root)."""
    if src:
        p = _norm(src)
        if (p / "skills").is_dir():
            return p / "skills", p
        if (p / "SKILL.md").exists():  # user pointed straight at skills/
            return p, p.parent
        raise SystemExit(f"ERROR: {p} is not a lenny-skills clone root")
    if CACHE.exists():
        subprocess.run(["git", "-C", str(CACHE), "pull", "--ff-only"],
                       check=False)  # network failure: keep existing copy
    else:
        CACHE.parent.mkdir(parents=True, exist_ok=True)
        subprocess.run(["git", "clone", "--depth", "1", REPO, str(CACHE)],
                       check=True)
    return CACHE / "skills", CACHE


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--from", dest="src", default=None,
                    help="local clone root (dir containing skills/)")
    args = ap.parse_args()

    src_skills, repo_root = resolve_skills_dir(args.src)
    LIB.mkdir(parents=True, exist_ok=True)
    n = 0
    for folder in sorted(p for p in src_skills.iterdir()
                         if p.is_dir() and (p / "SKILL.md").exists()
                         and not p.name.startswith(("_", "."))):
        dest = LIB / folder.name
        if dest.exists():
            shutil.rmtree(dest)
        shutil.copytree(folder, dest)
        n += 1
    lic = repo_root / "LICENSE"
    if not lic.exists():
        lic = repo_root / "LICENSE.md"
    if lic.exists():
        shutil.copy2(lic, LIB / "LICENSE")
    subprocess.run([sys.executable, str(HERE / "gen_routing_table.py"),
                    str(LIB), str(CATS), str(OUT)], check=True)
    print(f"Synced {n} skills into {LIB}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
