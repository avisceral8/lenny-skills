# lenny — the router for people who'd rather not

**TL;DR: one command, 76 skills, and you don't have to pick any of them. You're welcome.**

Somewhere, a diligent person listened to 597 episodes and distilled 4,019
insights into 76 skills. You are not that person. You are the person who
wants the answer without the homework. Both people are valid. This repo
serves the second one.

## The problem

[Refound AI](https://refoundai.com) built
[lenny-skills](https://github.com/refoundai/lenny-skills): 76 MIT-licensed
skills distilled from 597 Lenny Podcast episodes and newsletter posts, with
4,019 sourced insights. It is the best product-management library you can
install. Star theirs first. I'll wait.

Installing all 76 has a cost nobody advertises. Every skill adds an index
line to your agent's context on every turn, forever. You'd sit down to fix a
semicolon and drag "marketplace-liquidity-take-rates" along for the ride. The
original repo assumes you'll curate 76 skills like a professional. You won't.
Neither would I.

## How it works

`lenny` is one router skill on top of all 76. Only the router loads. The 76
sit quietly on disk until a question actually needs one.

```
lenny/
├── SKILL.md                 ← the router, ~4 KB, the only file always loaded
├── LICENSE.md               ← combined MIT (router + vendored skills)
├── scripts/
│   ├── sync_lenny_skills.py   # fetch/refresh the 76 from GitHub (or --from a local clone)
│   ├── gen_routing_table.py   # regenerate references/routing-table.md
│   ├── install.sh / install.ps1
│   └── categories.json
└── references/
    ├── routing-table.md       # generated map: 76 entries, one line each
    └── lenny/                 # generated: the 76 upstream skills, untouched
```

The router reads a one-line-per-skill table once per session, then runs one
of four modes.

### The four modes

| Mode | Invoke | What happens |
|---|---|---|
| DIRECT | `/lenny pricing-strategy positioning …` | Runs exactly the skills you name |
| ROUTE | `/lenny route how do I price my B2B tool?` | Seats the 2-4 best-fit skills, one merged answer |
| COUNCIL (default) | `/lenny how do I price my B2B tool?` | Seats every relevant skill (minimum 5), reconciles |
| LIST | `/lenny list` / `list career` | Prints skill names grouped by category |

COUNCIL is the default. No mode is forced.

If your question has nothing to do with product work, the router says so and
answers from general knowledge. No marketplace take rates on your CSS bug.

## What's different

| | [upstream lenny-skills](https://github.com/refoundai/lenny-skills) | this fork |
|---|---|---|
| Shape | 76 skills, pick-your-own | 1 skill that knows the catalog |
| Your effort | learn 76 folder names | type `/lenny` + your question |
| Context cost | one index line per skill, forever | one line for the router |
| Composition | you notice "new idea" wants 3 skills | the router seats the right skills per mode |
| Staleness | re-clone when upstream ships v3 | `python scripts/sync_lenny_skills.py` |
| Skill content | all of it, theirs | vendored verbatim, MIT, LICENSE preserved |

The wisdom is Refound AI's. I did the plumbing so you don't have to.

## Install

Requirements: Python 3.9+ (stdlib only) and git, needed only to populate or
refresh the library.

```bash
git clone https://github.com/avisceral8/lenny-skills.git lenny-router
cd lenny-router
```

This repo is a GitHub fork of `RefoundAI/lenny-skills`, so the 76 skills
already sit in `skills/` at the repo root. The installer generates
`references/lenny/` and the routing table locally, no second fetch.

```bash
# POSIX shell, auto-detects ~/.claude, ~/.hermes, ~/.codex:
./scripts/install.sh
./scripts/install.sh --agent claude        # -> ~/.claude/skills/lenny
./scripts/install.sh --agent codex         # -> ~/.codex/skills/lenny
./scripts/install.sh --agent hermes        # -> $HERMES_HOME/skills/lenny
./scripts/install.sh --dest ~/myproject/.claude/skills   # project-local

# Windows PowerShell:
.\scripts\install.ps1
.\scripts\install.ps1 -Agent claude
.\scripts\install.ps1 -Dest C:\Users\you\myproject\.claude\skills
```

The installer copies the package to `<skills-dir>/lenny/`. On a standalone
copy without `skills/` checked out, the first install runs
`scripts/sync_lenny_skills.py` to fetch the 76 from GitHub. Add
`--from /path/to/lenny-skills-clone` to work offline.

The package uses the open SKILL.md format (YAML frontmatter, markdown,
relative `references/` paths), so it works in Hermes, Claude Code, Codex
CLI, opencode, Gemini CLI, and similar. On agents without slash commands
(Cursor rules, Copilot instructions), add one line to your rules file:
*"For product, growth, strategy, or PM-career questions, load the `lenny`
skill and follow its routing procedure."*

## Use

```
# DIRECT: run the skills you name
/lenny pricing-strategy we're a 4-person team selling B2B analytics
/lenny positioning pricing-strategy competitive-strategy how do I price my B2B tool?
/lenny @writing-prds help me spec a mobile onboarding revamp

# ROUTE: auto-seat the 2-4 best-fit skills
/lenny route how do I price my B2B analytics tool?
/lenny --route is my marketplace problem liquidity or supply?

# COUNCIL (default): seat all relevant skills and reconcile
/lenny how do I price my B2B analytics tool?
/lenny my manager won't put me up for promotion

# LIST: print skill names by category
/lenny list
/lenny list career
```

## Maintain

```bash
python scripts/sync_lenny_skills.py            # pull upstream, regenerate table
grep -c '^- \*\*' references/routing-table.md  # verify: 76
```

## Attribution

All 76 skills and 100% of the frameworks, quotes, and checklists are Lenny's
Product Skills v2.0, © Refound AI, MIT licensed:
https://github.com/RefoundAI/lenny-skills, browsable at
[refoundai.com/lenny-skills](https://refoundai.com/lenny-skills/). This fork
adds a router, two installers, and a combined `LICENSE.md`. The star you were
going to give this repo belongs on
[theirs](https://github.com/refoundai/lenny-skills).
