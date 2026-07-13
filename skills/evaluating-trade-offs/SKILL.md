---
name: evaluating-trade-offs
description: Help users navigate complex product decisions by weighing competing priorities and calculating long-term value. This skill covers build-vs-buy logic, technical debt evaluation, and communicating tradeoffs to senior leadership.
---

# Evaluating Trade-Offs

Master the art of weighing competing options to maximize long-term impact and team velocity.

Help the user with evaluating trade-offs using insights from 14 guests and posts across Lenny's Podcast and Newsletter.

## How to Help

1. **Framework Selection** - Match the right decision template to the specific tradeoff scenario you are facing.
2. **ROI Calculation** - Assist in modeling the long-term business impact versus the operational costs of a proposed path.
3. **Stakeholder Communication** - Refine how you present tradeoffs to leadership to ensure they see the hidden costs of saying yes.
4. **Bias Detection** - Identify common traps like the sunk cost fallacy or the just one more engineer myth in your current thinking.

## Core Principles

### Avoid the trap of small wins
Christopher Miller: "I think if you're doing growth, right, if you're doing product-led growth the right way, then you're trying to balance the science and sort of taking a somewhat hygienic approach to validating assumptions and hypotheses with being really ambitious and really pushing for the things that are going to have massive impact for your customers at the end of the day."

Guard against chasing minor optimizations that do not fundamentally change the user experience or create massive long-term value.

### Decompose radical redesigns
Ronny Kohavi: "And it's amazing how many times I've seen people come up with new designs or a radical new idea. And they believe in it, and that's okay. I'm just cautioning them all the time to say, 'If you go for something big, try it out, but be ready to fail 80% of the time.'"

Break down massive changes into small, testable increments because radical redesigns have an 80 percent failure rate compared to incremental iterations.

### Surface rabbit holes during shaping
Ryan Singer: "I often use this analogy of if you're doing a home renovation, you can have the most beautiful rendering of the new bedroom and we're going to have these lamps on the side of the bed that are coming out from the wall. But if you haven't checked if there's electricity in that wall there or not, it's going to drastically change the cost and the time and everything."

Involve senior engineers early to identify technical complexities and infrastructure constraints before committing the team to a high-fidelity design.

### Quantify the risk of inaction
From "This Week #13: Balancing outcome-thinking with design and technical requirements ⚖️": "To answer your question about how we balanced this outcome-thinking with engineering and design needs (which often don’t directly drive that outcome), it’s simple — extend your outcome thinking further out into the future. How much would this work benefit your outcome (e.g. growth, quality, retention) 1+ years out? What happens if you don’t do it? What are the chances of it being successful?"

Evaluate major technical or design investments by comparing the impact of doing the work now versus the cost and risk of doing nothing.

### Use SaaS for foundational needs
Austin Hay: "That's how you actually have a lot of velocity is thinking about not just build versus buy. It's build and buy now. So, you buy the tool to get 90% of the way there and then you build the cool thing on top with the other 10%. And so that architecting decision usually falls on this person."

Avoid reinventing the wheel by buying third-party solutions for core functionality and focusing internal engineering on proprietary layers.

### Balance taste with pragmatism
Ivan Zhao: "Too much of yourself. Then there's no users. Then you're just doing our project. And too much for business, you're building a commodity."

Find the equilibrium between building for your personal artistic standards and addressing the objective requirements of users and revenue.

### Prioritize the company roadmap over team projects
Noam Lovinsky: "I don't think we should be putting 50 engineers on this project. Looking at the rest of the roadmap and the rest of the priorities, excuse me, I think this team would likely be better served elsewhere."

Build leadership trust by being honest when your own project should be deprioritized in favor of more impactful company-wide initiatives.

### Re-evaluate build costs in the age of AI
Varun Mohan: "The engineers are now able to produce more technology. The ROI of building technology has actually gone up. This actually means you hire more."

Account for the increased ROI of engineering when using AI tools, which can make building custom internal solutions more viable than buying off-the-shelf software.

### Reserve first-principles for innovation
From "First-principles thinking": "We get through life by reasoning by analogy, which essentially means copying what other people do with slight variations. And you have to do that. Otherwise, mentally, you wouldn’t be able to get through the day. But when you want to do something new, you have to apply the first-principles approach."

Use efficient reasoning by analogy for standard tasks and save high-effort first-principles thinking for situations where you need to create something truly original.

## Templates & Frameworks

- **Five Techniques for Communicating Tradeoffs** (How to communicate tradeoffs so leaders will listen) - Tara Seshan's five-part playbook for making tradeoffs crystal clear to senior leaders, preventing the 'do both' default.
- **Magic Lenses (4 Classic Lenses + Custom)** (Introducing the Foundation Sprint: From the creators of the Design Sprint) - A technique for evaluating multiple product approaches by plotting them on multiple 2x2 charts, each representing a different decision-making perspective
- **Technical/Design Investment Evaluation Framework** (This Week #13: Balancing outcome-thinking with design and technical requirements ⚖️) - A scenario-based evaluation framework used at Airbnb to decide whether to invest in large technical or design work that doesn't directly drive near-term outcome
- **Build AND Buy** (Austin Hay) - A decision-making framework that replaces the binary 'Build vs. Buy' debate with a hybrid approach to software procurement.
- **Traffic Light Decision Matrix** (Naomi Gleit) - A visual table used in meetings to evaluate three options against specific criteria using color coding instead of a flat pros/cons list.
- **Weighted Decision-Making Spreadsheet** (Nicole Forsgren) - A spreadsheet to evaluate options based on weighted criteria.
- **The 'Optimizing For' Framework** (Nikita Miller) - A mental model for prioritization and trade-offs.
- **SCQA Tradeoff Decision Document** (How to communicate tradeoffs so leaders will listen) - A structured document for presenting a prioritization tradeoff to leadership, using the Situation-Complication-Question-Answer framework with a bottom-line-up-f
- **Should We Do This Ourselves? Document** (Jeff Weinstein) - An annual strategic document evaluating whether to build internal capabilities or use third-party vendors.
- **Build/Buy/Partner decision framework for large companies** (Tanguy Crusson) - How Atlassian evaluates whether to build internally, acquire, or partner when entering a new market

See `references/artifacts.md` for the full list with details.

## Questions to Help Users

- "What is the single clarifying question that helps the team filter priorities and resolve this specific tradeoff?"
- "If we choose to build this internally, what are the predicted long-term maintenance and operational costs?"
- "How does this project impact the broader company roadmap compared to our team's specific goals?"
- "What infrastructure constraints or technical rabbit holes might we encounter once development begins?"
- "Are we optimizing for a short-term metric or building a foundation for massive long-term customer value?"
- "Under what specific conditions would the alternative decision be superior to the one we are leaning toward?"

## Common Mistakes to Flag

- **The binary build-vs-buy trap** - Teams often assume they must either build a total custom solution or buy a rigid tool when a hybrid approach is usually more efficient.
- **Ignoring the cost of heroics** - Leaders often overlook how short-term pushes to do both options degrade team morale and operational stability over time.
- **Overestimating radical redesign success** - Radical changes are statistically more likely to fail than incremental improvements yet they are often chosen for their perceived simplicity.
- **The Just One More Engineer fallacy** - Believing that a single additional resource can fix a fundamentally flawed project structure or competitive disadvantage.

## Deep Dive

For all 13 sourced insights from 14 guests, see `references/guest-insights.md`

## Related Skills

- Roadmap Prioritization
- Goal Setting Okrs
- Planning Cadence
- High Stakes Decisions
