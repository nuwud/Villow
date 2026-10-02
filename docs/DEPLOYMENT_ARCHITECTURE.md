# 🚀 Villow Deployment Architecture — Nuwud Fork

## Decision

Villow should be **portable first**, not tied to one host.

The application is already naturally split:

- **Frontend:** React / Create React App
- **Backend:** Ruby 3.1.1 / Rails 7 API / Puma
- **Database:** PostgreSQL
- **Storage:** AWS S3 integration already exists
- **Frontend → backend:** `REACT_APP_BACKEND_URL`
- **Backend → frontend trust:** `FRONTEND_ORIGIN`

That makes a multi-environment architecture straightforward.

## Recommended Shape

~~~text
LOCAL DEVELOPMENT / PRIVATE USE

Docker Compose
├── frontend : React dev server
├── api      : Rails / Puma
└── postgres : PostgreSQL


PUBLIC / PRODUCTION

Static frontend
(DreamHost OR Firebase Hosting)
        ↓ HTTPS
Rails API
(Google Cloud Run)
        ↓
PostgreSQL
(Google Cloud SQL)
        ↓
Object storage
(existing S3 or future chosen provider)
~~~

## Why Not DreamHost Shared for the Whole App?

DreamHost shared hosting currently supports Ruby itself, but DreamHost says Ruby on Rails applications require Managed VPS or Dedicated hosting because of memory requirements.

DreamHost also states PostgreSQL is **not supported on Shared Hosting**.

So DreamHost shared is a reasonable place for the compiled React frontend, but not the clean home for the Rails + PostgreSQL application stack.

## Why Google Cloud Run Fits Villow

Cloud Run:

- runs OCI/Docker containers;
- provides HTTPS endpoints;
- can scale down when unused;
- supports environment variables / secrets;
- connects directly to Cloud SQL;
- supports custom domains;
- avoids maintaining a VM.

The Rails backend already expects a production `DATABASE_URL`, which maps cleanly to a managed PostgreSQL deployment.

## Frontend Options

### Option A — DreamHost Static Frontend

Good when:

- we already pay for DreamHost;
- the frontend is just the compiled React build;
- we want simple domain/DNS hosting.

Requirements:

- run `npm run build`;
- upload the build output;
- add an SPA rewrite so BrowserRouter routes resolve to `index.html`;
- set `REACT_APP_BACKEND_URL` at build time to the public API URL;
- set Rails `FRONTEND_ORIGIN` to the frontend URL.

### Option B — Firebase Hosting

Good when:

- keeping the production application in the Google ecosystem;
- wanting simple SPA rewrites and TLS;
- wanting automated deploys.

### Option C — Frontend Container on Cloud Run

Works, but is usually unnecessary for a static CRA build.

Use this only if we later add server-rendering or dynamic frontend behavior that needs a runtime.

## Backend

Recommended production target:

**Google Cloud Run**

Environment variables / secrets will include at minimum:

- `RAILS_ENV=production`
- `RAILS_MASTER_KEY`
- `DATABASE_URL` or Cloud SQL connection configuration
- `FRONTEND_ORIGIN`
- AWS/S3 credentials or replacement storage configuration
- any Google Maps / geocoding keys required by the frontend/backend

## Database

### Local

PostgreSQL container.

### Production

Cloud SQL for PostgreSQL is the clean Google-native choice.

Important cost note:

Cloud Run can scale to zero, but a managed database is persistent infrastructure. For a very low-traffic internal Villow deployment, the database may become the largest baseline cloud cost.

Do not over-provision it.

## Domain Pattern

Example:

~~~text
properties.nuwud.com      → React frontend
api.properties.nuwud.com  → Rails / Cloud Run
~~~

This keeps the frontend and API clearly separated while remaining under one Nuwud domain.

## Session / CORS

The current code already supports:

- configurable frontend origin;
- credentialed requests;
- configurable backend URL.

Before production deploy, verify:

- Rails session-cookie `Secure` / `SameSite` settings;
- CORS exact origin;
- HTTPS-only behavior;
- CSRF flow across the chosen frontend/API domains.

## Docker Strategy

Create separate container definitions:

- `Dockerfile.api`
- `Dockerfile.frontend`
- `docker-compose.yml`

Local Compose should provide:

~~~text
frontend :3000
api      :8000
postgres :5432
~~~

The API container should be reusable for Cloud Run.

The frontend container is primarily useful for local development; production can use the static build.

## Deployment Progression

### Phase 1 — Local

Containerize Villow and run everything locally.

Goal:
- understand the existing app;
- make Nuwud-specific changes;
- add Property OS data model;
- avoid cloud cost while developing.

### Phase 2 — Private / Test Cloud

Deploy Rails container to Cloud Run and PostgreSQL to a small Cloud SQL instance.

Frontend can remain local or deploy to a temporary static host.

### Phase 3 — Public Nuwud Property Cockpit

Deploy:

- frontend → chosen static host;
- backend → Cloud Run;
- DB → Cloud SQL;
- custom domain;
- backups;
- monitoring;
- secrets.

### Phase 4 — Scale Only When Needed

Add:

- automated deploys;
- background jobs;
- object-storage migration if needed;
- GIS / parcel APIs;
- public auction feeds;
- Property OS synchronization;
- search indexing;
- notifications / monitoring.

## Villow's Nuwud Role

Villow should become the **human-facing property cockpit**, not the canonical property database by itself.

~~~text
Villow UI
→ Property Opportunity
→ PROP-OPP ID
→ Property OS
→ Business operator intelligence
→ Capital
→ Legal / Tax / Risk
~~~

Villow can display and edit workflow state, but the canonical domain boundaries established in the Nuwud system remain authoritative.

## Recommendation

**Use Docker as the portability layer.**

For now:
- build locally;
- keep cloud spend at zero/minimal.

When Villow needs to be reachable anywhere:
- Rails → Cloud Run;
- PostgreSQL → Cloud SQL;
- React → DreamHost static hosting or Firebase Hosting.

DreamHost shared remains useful; it simply should not be forced to run the parts it is poorly suited to run.
