---
name: lenny
description: >-
  Use when the user invokes /lenny (or asks a product, growth, strategy,
  hiring, or PM-career question "using lenny"). Four modes: DIRECT — run the
  1+ skills the user names ("/lenny pricing-strategy positioning …"); ROUTE
  (opt-in) — auto-seat the 2-4 best-fit skills; COUNCIL (default) — seat all
  relevant skills (minimum 5) and reconcile; LIST — show skill names grouped
  by category.
metadata:
  hermes:
    tags: [product-management, strategy, growth, discovery, career, router]
    homepage: https://github.com/RefoundAI/lenny-skills
---

# /lenny - Lenny Skills Router

You are routing the user's request to a library of 76 product-management
skills distilled from Lenny's Podcast & Newsletter (MIT, Refound AI). They
are NOT loaded yet. You run in ONE of four modes, chosen from the user's
input. Pick the mode first, then follow only that mode's procedure.

This file is agent-agnostic: wherever you (the agent) loaded this SKILL.md
from is the package root. All paths below are relative to it.

## Step 0 — Load the routing table (once per session)

Read `references/routing-table.md`. It lists all 76 skills grouped by
category with one-line descriptions and their paths. Every skill is a
kebab-case slug (`pricing-strategy`, `defining-icp`, `writing-prds`, …). You
match user input against these slugs, and LIST mode reuses the category
headings.

## Step 1 — Choose the mode

Look at the text after `/lenny` (or the user's question this turn):

1. **LIST** — trigger on `list`, `--list`, `list <category>`,
   `--list <category>`. Print skill names by category and stop (Mode D).
2. **DIRECT** — the user named one or more skills. Trigger when leading
   tokens match slugs: bare (`pricing-strategy`), prefixed (`@`,
   `--skill`, `skill:`, `use`), or a confident near-miss (`pricing strategy`
   → `pricing-strategy`, `north star` → `north-star-metrics`). Gather ALL
   consecutive leading slug tokens — that is the seat list. Everything after
   the last slug is the question. One slug = one skill; several = several.
3. **ROUTE** — trigger on `route`, `--route`, `quick`, `--quick`, `focused`,
   `brief`, `top skills`, `2-4`, `few skills`, `best skills` with NO leading
   slugs. Auto-seat the 2-4 best skills (Mode B). (If slugs follow the
   keyword, it's DIRECT — naming skills is DIRECT's job.)
4. **COUNCIL** (default) — anything else: a use case, a question, a problem.
   "How do I price my B2B tool?" / "help me write a PRD" / "my manager
   won't put me up for promotion." Explicit triggers (`council`, `--council`,
   `all of them`, `every skill`, `full council`) also work. Seat all
   relevant skills, minimum 5 (Mode C).

When torn between DIRECT and COUNCIL, prefer DIRECT on an exact slug match;
otherwise ask ONE short disambiguating question.

If nothing in the table fits the request, say so plainly and answer from
general knowledge, labeled as such. BPMN/process-modeling and pure-coding
asks are NOT in this library — say so instead of forcing a match.

## Mode A — DIRECT (1+ named skills, no routing)

1. Normalize each named slug against the table: spaces → hyphens, strip
   `@` / `--skill` / `skill:` / `use`. If a slug isn't in the table, say so,
   list the closest 2-3 candidates, and ask before proceeding with the rest.
2. Read each named skill's `references/lenny/<slug>/SKILL.md`. Read
   `references/lenny/<slug>/references/artifacts.md` only when the question
   needs that skill's template, checklist, or named framework; read
   `references/lenny/<slug>/references/guest-insights.md` only when you want
   to cite a real guest quote.
3. Answer:
   - **One skill** → answer through it alone: name its framework, apply it
     concretely, give its verdict and 1-2 next actions. Do not pull in other
     skills unless the user explicitly asks to compare.
   - **2+ skills** → give one short counsel per skill (name the framework,
     apply it, give the verdict), then merge into ONE answer: the shared
     throughline, any disagreement worth flagging, and the 2-3 most useful
     next actions. Light merge, like ROUTE — no full
     consensus/conflict/blind-spots breakdown unless a real conflict demands
     it.
4. If there's no trailing question, briefly orient them (what each named
   skill covers and its key framework) and ask what they want to apply them
   to.

## Mode B — ROUTE (opt-in: auto-seat the 2-4 best skills)

The user described a problem and wants a focused answer — a shortlist, not
one skill and not the full council.

