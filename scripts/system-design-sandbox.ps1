param(
    [ValidateSet("build", "test", "all")]
    [string]$Mode = "all"
)

$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$SandboxRoot = Join-Path $Root "sandbox\system-design"
$ProjectsRoot = Join-Path $SandboxRoot "projects"
$ReportsRoot = Join-Path $SandboxRoot "reports"

$RequiredSections = @(
    "Clarify and Scope",
    "Functional Requirements",
    "Non-Functional Requirements",
    "Scale Assumptions",
    "Data Model",
    "API Sketch",
    "High-Level Architecture",
    "Component Responsibilities",
    "Deep Dives",
    "Failure Modes",
    "Cost Reasoning",
    "Observability",
    "Deployment and Rollback",
    "Security and Abuse Controls",
    "AI-Aware Extension",
    "Local Test Plan"
)

$Concepts = @(
    "Load balancing",
    "Caching",
    "Rate limiting",
    "Message queues",
    "Database selection",
    "Sharding",
    "Replication",
    "Search and indexing",
    "Observability",
    "Vector databases",
    "LLM gateway",
    "Embedding pipeline",
    "Cost reasoning",
    "Deployment and rollback"
)

$Projects = @(
    @{
        Slug = "social-feed"
        Name = "Social Feed"
        Examples = "Twitter, Instagram, news feed"
        Dominant = "Caching, sharding, message queues, database selection, replication, rate limiting"
        DeepDive = "Fan-out strategy, feed ranking, celebrity users, timeline materialization"
        Ai = "Generative feed summaries, semantic ranking, embedding-based interest matching"
    },
    @{
        Slug = "chat-messaging"
        Name = "Chat and Messaging"
        Examples = "WhatsApp, Slack, Discord"
        Dominant = "WebSockets, message queues, replication, database selection, observability"
        DeepDive = "Ordering, delivery semantics, presence, offline sync, group chat scale"
        Ai = "Missed-message summaries, AI-assisted replies, moderation pipeline"
    },
    @{
        Slug = "geospatial-dispatch"
        Name = "Geospatial Dispatch"
        Examples = "Uber, DoorDash, nearby search"
        Dominant = "Geospatial indexing, sharding, caching, queues, rate limiting"
        DeepDive = "Geohashing, driver matching, location update frequency, fairness and cost"
        Ai = "ML-assisted dispatch, demand forecasting, natural-language support workflows"
    },
    @{
        Slug = "video-streaming"
        Name = "Video Streaming"
        Examples = "YouTube, Netflix, TikTok"
        Dominant = "CDN caching, queues, metadata storage, regional load balancing, observability"
        DeepDive = "Upload pipeline, transcoding, adaptive bitrate, live versus on-demand delivery"
        Ai = "Recommendation summaries, semantic video search, automated tagging"
    },
    @{
        Slug = "search"
        Name = "Search"
        Examples = "Google-like search, e-commerce search, autocomplete"
        Dominant = "Search indexing, vector databases, caching, sharding, database selection"
        DeepDive = "Inverted index, ranking, hybrid retrieval, freshness, tail latency"
        Ai = "Embeddings, RAG, semantic reranking, answer generation with citations"
    },
    @{
        Slug = "ecommerce"
        Name = "E-Commerce"
        Examples = "Amazon, Shopify, marketplace checkout"
        Dominant = "Transactional database, caching, search, queues, rate limiting"
        DeepDive = "Inventory consistency, idempotent payments, order workflow, flash sales"
        Ai = "Personalized recommendations, support chatbot, semantic product search"
    },
    @{
        Slug = "collaborative-editing"
        Name = "Collaborative Editing"
        Examples = "Google Docs, Figma, Notion, Miro"
        Dominant = "Replication, CRDT or OT, WebSockets, operation log, active-state cache"
        DeepDive = "Conflict resolution, presence, offline edits, operation compaction"
        Ai = "Document summarization, AI writing assistant, semantic document retrieval"
    },
    @{
        Slug = "notification-system"
        Name = "Notification System"
        Examples = "Push, email, SMS, in-app notifications"
        Dominant = "Queues, rate limiting, user preferences, sharding, observability"
        DeepDive = "Deduplication, batching, retries, channel failover, deliverability tracking"
        Ai = "Send-time optimization, message personalization, abuse detection"
    },
    @{
        Slug = "api-platform"
        Name = "API Platform"
        Examples = "Stripe, Twilio, webhook delivery"
        Dominant = "Authentication, rate limiting, queues, transactional storage, observability"
        DeepDive = "Idempotency, webhook retries, customer-facing reliability, multi-region strategy"
        Ai = "LLM gateway as a managed API, token quotas, semantic caching"
    },
    @{
        Slug = "ai-augmented-app"
        Name = "AI-Augmented App"
        Examples = "RAG chatbot, AI search, agentic app"
        Dominant = "Vector database, embedding pipeline, LLM gateway, hybrid retrieval, observability"
        DeepDive = "Chunking, retrieval quality, model fallback, token cost, latency budgets"
        Ai = "This is the core pattern; include gateway, vector store, evals, and guardrails"
    }
)

