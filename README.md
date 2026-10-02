# 🏠 Villow — Nuwud Property Cockpit

> **Status:** internal prototype / evaluation fork.

This repository began as a fork of [M8825/Villow](https://github.com/M8825/Villow), a Zillow-style Rails + React real-estate application.

Nuwud is evaluating the familiar map + property-card interface as the **human-facing cockpit for the Nuwud Property OS**.

## Nuwud Direction

Villow should make it easy to:

- save properties from many sources;
- map what we are watching;
- distinguish casual saves from serious opportunities;
- assign `PROP-OPP-YYYY-NNN` IDs;
- track Property Opportunity state;
- compare land / residential / commercial / industrial candidates;
- expose Strange Land and government/public-disposition opportunities;
- show constraints, contractors and capital questions;
- preserve the original source facts separately from Nuwud analysis.

Canonical architecture:

- [Nuwud Property Cockpit](docs/NUWUD_PROPERTY_COCKPIT.md)
- [Nuwud Data Model](docs/NUWUD_DATA_MODEL.md)
- [Nuwud Roadmap](docs/NUWUD_ROADMAP.md)
- [nuwud/Property](https://github.com/nuwud/Property) — canonical Property rules and lifecycle.

## Local Development — Docker

1. Copy `.env.example` to `.env`.
2. Add a Google Maps browser API key if map rendering is needed.
3. Restrict that key in Google Cloud by API and allowed origin/referrer.
4. Run:

```bash
docker compose up --build
```

Then:

- Frontend: http://localhost:3000
- Rails API: http://localhost:8000
- PostgreSQL: localhost:5432

Development uploads use local Active Storage.

## Deployment Direction

Local Docker is the development/private baseline.

If remote/dynamic access becomes useful, the intended direction is container deployment on Google Cloud with managed PostgreSQL and durable object storage while keeping the app portable.

## Security

Secrets must not be committed to this repository.

A Google Maps key inherited from the upstream environment file was removed from the current branch. Because Git history may still contain the old value, that key should be rotated/restricted before reuse.

## Upstream / License Boundary

The upstream repository does not currently appear to include an explicit open-source license file.

Until reuse rights are clarified:

- use this fork as an internal prototype/evaluation surface;
- preserve upstream attribution/history;
- do not assume the code may be commercially relicensed or redistributed;
- if needed, rebuild the useful Villow interaction patterns in clearly Nuwud-owned code.

## Original Villow Functionality

The upstream project includes:

- Rails 7 backend;
- PostgreSQL;
- React / Redux frontend;
- user authentication;
- property listings;
- favorites;
- Google Maps markers;
- search / filters;
- listing creation;
- Active Storage / S3 support.

That foundation is useful, but the Nuwud version should evolve around **property decision workflow**, not around cloning Zillow.

## Core Rule

> **Villow makes Property easy to see and operate. Property defines what the information means.**


## Nuwud Fork Direction

This fork is being evaluated as the human-facing **Nuwud Property Cockpit** layered over the canonical [nuwud/Property](https://github.com/nuwud/Property) system.

Planned direction includes:

- saved property/opportunity tracking;
- shared `PROP-OPP` IDs;
- raw land + commercial + strange-land views;
- government/public acquisition channels;
- land-value lenses;
- contractor/operator intelligence;
- capital preflight;
- Property / Business / Capital / Legal / Tax / Risk handoffs.

Deployment is intentionally portable:

- local Docker for development/private use;
- Google Cloud Run + managed PostgreSQL when dynamic public hosting is needed;
- static React frontend may live on DreamHost or another static host.

See [docs/DEPLOYMENT_ARCHITECTURE.md](docs/DEPLOYMENT_ARCHITECTURE.md).
