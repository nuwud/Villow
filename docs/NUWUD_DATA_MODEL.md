# 🧬 Nuwud Property Cockpit Data Model

## Preserve Existing Model

Do not rewrite `Listing` into a giant Property OS table.

Use separate layers.

## Proposed Entities

### Listing

External/source property snapshot.

Add over time:

- `source_type`;
- `source_name`;
- `source_url`;
- `source_external_id`;
- `source_checked_at`;
- `lot_size_acres`;
- `property_type`.

Existing residential fields can remain for compatibility.

### PropertyOpportunity

Nuwud working overlay.

Suggested fields:

- `opportunity_id` — unique `PROP-OPP-YYYY-NNN`;
- `listing_id` — optional source listing;
- `status`;
- `property_class`;
- `intended_use`;
- `why_interesting`;
- `next_action`;
- `next_trigger`;
- `state_evidence`;
- `biggest_unknown`;
- `strange_land_classification`;
- `archetypes` — JSONB/array;
- `land_lenses` — JSONB;
- `verified_facts` — JSONB;
- `claims_to_verify` — JSONB;
- `hypotheses` — JSONB;
- `capital_snapshot` — JSONB;
- timestamps.

### OpportunityConstraint

Structured issues that affect use/value.

- opportunity;
- category;
- severity;
- requirement class;
- status;
- estimate_low / high;
- confidence;
- verification method;
- next action.

### OpportunityContact

References a person/company involved in this specific property.

- opportunity;
- company name;
- contact;
- role;
- Business-registry pointer;
- relationship status;
- quote / estimate pointer;
- last contacted.

Do not duplicate the full Business company dossier in Villow.

### OpportunitySource

Multiple source/evidence records per property.

- URL;
- source type;
- title;
- date checked;
- factual claim;
- confidence;
- secure document pointer.

### OpportunityEvent

Append-only state / decision history.

- opportunity;
- event type;
- prior state;
- new state;
- summary;
- evidence;
- occurred_at.

## Canonical Statuses

Consume the Property OS status vocabulary rather than inventing Villow-only status names.

## Property ID Generation

Initial implementation:

- Villow can request/assign the next `PROP-OPP` ID;
- the Property repo registry is reconciled during handoff.

Longer-term:

- Villow becomes the live ID registry for active candidates;
- Property keeps the durable protocol and exported/historical index.

Do not allow two independent ID generators.

## Sensitive Data

Villow may store decision-safe summaries.

Keep outside ordinary application records:

- account numbers;
- privileged legal advice;
- raw tax returns;
- government IDs;
- passwords / tokens;
- unredacted sensitive evidence.

## Future Integrations

Possible adapters:

- Property repo export/import;
- Google Drive evidence pointers;
- contractor/company registry;
- Capital plan;
- county property appraisers;
- GIS / parcel data;
- flood / wetland;
- public auction feeds;
- commercial listing/manual import;
- AI research summaries with explicit source/evidence labels.
