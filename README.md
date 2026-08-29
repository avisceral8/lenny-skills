# lenny — the `/lenny` router skill for the dumb and the lazy

**TL;DR: one slash command, 76 product-management brains, zero reading.**
Type `/lenny <anything>`. A tiny router reads your question, picks the 1–3
skills you actually need out of the [76 Lenny's Product
Skills](https://github.com/refoundai/lenny-skills), loads *only those*, and
answers. You will not read a routing table. You will not choose a skill. You
were going to install all 76 and let your agent pick, or — let's be honest —
you were going to install none of them. This is for you.

## The Situation (facts, no opinions)

[Refound AI](https://refoundai.com) built
[lenny-skills](https://github.com/refoundai/lenny-skills): 76 MIT-licensed
skills distilled from 597 Lenny Podcast episodes and newsletter posts, 4,019
verbatim-sourced insights. It is excellent work and this repo is a fork that
exists entirely because of it. Go star theirs.

Installing all 76 skills naively has a cost nobody advertises: ~76 lines in
your agent's system prompt *every single turn*, several thousand tokens of
"product-taste, negotiation-compensation, marketplace-liquidity-take-rates…"
index churn, paid forever, whether you're asking about pricing or just telling
it to fix a semicolon. The original repo hands you 76 sharp tools and trusts
you to keep a workshop. You won't. You're lazy. That's fine — that's the ICP.

## The Resolution (this fork)

One skill. **`lenny` is a router, not a pile.**

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
one-line-per-skill table (cheap, once per session), decides
`pricing-strategy` (+ maybe `competitive-strategy`), reads only those bodies
from disk, and answers through their frameworks. Cost if your question has
nothing to do with product work: one routing-table read, and the router is
instructed to say "not my library" instead of force-fitting wisdom about
marketplace take rates onto your CSS bug.

## What's different from the original (with full credit, so hear me out)

| | [upstream lenny-skills](https://github.com/refoundai/lenny-skills) | this fork |
|---|---|---|
| Shape | 76 skills, pick-your-own, browse the README like it's a catalog | 1 skill that *is* the catalog, memorized |
| Your effort | read 76 folder names, install the ones you recognize | type `/lenny` + your question, in any words |
| Context cost | one index line per installed skill, forever | one line for the router; 76 bodies stay inert until routed |
| Composition | you notice that "new idea" wants 3 skills | built-in combo hints do it (`idea-validation` + `evaluating-startup-ideas` + `defining-icp`) |
| Staleness | re-clone when upstream ships v3 | `python scripts/sync_lenny_skills.py` |
| Skill content | **all of it, theirs** | vendored verbatim, MIT, LICENSE preserved |

Nothing about the actual wisdom is ours. We did the plumbing so you don't
have to: routing, vendoring, regenerating, and pretending we always knew which
of the 76 you needed. You're welcome.

## Install

Requirements: Python 3.9+ (stdlib only) and git, and only when the library
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
for you on first install (fetches the 76 upstream skills + regenerates the
routing table; add `--from /path/to/lenny-skills-clone` to work offline).

The package uses the open SKILL.md format (YAML frontmatter + markdown +
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
python scripts/sync_lenny_skills.py          # pull upstream, regenerate table
grep -c '^- \*\*' references/routing-table.md  # verify: 76
```

## Attribution

All 76 skills and 100% of the frameworks, quotes, and frameworks-that-actually-
work are **Lenny's Product Skills v2.0 © [Refound AI](https://refoundai.com),
MIT** — https://github.com/RefoundAI/lenny-skills, browsable with guides at
[refoundai.com/lenny-skills](https://refoundai.com/lenny-skills/). This fork
adds a router and two installers and vendored their `LICENSE` into
`references/lenny/`. Router + scripts: MIT. If you like the plumbing, the
genius is one star over [there](https://github.com/refoundai/lenny-skills).
