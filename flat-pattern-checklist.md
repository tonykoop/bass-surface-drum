<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Flat-Pattern Checklist — Bass Surface Drum

## DXF Output Spec (apply to every DXF in `drawings/`)

- [ ] Units declared in header: **mm**
- [ ] Layer `CUT` — outline geometry, color cyan (lineweight 0.10 mm)
- [ ] Layer `BENDS` — bend centerlines, color magenta (lineweight 0.05 mm, dashed)
- [ ] Layer `ETCH` — alignment marks and witness lines, color green (lineweight 0.05 mm)
- [ ] No splines on `CUT` layer — convert to polylines (laser/plasma controllers prefer polylines)
- [ ] No nested entities (explode blocks before export)
- [ ] Origin at lower-left of bounding box
- [ ] Grain direction call-out present (matters for cold-rolled steel bend cracking)

## Parts

### `frame-flat.dxf` — main frame, rolled cylinder

- Developed length: **2513 mm** (= π × 799.4, i.e. π × (HEAD_OD − FRAME_THICKNESS) using the neutral axis at the inside of the wall with K = 0.44 — see `bend-table.csv` for the bend-allowance derivation per long edge)
- Depth: 120 mm + 2× bend allowances
- Bends:
  - Top edge: 90° outward-rolled flange ending in a 4 mm radius bearing curl. Modelled as a 90° bend at IR 4 mm followed by a return.
  - Bottom edge: rolled-in bead of 6 mm radius — typically formed on a bead roller, not a press brake. The flat blank receives a single bend-allowance compensation for the bead, then the bead profile is rolled in as a secondary operation.
- Seam edges (the two short ends of the rectangle): include 4 tab-and-slot pairs:
  - Tabs: 6 × 10 mm, on the right-hand edge, at 20%/40%/60%/80% of depth
  - Slots: 6.5 × 11 mm, on the left-hand edge, matching tab positions
- Etched alignment lines at each 90° around the developed length to verify the rolled cylinder is true-round (4 etched vertical witness lines)
- Material call-out in title block: **CRS 1.5 mm**

### `doubler-flat.dxf` — internal seam reinforcement strip

- 50 × 120 mm rectangle
- 6 spot-weld witness marks etched (2 cols × 3 rows) at 25%/75% width × 20%/50%/80% depth
- Material call-out: **CRS 1.5 mm**

### `clamp-ring.dxf` — Variant A clamp ring

- Flat annulus: OD 870 mm / ID 770 mm
- 6× Ø11 mm bolt-clearance holes on PCD 850 mm, 60° spacing
- 1 etched index notch on OD (for repeatable orientation during stack-up)
- Material call-out: **CRS 4 mm**

### `lug-bracket.dxf` — Variant A tension brackets

- L-bracket profile in flat: 80 × 70 mm (40 mm horizontal × 40 mm vertical + 30 mm welding flange)
- Single Ø11 mm hole centered on vertical leg
- Bend line at 40 mm from horizontal datum, 90° inside radius 3 mm
- Nest 6 of these in the same DXF for efficient laser cutting; one part per outline, six outlines total
- Material call-out: **CRS 3 mm**

## Cone / Lofted-Bend Parts

None — this design has only cylindrical and flat parts. The 800 mm rolled cylinder is a single-radius bend, and the head-bearing flange is a tight 90° roll into a 4 mm radius lip. No lofted bends, no cones, no compound curves.

This is deliberate: it keeps the part within "service-bureau slip-roll + press-brake" capability and avoids the spinning / drawing operations that other Round-5 drums (djembe, talking drum) require.

## Coupon Tests Called Out

- **Bend-edge crack coupon** — fold a 100 × 100 mm scrap of the same CRS 1.5 mm sheet to the same 4 mm radius. Inspect outside fiber for cracks. If the cold-rolled stock cracks at this radius, anneal locally with a torch before bending or increase the radius to 6 mm.
- **Bead-roll coupon** — bead-roll a 300 × 120 mm scrap to the same 6 mm bead profile. Confirm the bead is full-depth and the strip is not buckled out-of-plane.
- **Seam-weld coupon** — TIG-weld a butt joint in two scrap strips and bend the weld 180° around a mandrel. The weld must not crack. If it does, adjust filler/heat input.

## Helper Math Used

```bash
python ~/.claude/skills/sheet-metal/scripts/sheet_metal_math.py bend-allowance \
  --angle-deg 90 --radius 0.157 --thickness 0.059 --k-factor 0.44
# (4 mm radius, 1.5 mm thickness, 0.44 K-factor → see bend-table.csv row 1)
```

Bend allowance values are tabulated in `bend-table.csv` rather than recomputed here.