function New-DirectoryIfMissing {
    param([string]$Path)
    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

function Get-ProjectPacket {
    param([hashtable]$Project)

    return @"
# $($Project.Name)

## Pattern Summary

Examples: $($Project.Examples)

Dominant concepts: $($Project.Dominant)

Primary deep-dive areas: $($Project.DeepDive)

## Clarify and Scope

- Identify the primary user and business objective.
- Select three to five core features.
- Declare what is out of scope for the sandbox version.
- Capture latency, availability, consistency, privacy, and geographic constraints.

## Functional Requirements

- Create, read, update, or process the core domain entity.
- Support the primary read path and write path.
- Expose a minimal operational workflow for testing.

## Non-Functional Requirements

- Define target latency for hot paths.
- Define expected availability.
- Define consistency expectations.
- Define durability and recovery expectations.

## Scale Assumptions

- Daily active users:
- Requests per second:
- Peak multiplier:
- Storage growth:
- Geographic distribution:

## Data Model

- Primary entities:
- Important indexes:
- Retention policy:
- Partition key candidate:

## API Sketch

- `POST /v1/items`
- `GET /v1/items/{id}`
- `GET /v1/users/{id}/timeline`
- `POST /v1/events`

## High-Level Architecture

- Client
- Load balancer or edge gateway
- API service
- Application service
- Cache
- Primary database
- Queue or event bus
- Worker service
- Observability pipeline
- AI path: LLM gateway, vector database, embedding pipeline

## Component Responsibilities

- API service validates requests and enforces authentication.
- Application service owns business logic.
- Cache protects hot read paths.
- Queue absorbs spikes and decouples slow work.
- Database stores durable source-of-truth records.
- Workers process async jobs.
- Observability captures logs, metrics, traces, and business health signals.

## Deep Dives

$($Project.DeepDive)

Questions to answer:

- Where does the design shard?
- Which path is read-heavy or write-heavy?
- Which component fails first under 10x traffic?
- Which consistency guarantee matters most?
- Which decision is most expensive to reverse?

## Failure Modes

- Cache outage.
- Queue backlog.
- Database primary failure.
- Partial regional outage.
- Hot-key or celebrity-user overload.
- Third-party provider failure.
- LLM provider latency or outage.

## Cost Reasoning

- Identify dominant cost driver.
- Define one right-sizing decision.
- Define one cost-reduction lever.
- Estimate whether multi-region active-active is justified.

## Observability

- RED metrics: rate, errors, duration.
- Saturation metrics: queue depth, cache memory, database CPU, worker lag.
- Business metrics: successful core actions, dropped events, user-facing failures.
- AI metrics: token cost, model latency, retrieval recall, fallback rate.

## Deployment and Rollback

- Use staged rollout.
- Add feature flags for risky paths.
- Keep database migrations backward compatible.
- Define rollback trigger metrics.
- Keep manual rollback instructions in the runbook.

## Security and Abuse Controls

- Authentication and authorization.
- Rate limiting by user, API key, and IP.
- Input validation.
- Audit logs for sensitive actions.
- Abuse detection and moderation where relevant.

## AI-Aware Extension

$($Project.Ai)

Required AI components:

- LLM gateway.
- Vector database.
- Embedding pipeline.
- Prompt template registry.
- Semantic cache where useful.
- Fallback behavior when the model path degrades.

## Local Test Plan

- Validate required sections exist.
- Simulate hot path request flow.
- Simulate async queue backlog.
- Simulate dependency failure.
- Validate observability and rollback notes exist.
- Validate cost and AI sections are not blank.
"@
}

function Build-Sandbox {
    New-DirectoryIfMissing -Path $SandboxRoot
    New-DirectoryIfMissing -Path $ProjectsRoot
    New-DirectoryIfMissing -Path $ReportsRoot

    $overview = @"
# Modern System Design Sandbox

This sandbox turns system design learning into repeatable, reviewable project packets for multi-agent execution.

## Framework

1. Clarify and scope.
2. Define data and APIs.
3. Draw the high-level design.
4. Deep dive, stress test, and evaluate tradeoffs.

## Modern Stack

- Classic path: client, load balancer, API services, cache, database.
- Async path: queue or event bus, workers, durable task state.
- Operating path: observability, deployment strategy, rollback, cost controls.
- AI path: LLM gateway, vector database, embedding pipeline, prompt templates, semantic cache.

## Multi-Agent Usage

- Owner Agent sets strategic goals and approval rules.
- CEO Agent chooses a project pattern and delegates work.
- Researcher Agent fills requirements, risks, and citations.
- Designer Agent produces diagrams and UX flows.
- Developer Agent implements and tests the sandbox.
- Business/Sales Agent maps the design to customer, revenue, or go-to-market implications.
"@

    Set-Content -Path (Join-Path $SandboxRoot "README.md") -Value $overview

    $matrixLines = @("# Stack Matrix", "")
    $matrixLines += "| Concept | Applies To |"
    $matrixLines += "| --- | --- |"
    foreach ($concept in $Concepts) {
        $matrixLines += "| $concept | All patterns; specialize during project deep dive |"
    }
    Set-Content -Path (Join-Path $SandboxRoot "stack-matrix.md") -Value ($matrixLines -join [Environment]::NewLine)

    foreach ($project in $Projects) {
        $path = Join-Path $ProjectsRoot "$($project.Slug).md"
        Set-Content -Path $path -Value (Get-ProjectPacket -Project $project)
    }

    $plan = @"
# CEO Execution Plan

## Objective

Use the system design sandbox to turn architecture learning into repeatable multi-agent execution.

## Delegation

- Researcher Agent: compare source material, extract best practices, and update project assumptions.
- Designer Agent: create architecture diagrams and user-flow diagrams for each project packet.
- Developer Agent: implement a minimal runnable prototype for one project pattern at a time.
- Business/Sales Agent: define business value, cost model, customer impact, and launch risks.

## First Build Target

Start with `ai-augmented-app.md` because it exercises the modern stack: API, queue, cache, database, vector database, embedding pipeline, LLM gateway, observability, fallback, and cost controls.

## Approval Gates

Human approval is required before deployment, publishing, customer contact, spending money, or connecting external paid services.
"@
    Set-Content -Path (Join-Path $SandboxRoot "ceo-execution-plan.md") -Value $plan

    Write-Host "Built sandbox at $SandboxRoot"
}

function Test-Sandbox {
    $failures = New-Object System.Collections.Generic.List[string]

    if (-not (Test-Path -LiteralPath $SandboxRoot)) {
        $failures.Add("Missing sandbox root: $SandboxRoot")
    }

    foreach ($project in $Projects) {
        $path = Join-Path $ProjectsRoot "$($project.Slug).md"
        if (-not (Test-Path -LiteralPath $path)) {
            $failures.Add("Missing project packet: $path")
            continue
        }

        $content = Get-Content -Path $path -Raw
        foreach ($section in $RequiredSections) {
            if ($content -notmatch "##\s+$([regex]::Escape($section))") {
                $failures.Add("$($project.Name) missing section: $section")
            }
        }
    }

    $reportPath = Join-Path $ReportsRoot "validation-report.md"
    New-DirectoryIfMissing -Path $ReportsRoot

    if ($failures.Count -eq 0) {
        $report = "# Validation Report`n`nStatus: PASS`n`nValidated $($Projects.Count) project packets with $($RequiredSections.Count) required sections each."
        Set-Content -Path $reportPath -Value $report
        Write-Host "PASS: sandbox validation succeeded"
        return
    }

    $reportLines = @("# Validation Report", "", "Status: FAIL", "")
    foreach ($failure in $failures) {
        $reportLines += "- $failure"
    }
    Set-Content -Path $reportPath -Value ($reportLines -join [Environment]::NewLine)
    throw "Sandbox validation failed. See $reportPath"
}

if ($Mode -eq "build" -or $Mode -eq "all") {
    Build-Sandbox
}

if ($Mode -eq "test" -or $Mode -eq "all") {
    Test-Sandbox
}

