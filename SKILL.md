---
name: lenny
description: >-
  Use when the user invokes /lenny (or asks a product, growth, strategy,
  hiring, or PM-career question "using lenny"). Routes the request to EVERY
  relevant skill among the 76 Lenny product skills vendored under
  references/lenny/, answers through each one, then reconciles the answers
  like a council and delivers one synthesized guidance.
metadata:
  hermes:
    tags: [product-management, strategy, growth, discovery, career, router]
    homepage: https://github.com/RefoundAI/lenny-skills
---

# /lenny - Lenny Skills Router

You are routing the user's request to a library of 76 product-management
skills distilled from Lenny's Podcast & Newsletter (MIT, Refound AI). They
are NOT loaded yet. Your job: seat every relevant skill as a council
member, hear each one out, then reconcile them into one answer.

This file is agent-agnostic: wherever you (the agent) loaded this SKILL.md
from is the package root. All paths below are relative to it.

## Procedure (every invocation)

1. **Read the routing table** (once per session; it's cheap):
   `references/routing-table.md`. It lists all 76 skills grouped by category
   with one-line descriptions and their paths.
2. **Select ALL relevant skills — no fixed cap.** There is no 1-3 limit;
   relevance is the only gate. Rules:
   - A skill gets a seat when its description covers the *decision being
     made*, or a distinct facet of it. "How do I set pricing?" seats
     `pricing-strategy`, plus `competitive-strategy` (market context),
     `defining-icp` (who pays), `positioning` (value metric), and
     `north-star-metrics` if growth implications are in scope.
   - When genuinely torn on a skill, seat it. A redundant council member
     costs one file read; a missing one loses a whole perspective.
   - Do NOT seat skills that merely share vocabulary with the question.
     A typical council is 4-8 members; more than ~12 means the question is
     too broad — narrow it or say so.
   - Career/interpersonal asks (promotion, comp, interviews, burnout) seat
     from the Career and Team & Organization groups first.
   - AI-product asks seat from the `Playbook: Building AI Products` group.
   - BPMN/process-modeling or pure-coding asks are NOT in this library -
     say so plainly instead of forcing a match.
   - If the request is genuinely ambiguous across 2+ categories, ask ONE
     short disambiguating question before loading anything; otherwise just
     proceed.
3. **Council round — one answer per skill.** For each seated skill, read
   `references/lenny/<name>/SKILL.md` with your file-reading tool, then
   answer the user's original instruction (the text they typed with /lenny,
   or their question this turn) *through that skill alone*: name its
   framework, apply it concretely to the user's situation, give its verdict
   and the 1-2 next actions it implies. Keep each counsel tight — a short
   paragraph, not an essay. Cite real guest material only if you actually
   read `references/lenny/<name>/references/guest-insights.md`; read
   `references/lenny/<name>/references/artifacts.md` only when that
   skill's template, checklist, or named framework is needed.
4. **Council deliberation.** Compare the individual counsels:
   - **Consensus:** what multiple members independently agree on — state it
     as the backbone of the answer.
   - **Conflict:** where members disagree, surface it explicitly, name both
     sides, and rule on it — which framework wins under the user's actual
     conditions, and why. Do not average disagreements into mush.
   - **Blind spots:** what one member flags that others miss entirely.
   Then deliver ONE synthesized answer ending with the 2-3 most useful
   next actions, attributing any live disagreement ("pricing says X, but
   measuring-pmf would push back because…"). Do not dump skill text; do
   not pad with generic advice the skills don't contain.
5. If nothing in the table fits, say so plainly and answer from general
   knowledge, labeled as such.

## Common council compositions

Requests that typically convene several members:
- "New product idea" -> `evaluating-startup-ideas` + `idea-validation` + `defining-icp`
- "PRD" -> `writing-prds` + `roadmap-prioritization` (+ `product-experiments` if success metrics are fuzzy)
- "Launch" -> `launch-planning` + `positioning` + `user-onboarding-activation`
- "Growth stalled" -> `growth-model` + `measuring-pmf` (+ `north-star-metrics`)
- "Pricing" -> `pricing-strategy` (+ `competitive-strategy` for market context)
- "Promotion case" -> `building-a-promotion-case` + `executive-communication`
- "Hiring a PM" -> `hiring-product-talent` + `interviewing-evaluating-candidates`

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
