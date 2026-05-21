<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# drawings/

DXF flat patterns and dimensioned PDFs.

V0 status: placeholders. The geometry is fully specified in `../flat-pattern-checklist.md`, `../bend-table.csv`, and `../cut-list.csv`. A competent CAD operator can produce these DXFs directly from those documents in under an hour:

- `frame-flat.dxf` — 2513 × 120 mm rectangle + tab/slot pairs + bend layers
- `doubler-flat.dxf` — 50 × 120 mm rectangle
- `clamp-ring.dxf` — 870/770 mm annulus + 6 bolt holes
- `lug-bracket.dxf` — L-bracket with single bolt hole, 6 copies nested

A future round may produce these from a SolidWorks master part. For V0 they are intentionally not in the repo to keep the packet honest about what is *specified* vs. what is *modelled*.
