# CEO-Led Multi-Agent Orchestration System

## Purpose

Build a scheduled multi-agent management system that can plan, delegate, execute, review, and report on projects across software development, product launches, marketing campaigns, research reports, sales outreach, content creation, and business operations.

The system runs on an hourly scheduled loop. Agents may eventually execute work automatically, but the first version requires owner approval before high-impact actions.

## Agent Hierarchy

### 1. Owner Agent

Primary function: strategic direction and final accountability.

Responsibilities:

- Define company-level goals, priorities, constraints, and success criteria.
- Decide which projects should be created, paused, escalated, or closed.
- Delegate operating execution to the CEO Agent.
- Review CEO reports and approve sensitive actions.
- Maintain long-term strategic memory.

Default behavior:

- Thinks strategically.
- Does not manage every task directly.
- Delegates execution and coordination to the CEO Agent.

### 2. CEO Agent

Primary function: operating command center.

Responsibilities:

- Convert owner goals into projects, milestones, and tasks.
- Assign work to specialist agents.
- Maintain visibility into all agent-to-agent logs.
- Run hourly progress checks.
- Detect blockers, stale tasks, missing outputs, and priority conflicts.
- Escalate approval requests to the Owner Agent or human owner.
- Produce executive summaries, blocker reports, completed task summaries, budget/time estimates, and recommendations.

Default behavior:

- Owns day-to-day orchestration.
- Can inspect all communication logs.
- Delegates rather than doing specialist work directly unless no specialist fits.

### 3. Researcher Agent

Primary function: discovery, analysis, and evidence.

Responsibilities:

- Web research.
- Competitive analysis.
- Market research.
- Technical feasibility research.
- Source summaries.
- Risk analysis.
- Prompt generation for deeper research tasks.

### 4. Designer Agent

Primary function: product, UX, brand, and presentation.

Responsibilities:

- Product flows.
- UX/UI specs.
- Brand voice and visual direction.
- Wireframes and design briefs.
- Content structure.
- Prompt generation for design, image, and interface tasks.

### 5. Developer Agent

Primary function: implementation and technical execution.

Responsibilities:

- Code changes.
- Repository management.
- Technical plans.
- Tests and verification.
- GitHub and Vercel work.
- Browser automation for QA.
- Prompt generation for code, debugging, and deployment tasks.

### 6. Business/Sales Executive Agent

Primary function: revenue, partnerships, customers, and business operations.

Responsibilities:

- Sales strategy.
- Outreach plans.
- CRM updates.
- Customer segmentation.
- Offers, pricing, and positioning.
- Partnership research.
- Marketing and business operations tasks.
- Prompt generation for sales, marketing, and customer workflows.

## Communication Model

Agents may talk to each other directly.

Rules:

- Every agent-to-agent message is logged.
- The CEO Agent can inspect all logs.
- The Owner Agent can inspect all CEO summaries and escalations.
- Agents should generate clear prompts when delegating work to another agent.
- Delegated prompts must include context, objective, constraints, expected output, due time, and approval requirements.

## Task States

Use classic project management states:

- Backlog
- Assigned
- In Progress
- Review
- Blocked
- Done
- Archived

Every task should include:

- ID
- Title
- Project
- Owner agent
- Assigned agent
- State
- Priority
- Due time
- Approval required
- Dependencies
- Last update
- Next follow-up time
- Output path or link
- Conversation log references

## Approval Gates

Initially, all high-impact actions require human approval.

Approval is required before:

- Spending money.
- Sending emails or external messages.
- Deploying code.
- Publishing content.
- Contacting customers.
- Changing strategy.
- Creating public repositories.
- Deleting, archiving, or overwriting important assets.
- Changing production data.
- Connecting new external tools.

Low-risk actions can be prepared automatically:

- Drafting plans.
- Writing Markdown docs.
- Creating task proposals.
- Researching.
- Creating local files.
- Preparing code changes for review.
- Drafting emails without sending.
- Drafting deployment plans without deploying.

## Hourly Scheduled Loop

Every hour, the CEO Agent runs the operating loop.

Loop steps:

1. Load current projects, tasks, memory, and recent logs.
2. Check tasks due for follow-up.
3. Ask assigned agents for progress updates.
4. Move stale or unclear tasks into Review or Blocked.
5. Create new delegated prompts when a task needs specialist action.
6. Collect outputs and summarize progress.
7. Identify approval requests.
8. Escalate blockers and high-impact actions.
9. Write an executive report.
10. Schedule the next follow-up.

## Memory Model

The system should preserve:

- Company goals.
- Brand voice.
- Past decisions.
- Current projects.
- Employee/agent performance.
- Client and customer information.
- All conversations.
- Task history.
- Approval history.
- Generated prompts.
- Outputs and links.

For the first version, store memory in Markdown and JSON files. A database can be added later.

## Filesystem MVP

Recommended first version:

```text
ops/
  agents/
    owner.md
    ceo.md
    researcher.md
    designer.md
    developer.md
    business-sales.md
  projects/
    README.md
  tasks/
    backlog.md
    active.md
    review.md
    blocked.md
    done.md
  logs/
    conversations.md
    approvals.md
    hourly-reports.md
  memory/
    company.md
    brand.md
    decisions.md
    clients.md
    prompts.md
  templates/
    task.md
    delegation-prompt.md
    progress-report.md
    approval-request.md
```

## Tooling Targets

The long-term system should support:

- Web search.
- GitHub repository management.
- Vercel deployment and project management.
- Notion.
- CRM.
- Browser automation.
- File and document creation.

Initial integrations:

- Markdown files for project/task/memory state.
- GitHub for code repositories.
- Browser automation for verification.
- Vercel after the first app exists.

## MVP Build Plan

Phase 1: Local operating system

- Create the Markdown folder structure.
- Define agent role files.
- Define task and report templates.
- Add a manual command for the CEO hourly loop.
- Require human approval for gated actions.

Phase 2: Scheduled runs

- Add an hourly scheduler.
- Load tasks and logs.
- Generate progress reports.
- Create approval requests.
- Persist memory and task changes.

Phase 3: Tool integrations

- GitHub repo access.
- Browser automation.
- Vercel deployment checks.
- Notion sync.
- CRM sync.

Phase 4: Higher autonomy

- Allow approved categories of automatic execution.
- Keep approval gates for money, publishing, customer contact, and strategy changes.
- Add audit logs and rollback plans.

## First Operating Rule

The system should optimize for accountable execution, not agent chatter. Every conversation should produce one of these outcomes:

- A decision.
- A task update.
- A delegated prompt.
- A completed output.
- A blocker.
- An approval request.
- A report.
