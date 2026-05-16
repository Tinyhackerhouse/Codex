# E-Commerce

## Pattern Summary

Examples: Amazon, Shopify, marketplace checkout

Dominant concepts: Transactional database, caching, search, queues, rate limiting

Primary deep-dive areas: Inventory consistency, idempotent payments, order workflow, flash sales

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

- POST /v1/items
- GET /v1/items/{id}
- GET /v1/users/{id}/timeline
- POST /v1/events

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

Inventory consistency, idempotent payments, order workflow, flash sales

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

Personalized recommendations, support chatbot, semantic product search

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
