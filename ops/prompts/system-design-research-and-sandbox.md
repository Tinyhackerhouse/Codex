# System Design Research and Sandbox Prompt

Use this prompt when asking Codex or another agent to research modern system design practices and turn them into a tested sandbox.

```text
You are the Researcher Agent and Developer Agent working together inside a Codex repository.

Goal:
Research the modern system design stack and build a local sandbox that can be generated, inspected, and tested in Codex.

Primary sources:
- https://www.designgurus.io/learn-system-design/how-to-learn-system-design
- https://www.designgurus.io/system-design-interview
- https://www.designgurus.io/system-design-interview/questions

Research tasks:
1. Extract the current system design learning framework.
2. Identify the major concept families: load balancing, caching, rate limiting, queues, database selection, sharding, replication, search/indexing, observability, vector databases, LLM gateways, embedding pipelines, and AI infrastructure.
3. Identify recurring system design project patterns: social feed, chat/messaging, geospatial dispatch, video streaming, search, e-commerce, collaborative editing, notification systems, API platform, and AI-augmented apps.
4. Capture modern best practices: cost reasoning, operational maturity, observability, deployment strategy, rollback, failure testing, AI-aware design, latency budgets, token cost tracking, fallback strategy, and rate limiting.
5. Convert the research into reusable templates for multi-agent project execution.

Build tasks:
1. Create a sandbox folder under `sandbox/system-design/`.
2. Generate one Markdown design packet per project pattern.
3. Each packet must include:
   - Clarify and scope
   - Functional requirements
   - Non-functional requirements
   - Scale assumptions
   - Data model
   - API sketch
   - High-level architecture
   - Component responsibilities
   - Deep dives
   - Failure modes
   - Cost reasoning
   - Observability
   - Deployment and rollback
   - Security and abuse controls
   - AI-aware extension where relevant
   - Local test plan
4. Generate a stack matrix that maps concepts to project patterns.
5. Generate a CEO execution plan that delegates work to Researcher, Designer, Developer, and Business/Sales agents.
6. Generate tests that verify every project packet has the required sections.

Testing tasks:
1. Run the sandbox build script.
2. Run the sandbox validation script.
3. Report which files were generated.
4. Report missing sections or failed checks.
5. Suggest the next highest-leverage improvement.

Constraints:
- Do not copy long text from the source sites.
- Summarize concepts in your own words.
- Cite source URLs in the final research notes.
- Keep all generated artifacts local and reviewable.
- Do not deploy, publish, send messages, spend money, or contact customers without approval.

Output:
- A concise research summary.
- A generated sandbox.
- A validation report.
- A recommended next build step.
```

