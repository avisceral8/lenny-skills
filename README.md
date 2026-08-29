# lenny — the `/lenny` router skill for the dumb and the lazy

**TL;DR: one slash command, 76 product-management brains, you read nothing.**
Type `/lenny <anything>` with your question in whatever words come out. A tiny
router picks the 1–3 skills you actually need from the
[76 Lenny's Product Skills](https://github.com/refoundai/lenny-skills), loads
only those, and answers through them. You will never pick a skill yourself,
which is the whole point, because you were going to either install all 76 and
hope your agent guessed right, or install none of them. You're lazy. That's
the ICP, and this repo is built for it.

## The Situation (facts, no opinions)

[Refound AI](https://refoundai.com) built
[lenny-skills](https://github.com/refoundai/lenny-skills): 76 MIT-licensed
skills distilled from 597 Lenny Podcast episodes and newsletter posts, with
4,019 verbatim-sourced insights. It is excellent work, and this repo exists
because of it. Go star theirs.

Installing all 76 skills naively has a cost nobody advertises. Each one adds
an index line to your agent's system prompt, every single turn: several
thousand tokens of "product-taste, negotiating-compensation,
marketplace-liquidity-take-rates…" whether you're asking about pricing or just
telling the agent to fix a semicolon. The original repo hands you 76 sharp
tools and expects you to keep a workshop. You won't keep a workshop.

## The Resolution (this fork)

`lenny` is one router skill sitting on top of all 76.

```
lenny/
├── SKILL.md                 ← the router: ~4 KB, the only thing always loaded
├── LICENSE.md               ← MIT for the router; upstream's own MIT ships with the pack
├── scripts/
│   ├── sync_lenny_skills.py   # fetch/refresh the 76 from GitHub (or --from a local clone)
│   ├── gen_routing_table.py   # regenerate references/routing-table.md
│   ├── install.sh / install.ps1
│   └── categories.json
└── references/
    ├── routing-table.md       # generated map: 76 entries, one line each
    └── lenny/                 # generated: the 76 upstream skills, untouched
```

When you type `/lenny how should I price my B2B tool?`, the router reads its
one-line-per-skill table once per session, decides that `pricing-strategy`
applies (probably with `competitive-strategy` for market context), reads only
those two files off disk, and answers using their frameworks. If your question
has nothing to do with product work, it reads the table, says "not my
library," and answers normally. No forced wisdom about marketplace take rates
landing on your CSS bug.

## What's different from the original (with full credit, so hear me out)

| | [upstream lenny-skills](https://github.com/refoundai/lenny-skills) | this fork |
|---|---|---|
| Shape | 76 skills, pick-your-own, browse the README like a catalog | 1 skill that memorized the catalog for you |
| Your effort | learn 76 folder names, install the ones you recognize | type `/lenny` + your question |
| Context cost | one index line per installed skill, forever | one line for the router; the 76 bodies stay asleep until routed to |
| Composition | you notice that "new idea" wants 3 skills | built-in combo hints do it (`idea-validation` + `evaluating-startup-ideas` + `defining-icp`) |
| Staleness | re-clone when upstream ships v3 | `python scripts/sync_lenny_skills.py` |
| Skill content | all of it, theirs | vendored verbatim, MIT, LICENSE preserved |

None of the actual wisdom is ours. We did the plumbing: routing, vendoring,
regenerating, and pretending we always knew which of the 76 you needed. You're
welcome.

## Install

Requirements: Python 3.9+ (stdlib only) and git, needed only when the library
is first populated or refreshed.

```bash
git clone https://github.com/avisceral8/lenny.git lenny-router
cd lenny-router

# any agent, POSIX shell — auto-detects ~/.claude, ~/.hermes, ~/.codex:
./scripts/install.sh
# or be explicit:
./scripts/install.sh --agent claude        # -> ~/.claude/skills/lenny
./scripts/install.sh --agent codex         # -> ~/.codex/skills/lenny
./scripts/install.sh --agent hermes        # -> $HERMES_HOME/skills/lenny
./scripts/install.sh --dest ~/myproject/.claude/skills   # project-local

# Windows PowerShell:
.\scripts\install.ps1                # auto-detect
.\scripts\install.ps1 -Agent claude
.\scripts\install.ps1 -Dest C:\Users\you\myproject\.claude\skills
```

The installer copies the package to `<skills-dir>/lenny/` and runs the sync
for you on first install, which fetches the 76 upstream skills and regenerates
the routing table. Add `--from /path/to/lenny-skills-clone` to work offline.

The package uses the open SKILL.md format (YAML frontmatter, markdown,
relative `references/` paths), so it works in Hermes, Claude Code, Codex CLI,
opencode, Gemini CLI and friends. On agents without slash commands (Cursor
rules, Copilot instructions), add one line to your rules file: *"For product,
growth, strategy, or PM-career questions, load the `lenny` skill and follow
its routing procedure."*

## Use

```
/lenny we're a 4-person team selling B2B analytics, how do I price it?
/lenny help me write a PRD for a mobile onboarding revamp
/lenny my manager won't put me up for promotion
/lenny is my marketplace problem liquidity or supply?
```

Refresh later:

```bash
python scripts/sync_lenny_skills.py            # pull upstream, regenerate table
grep -c '^- \*\*' references/routing-table.md  # verify: 76
```

## Attribution

All 76 skills and 100% of the frameworks, quotes, and checklists are
**Lenny's Product Skills v2.0 © [Refound AI](https://refoundai.com), MIT**:
https://github.com/RefoundAI/lenny-skills, browsable with guides at
[refoundai.com/lenny-skills](https://refoundai.com/lenny-skills/). This fork
adds a router, two installers, and their `LICENSE`, vendored at
`references/lenny/LICENSE`. Router and scripts: MIT. The star you're saving
for this repo belongs on
[theirs](https://github.com/refoundai/lenny-skills).
