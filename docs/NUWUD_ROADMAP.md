# 🚀 Villow Nuwud Roadmap

## Phase 0 — Stabilize Base

- [x] Preserve clean upstream Villow base.
- [x] Remove tracked frontend API key from current branch.
- [x] Add .gitignore / env examples.
- [x] Use local Active Storage in development.
- [x] Add Docker Compose.
- [x] Make frontend origin configurable.
- [ ] Rotate/restrict previously exposed Google Maps key.
- [ ] Run Docker smoke test on Patrick's machine.

## Phase 1 — Property Cockpit MVP

Goal: replace scattered browser tabs / chat links with one visual shortlist.

- [ ] add source metadata to Listing;
- [ ] add PropertyOpportunity model;
- [ ] assign PROP-OPP IDs;
- [ ] repurpose Favorites into Interest / Watch / Research / Opportunity / Passed;
- [ ] show Nuwud status and next action on cards;
- [ ] add manual "paste listing URL / address" intake;
- [ ] support land + commercial fields without requiring bedrooms/bathrooms.

## Phase 2 — Nuwud Property Intelligence

- [ ] land-value lens tab;
- [ ] strange-land archetypes;
- [ ] constraint map;
- [ ] government-auction/public-source tag;
- [ ] evidence / confidence labels;
- [ ] compare candidates;
- [ ] capital preflight summary.

## Phase 3 — People / Ecosystem

- [ ] link contractors/operators;
- [ ] quote / lead-time tracking;
- [ ] Business registry pointer;
- [ ] preferred / backup operator display;
- [ ] geographic capability map.

## Phase 4 — Source Adapters

Prioritize legal/allowed data access.

- [ ] manual URL ingestion;
- [ ] county/public records;
- [ ] government surplus/tax deed feeds;
- [ ] economic-development site inventories;
- [ ] listing-provider integrations only where terms/API access permit.

Avoid brittle scraping as the core architecture.

## Phase 5 — Cloud

- [ ] Cloud Run application deployment;
- [ ] Cloud SQL PostgreSQL;
- [ ] Cloud Storage;
- [ ] Secret Manager;
- [ ] backups;
- [ ] authentication hardening;
- [ ] domain / TLS;
- [ ] optional private access.

## Phase 6 — Automation

Only after the manual workflow proves useful:

- source refresh;
- status-change detection;
- auction deadline alerts;
- stale-listing detection;
- property-research packet generation;
- operator discovery;
- Property/Business/Capital handoff generation.

## Rule

> Build the interface around Patrick's actual property decisions before automating the whole real-estate internet.
