# Storage Budget Policy

Total local system storage target: 5 GB maximum.

This budget includes:

- Repository files.
- Markdown memory.
- Task logs.
- Sandbox outputs.
- Test reports.
- Browser screenshots.
- Generated documents.
- Local databases or indexes.

## Budget Allocation

| Category | Target Limit |
| --- | ---: |
| Core repo, scripts, prompts, templates | 250 MB |
| Markdown memory, project logs, reports | 750 MB |
| Sandbox prototypes and generated test outputs | 1 GB |
| Browser screenshots and visual artifacts | 1 GB |
| Local databases, embeddings, indexes, caches | 1.5 GB |
| Reserved buffer | 500 MB |

## Operating Rules

- Keep Markdown as the default memory format.
- Store summaries instead of full raw transcripts unless the raw transcript is required.
- Do not store large generated media by default.
- Keep screenshots only when they document a failure, approval, or final milestone.
- Rotate hourly reports into weekly summaries once they are no longer actively needed.
- Prefer remote storage links for large assets.
- Do not add Docker images, package caches, browser profiles, or build artifacts to the repo.
- Keep local vector indexes optional and capped.

## Warning Thresholds

- At 3 GB: start summarizing logs and deleting temporary artifacts.
- At 4 GB: pause new artifact generation unless approved.
- At 4.5 GB: archive or remove old sandbox outputs before continuing.
- At 5 GB: stop and request owner approval before creating additional local artifacts.

## Git Rules

Never commit:

- Build outputs.
- Package caches.
- Browser profiles.
- Large screenshots unless required.
- Local databases.
- Vector indexes.
- Secret files.
- Temporary files.

