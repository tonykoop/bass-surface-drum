<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# CAD / Creative Tool Provenance Log

Status: V5 provenance stub.

No MCP, SolidWorks, OpenSCAD, Blender, Illustrator, Photoshop, Fusion, CNC, or
physical measurement tool was available during this Round 3 migration. This
run added only a README status boundary, a visual-output authority register,
and this provenance stub.

| session_id | tool | input_authority | outputs | role | authority_result | review_status | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| R3-2026-05-29-local | Codex text edit | Existing repo README/design packet plus V5 migration standard | `README.md`; `visual-output-register.csv`; `cad/mcp-session-log.md` | v5_migration_register | concept_only | self_checked | No CAD geometry, DXF coordinates, acoustic data, Wolfram execution, CNC toolpath, or measured prototype evidence was generated. |

## Step 0 Retrieval Notes

- `qmd query "bass surface drum V5 packet"` was started but did not return
  before timeout and was stopped.
- `qmd search "bass-surface-drum" -c instrument-builds` returned no results.
- `qmd search "bass surface drum" -c instrument-builds` returned general
  instrument-maker manufacturing, CNC, workbook, and family-spec references.

## Promotion Rule

Add future rows when a real CAD, drawing, creative, CNC, Wolfram, or measurement
session creates or modifies an artifact. A future row may use `fabrication`
only when the output traces to reviewed CAD/DXF/design-table data or measured
prototype evidence and the artifact is also promoted in
`visual-output-register.csv`.
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) + OpenSCAD CLI | parameters.csv, design.md | cad/bass-surface-drum.scad | cad_authoring | pending_measurement | self_checked | Parametric membrane-frame envelope master (frame OD 800 mm, depth 120 mm, wall 1.5 mm, 6 x M10 clamp-ring bolt field, effective membrane dia 760 mm) — all from parameters.csv. Tuning-sensitive rolled bead/flange + membrane tension out of scope. openscad render check: pass (Simple: yes, exit 0). NOT fabrication authority until reviewed. |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) | Bessel-root circular-membrane model | wolfram/bass-surface-drum-wolfram-model.wl | analysis_source | derived_preview | unreviewed | Membrane tension / modal-frequency model; source-only (not executed). L2 evidence. |
