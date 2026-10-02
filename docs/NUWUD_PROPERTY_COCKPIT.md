# 🏠 Villow — Nuwud Property Cockpit

> Villow is the human-facing visual workspace for Nuwud property discovery and active candidate tracking.

It does **not** replace the canonical domain systems.

## Architecture

```text
PROPERTY SOURCES
Zillow / brokers / LandSearch / auctions / tax deeds / FDOT / GSA / owner-direct
        ↓
VILLOW — visual discovery + live candidate workspace
        ↓
PROPERTY — rules, lifecycle, opportunity IDs, durable handoff
        ↓
BUSINESS — operators / contractors / partners
CAPITAL — financing / staged capital
LEGAL / TAX / RISK — specialist truth
```

## Source Record vs Nuwud Analysis

### Listing

A `Listing` represents what an external source says about a property.

Examples:

- address;
- asking price;
- beds/baths;
- acreage / square footage;
- description;
- photos;
- coordinates;
- source URL;
- source name;
- source timestamp.

Do not overwrite source facts with Nuwud assumptions.

### Property Opportunity

A `PropertyOpportunity` is Nuwud's analysis/workflow overlay.

It should contain:

- `PROP-OPP-YYYY-NNN` ID;
- canonical status;
- intended use;
- property class;
- strange-land archetypes;
- verified facts vs claims vs hypotheses;
- land-value lenses;
- constraint map;
- operator / contractor relationships;
- capital snapshot;
- next action / next trigger;
- decision history;
- pointers to Legal / Tax / Risk / Finance when required.

One source listing can become one Property Opportunity.

A Property Opportunity can survive even if the original listing disappears.

## Villow Ownership Boundary

### Villow owns live working state

Once activated:

- active candidate cards;
- map pins;
- saved/watch state;
- live property notes;
- status changes;
- source links;
- comparisons;
- working contractor/capital references;
- current next action.

### Property repo owns canon

- state definitions;
- field semantics;
- diligence methods;
- templates;
- acquisition rules;
- land-value lens definitions;
- strange-land framework;
- durable archived/acquired handoff.

Do not manually maintain the same live field in both places.

## UI Concept

### Map + cards

Keep the familiar Zillow-like split-screen:

- map on one side;
- property cards on the other.

But our cards add Nuwud signals:

- `PROP-OPP` ID;
- source type;
- status;
- acreage / building area;
- asking/control price;
- strange-land tag;
- government/public tag;
- capital-preflight state;
- biggest unknown;
- next action.

### Property detail

Tabs:

1. **Overview** — listing/source facts.
2. **Nuwud** — opportunity status, why we care, intended use.
3. **Land Lenses** — rights, physical, network, use, cash flow, optionality.
4. **Constraints** — access/water/septic/power/environment/etc.
5. **People** — brokers, contractors, specialists, sellers, public contacts.
6. **Capital** — control/close/usable/stable.
7. **Evidence** — source URLs, documents, dates, confidence.
8. **Timeline** — decisions and state transitions.

### Saved properties

Repurpose the existing Favorites concept:

- ❤️ **Interesting** — casual save;
- 👀 **Watch** — monitor;
- 🔬 **Research** — active screening;
- 🚀 **Opportunity** — assigned PROP-OPP ID;
- ❌ **Passed** — retained for learning.

## Search Sources

Villow should eventually accept/import candidates from:

- normal residential listings;
- commercial brokers;
- land sites;
- county surplus;
- tax deeds;
- FDOT surplus;
- state surplus;
- GSA federal sales;
- Treasury seized real estate;
- airport / port development solicitations;
- economic-development site inventories;
- owner-direct / off-market;
- manual URL / address entry.

Villow is not dependent on one listing API.

## Deployment Strategy

### Local-first

Docker Compose:

- Rails;
- PostgreSQL;
- React;
- local Active Storage.

This is the fastest/private development environment.

### Dynamic cloud

When remote access is useful:

- containerize the same services;
- Cloud Run for application containers;
- Cloud SQL for PostgreSQL;
- Cloud Storage for durable uploads/photos;
- Secret Manager for secrets;
- custom domain / HTTPS.

The application should remain portable rather than dependent on one deployment provider.

## Security

Never commit:

- API keys;
- database passwords;
- Rails master key;
- cloud service credentials.

Browser-visible Maps/API keys should still be restricted by API and allowed origin/referrer.

## Core Rule

> **Villow makes Property easy to see and operate. Property defines what the information means.**
