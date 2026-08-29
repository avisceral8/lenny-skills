---
name: lenny
description: >-
  Use when the user invokes /lenny (or asks a product, growth, strategy,
  hiring, or PM-career question "using lenny"). Routes the request to the 1-3
  most relevant of the 76 Lenny product skills vendored under references/lenny/
  and answers using those frameworks with sourced guidance.
metadata:
  hermes:
    tags: [product-management, strategy, growth, discovery, career, router]
    homepage: https://github.com/RefoundAI/lenny-skills
---

# /lenny - Lenny Skills Router

You are routing the user's request to a library of 76 product-management
skills distilled from Lenny's Podcast & Newsletter (MIT, Refound AI). They
are NOT loaded yet. Your job: load only what's relevant, then work.

This file is agent-agnostic: wherever you (the agent) loaded this SKILL.md
from is the package root. All paths below are relative to it.

## Procedure (every invocation)

1. **Read the routing table** (once per session; it's cheap):
   `references/routing-table.md`. It lists all 76 skills grouped by category
   with one-line descriptions and their paths.
2. **Classify the request.** Pick the primary intent and up to 2 supporting
   skills. Rules:
   - A skill matches when its description covers the *decision being made*,
     not just vocabulary overlap. "How do I set pricing?" ->
     `pricing-strategy` (primary); `measuring-pmf` / `plg-fundamentals`
     (support only if the user's context implies them).
   - Career/interpersonal asks (promotion, comp, interviews, burnout) route
     inside the Career and Team & Organization groups first.
   - AI-product asks route to the `Playbook: Building AI Products` group.
   - BPMN/process-modeling or pure-coding asks are NOT in this library -
     say so plainly instead of forcing a match.
   - If the request is genuinely ambiguous across 2+ categories, ask ONE
     short disambiguating question before loading anything; otherwise just
     proceed.
3. **Load the chosen skill bodies** by reading
   `references/lenny/<name>/SKILL.md` with your file-reading tool. Load at
   most 3. If a template, checklist, or named framework is needed for the
   answer, also read `references/lenny/<name>/references/artifacts.md`;
   cite real guest material only if you actually read
   `references/lenny/<name>/references/guest-insights.md`.
4. **Answer the user's original instruction** (the text they typed with
   /lenny, or their question this turn) *through the loaded frameworks*:
   name the framework, apply it concretely to their situation, and end with
   the 2-3 most useful next actions. Do not dump the skill text; do not pad
   with generic advice the skills don't contain.
5. If nothing in the table fits, say so plainly and answer from general
   knowledge, labeled as such.

## Multi-skill combo hints

Common requests that legitimately need 2-3 skills together:
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
