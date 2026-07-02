# Design Intent — bass-surface-drum rev A

- Master CAD: `cad/bass-surface-drum.scad` (sha256: 5621eaa165744873b245a05e191245d716b93a84541c22788b053e9b454c7bec), envelope driven by `parameters.csv` (sha256: 1ede71450e5f8e7e5bd9e242f11846ce416285827846425e90de6c7f7a661871).
- Function: Large single-head sub-bass surface drum — a rolled cold-rolled-steel frame cylinder carries a wide steerhide membrane under clamp-ring tension, tuned to a cinematic sub-bass fundamental. Struck with a soft bass mallet; a stage/floor instrument.
- Environment: heavy floor/stage instrument; steel frame under sustained radial head pull (~7 kN total); membrane tension is the tuned load path and is humidity/temperature sensitive.
- Target qty: 1 (V0 prototype). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Head outside diameter | 800 mm | frame round-out; ovalization budget 0.5 mm | head seating / frame roundness | parameters.csv head_outside_diameter (high) |
| Effective membrane diameter | 760 mm | inside bearing radius | fundamental pitch scaling | parameters.csv head_effective_diameter (high) |
| Frame depth | 120 mm | cut-list gate | resonance / stance | parameters.csv frame_depth (med) |
| Frame wall thickness | 1.5 mm CRS | material cert | stiffness vs weight | parameters.csv frame_wall_thickness (med) |
| Target fundamental f01 | 50 Hz (accept 42–60 Hz) | measured after tuning | acoustic intent | parameters.csv target_fundamental_f01 (high) |
| Tension bolts | 6 × M10 grade 8.8 | ≤25 Nm working torque | even head tension / safety | parameters.csv tension_bolt_count (med) |
| Bearing edge radius | 4 mm rolled flange | bead-roller setup | head life / tone | parameters.csv frame_bearing_edge_radius (med) |

## Incidental (free for DFM)

- External finish/paint, lug-bracket cosmetic form, mounting/stand solution (deferred to makerspace follow-up), non-mating surface treatment.

## Must-nots (DFM may never violate)

- Do not use tension bolts below grade 8.8, and replace any bolt over-torqued past 25 Nm — snap-under-tension risk (risks.md).
- Do not accept azimuthal pitch variation > 1 Hz around the rim — uneven head tension; re-tension from finger-tight (risks.md).
- Do not treat parameters.csv membrane_tension / total_radial_pull / surface_density rows as verified — they are low-confidence solved values pending measured evidence.
- Do not treat the .scad clamp_ring_width or rolled bead/flange profiles as fabrication dimensions — envelope + assumptions only.

## Material intent

- Preferred: cold-rolled steel frame (1018 or similar); raw steerhide membrane (~1.5 mm); grade 8.8 M10 tension hardware per bom.csv / hardware.csv.
- Acceptable subs: per sourcing.csv (spec-first; live prices unverified).
- Forbidden: none recorded.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable. Status preserved at L2 V5 build-packet candidate.
