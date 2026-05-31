<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Bass Surface Drum

Status: L2 V5 build-packet candidate.

A very large (800 mm OD) single-head frame drum with a **rolled sheet-metal frame**, tuned to a sub-bass acceptance band centered at **50 Hz** (~G1) for cinematic boom and slow processional pulse.

> Part of the Heifer Zephyr sheet-metal-instruments sprint, Round 5 (percussion).
> V5 migration surface — not yet a measured build; CAD/DXF/acoustic claims remain pending review or measurement before fabrication authority.

## Family & target

| | |
|---|---|
| Family | drum |
| Subfamily | frame drum (single-head) |
| Acoustic class | low-tension circular membrane |
| Target fundamental `f_01` | 50 Hz, acceptance [42, 60] Hz |
| Head outside diameter | 800 mm |
| Effective membrane diameter | 760 mm |
| Frame depth | 120 mm |
| Frame material | 1.5 mm cold-rolled steel, rolled cylinder |
| Head material (V0) | thick raw steerhide (1.5–2.0 mm) |
| Tensioning (V0) | Variant A — 6× M10 clamp ring |
| Mallet | bought, soft cinematic bass (e.g. Vic Firth STH1) |

## Design thesis

The sheet-metal frame replaces traditional steam-bent wood for three reasons:

1. At 800 mm OD, steam-bent wood hoops of the required cross section are expensive and warp-prone.
2. A rolled steel hoop holds true-round to a tighter tolerance than wood — which keeps the head bearing edge flat and tension even around the rim.
3. The steel hoop integrates the head bearing-edge flange into the same forming operation, eliminating a separate wood bearing-edge fabrication.

The frame has two integral rolled-edge features: a 4 mm-radius outward bearing flange at the top, and a 6 mm rolled-in stiffening bead at the bottom (anti-ovalization stiffness without a separate hoop ring).

## Packet contents

| File | What it does |
|---|---|
| [`design.md`](design.md) | Parametric design narrative, family position, acoustic model |
| [`parameters.csv`](parameters.csv) | Every dimension a downstream agent could need |
| [`bass-surface-drum-starter.wl`](bass-surface-drum-starter.wl) | Bessel-mode predictions, rim-tension solver, ovalization bounds, sensitivity |
| [`tuning-notes.md`](tuning-notes.md) | Three-pass star-pattern tuning method |
| [`solidworks-plan.md`](solidworks-plan.md) | Master layout, 4 child parts, feature trees, equations |
| [`flat-pattern-checklist.md`](flat-pattern-checklist.md) | Per-DXF spec with CUT/BENDS/ETCH layers |
| [`bend-table.csv`](bend-table.csv) | Bend allowances with K=0.44 CRS |
| [`cut-list.csv`](cut-list.csv) | Stock + nesting |
| [`bom.csv`](bom.csv), [`hardware.csv`](hardware.csv), [`sourcing.csv`](sourcing.csv) | Procurement |
| [`cnc/`](cnc/) | 13-operation shop plan, operations.csv, cnc-plan.json |
| [`fabrication-plan.md`](fabrication-plan.md) | Cut → form → join → finish → inspect sequence |
| [`assembly-manual.md`](assembly-manual.md) | 9-step V0 head-mount procedure (Variant A) |
| [`validation.csv`](validation.csv) | 35 gates from incoming through release |
| [`visual-output-register.csv`](visual-output-register.csv) | V5 artifact authority register |
| [`cad/mcp-session-log.md`](cad/mcp-session-log.md) | V5 CAD/creative-tool provenance stub |
| [`risks.md`](risks.md) | Risk register + release gates |
| [`supplier-rfq.md`](supplier-rfq.md), [`visual-bom-brief.md`](visual-bom-brief.md), [`photo-shotlist.md`](photo-shotlist.md) | Capstone-side documents |
| [`learn-to-play/`](learn-to-play/) | Strike map + 3 beginner exercises |
| [`agent-record.md`](agent-record.md) | qmd citations, assumptions, confidence, next-round task |
| [`explorer.html`](explorer.html) | Studio explorer for this packet |

## License

Dual-licensed.

- **Hardware** (CAD, DXF, STEP, BOM, fabrication plans, parameter CSVs, Wolfram .wl): **CERN-OHL-W v2.0** — see [`LICENSE-HARDWARE.md`](LICENSE-HARDWARE.md)
- **Documentation and media** (markdown, images, diagrams): **CC BY 4.0** — see [`LICENSE-DOCS.md`](LICENSE-DOCS.md)
- SPDX: `CERN-OHL-W-2.0 AND CC-BY-4.0`

Per-file SPDX headers indicate which license applies.

## Status

Status: L2 V5 build-packet candidate. The packet is private until each release gate in `risks.md` is cleared. Existing dimensions, tuning targets, Wolfram outputs, SolidWorks plans, flat-pattern notes, and CNC plans are treated as planning/review surfaces, not fabrication authority, until reviewed CAD/DXF or measured prototype evidence is committed and registered in `visual-output-register.csv`.