1. Scan the table and pick the 2-4 most relevant skills — those whose
   descriptions cover the decision being made or a distinct facet of it.
   Rank by fit. Never exceed 4; if fewer than 2 genuinely apply, take what
   fits. Never pad to hit a number.
2. If the ask is ambiguous across categories (e.g. "growth" could be
   `growth-model` or `acquisition-channels`), ask ONE short disambiguating
   question before loading anything; otherwise proceed.
3. For each seated skill, read its SKILL.md and answer the question through
   that skill in 1-2 sentences: name the framework, apply it, give the
   verdict.
4. Merge into ONE answer: the shared throughline, any disagreement worth
   flagging, and the 2-3 most useful next actions. Lighter than Mode C — no
   full consensus/conflict/blind-spots breakdown unless a real conflict
   demands it.

## Mode C — COUNCIL (default: seat all relevant skills, minimum 5)

The default mode: full deliberation, with a floor of 5 seats.

1. **Seat ALL relevant skills — minimum 5.** A skill gets a seat when its
   description covers the decision being made, or a distinct facet of it.
   When genuinely torn on a skill, seat it. Do NOT seat skills that merely
   share vocabulary with the question. Typical council is 5-8 members; more
   than ~12 means the question is too broad — narrow it or say so. If fewer
   than 5 are genuinely relevant, add the next-most-adjacent skills until
   you reach 5 and say so, or ask ONE question to broaden the scope.
   Career/interpersonal asks seat from the Career and Team & Organization
   groups first; AI-product asks seat from the `Playbook: Building AI
   Products` group.
2. **One counsel per skill.** For each seated skill, read its SKILL.md, then
   answer the user's question through that skill alone: name its framework,
   apply it concretely, give its verdict and 1-2 next actions. A short
   paragraph each. Cite real guest material only if you actually read that
   skill's guest-insights.md.
3. **Deliberate.** Compare the counsels:
   - **Consensus:** what multiple members independently agree on — the
     backbone of the answer.
   - **Conflict:** where members disagree, surface it, name both sides, and
     rule on which framework wins under the user's actual conditions. Do not
     average disagreements into mush.
   - **Blind spots:** what one member flags that others miss entirely.
   Deliver ONE synthesized answer ending with the 2-3 most useful next
   actions, attributing any live disagreement ("pricing says X, but
   measuring-pmf would push back because…"). Do not dump skill text; do not
   pad with generic advice the skills don't contain.

## Mode D — LIST (skill names under categories)

Read `references/routing-table.md` and print each category heading with its
skill slugs ONLY — drop the one-line descriptions and paths; the slugs are
self-explanatory. One line per category:

`## <Category> — slug1, slug2, slug3, …`

If the user passed a category argument (`list career`, `list strategy`),
match it against the headings case-insensitively (substring is fine) and
print just that category. Stop after printing — do not route or answer.

## Common council compositions (seeds, not full seat lists)

Requests that typically convene several members:
- "New product idea" -> `evaluating-startup-ideas` + `idea-validation` + `defining-icp`
- "PRD" -> `writing-prds` + `roadmap-prioritization` (+ `product-experiments` if success metrics are fuzzy)
- "Launch" -> `launch-planning` + `positioning` + `user-onboarding-activation`
- "Growth stalled" -> `growth-model` + `measuring-pmf` (+ `north-star-metrics`)
- "Pricing" -> `pricing-strategy` (+ `competitive-strategy` for market context)
- "Promotion case" -> `building-a-promotion-case` + `executive-communication`
- "Hiring a PM" -> `hiring-product-talent` + `interviewing-evaluating-candidates`

These are seeds: COUNCIL expands each to at least 5 skills; ROUTE caps at the
top 2-4; DIRECT runs exactly the ones the user named.

## Library maintenance (only when the user asks to refresh/upgrade)

Run `python scripts/sync_lenny_skills.py` (add `--from <local-clone>` to
work offline; needs git + Python 3.9+, stdlib only). It re-copies the
vendored skills and regenerates the routing table from their frontmatter.
Verify after: the routing table should list 76 entries
(`grep -c '^- \*\*' references/routing-table.md` on Unix,
`(Select-String '^[-][ ]' references/routing-table.md -Pattern '^\- \*\*').Count`
or Python on Windows).

## Attribution

The 76 underlying skills are Lenny's Product Skills v2.0 (MIT) by Refound AI,
https://github.com/RefoundAI/lenny-skills. Keep `references/lenny/LICENSE`
in place when syncing. This router is MIT-licensed as well.
