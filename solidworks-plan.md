<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# SolidWorks Plan — Bass Surface Drum

## Master Layout Part

Single master layout part `bass-surface-drum-master.sldprt` holds all global variables. All downstream parts reference these.

### Global Variables

| Variable                | Value     | Units | Notes                                       |
|------------------------|-----------|-------|---------------------------------------------|
| `HEAD_OD`              | 800       | mm    | drives outer diameter of frame              |
| `HEAD_EFFECTIVE_DIA`   | 760       | mm    | head bearing inside diameter                |
| `FRAME_DEPTH`          | 120       | mm    | axial depth of frame                        |
| `FRAME_THICKNESS`      | 1.5       | mm    | cold-rolled steel sheet                     |
| `BEARING_RAD`          | 4         | mm    | rolled flange radius (top)                  |
| `BEAD_RAD`             | 6         | mm    | rolled stiffening bead (bottom)             |
| `DOUBLER_WIDTH`        | 50        | mm    | internal seam-reinforcement strip width     |
| `DOUBLER_THICKNESS`    | 1.5       | mm    | same gauge as frame                         |
| `LUG_COUNT`            | 6         | —     | Variant A clamp-ring tension brackets       |
| `LUG_BOLT_THREAD`      | M10       | —     | grade 8.8                                   |
| `LUG_PCD_OFFSET`       | 25        | mm    | clamp-ring bolt PCD = HEAD_OD + 50          |
| `CLAMP_RING_THICK`     | 4         | mm    | rolled clamp-ring stock                     |
| `CLAMP_RING_OD`        | 870       | mm    | overlaps frame OD                           |
| `K_FACTOR_CR_STEEL`    | 0.44      | —     | for 1.5 mm cold-rolled steel, soft bend     |

## Feature Tree

### Part 1 — `frame-cylinder.sldprt` (rolled body)

1. Sketch 1 — rectangle 2513 × 120 mm (developed length × depth). Width formula: `pi * (HEAD_OD - FRAME_THICKNESS)`.
2. Extruded sheet body — 1.5 mm thickness (sheet metal feature).
3. Insert bends:
   - Top edge: flange outward at `BEARING_RAD = 4 mm` (forms head bearing).
   - Bottom edge: rolled-in bead at `BEAD_RAD = 6 mm` (stiffening).
4. Roll-into-cylinder feature (sheet-metal "convert to cylinder" or modelled with surface roll + thicken if SW seat doesn't support large-radius roll).
5. Flat-pattern config:
   - Bend lines on layer `BENDS`
   - Cut on layer `CUT`
   - Etch (seam alignment marks at top and bottom) on layer `ETCH`
6. Tab-and-slot strategy at the seam:
   - 4 alignment tabs on one edge, mating slots on the other
   - Tabs are sacrificial: ground flush after the TIG seam weld is dressed

### Part 2 — `internal-doubler.sldprt` (seam reinforcement)

1. Sketch — rectangle 50 × 120 mm
2. Extruded sheet body — 1.5 mm
3. Optional: roll to match `HEAD_OD/2` ID so the doubler hugs the inside of the frame
4. Spot-weld pattern: 6 spots in a 2-column × 3-row grid

### Part 3 — `clamp-ring.sldprt` (Variant A tensioning hoop)

1. Sketch 1 — annulus, OD `CLAMP_RING_OD = 870 mm`, ID 770 mm
2. Extruded sheet body — 4 mm thickness
3. 6 hole pattern at PCD = `HEAD_OD + LUG_PCD_OFFSET * 2 = 850 mm`, Ø11 mm clearance for M10 bolts
4. Flat-pattern config — laser-cut from 4 mm plate (not formed; flat ring)

### Part 4 — `lug-bracket.sldprt` (Variant A tension bracket)

1. Sketch — L-bracket profile: 40 × 80 mm with a 30 × 40 mm vertical leg
2. Extruded sheet body — 3 mm thickness
3. Single Ø11 mm bolt-clearance hole in vertical leg, centered
4. 6× welded to outside of frame at 60° spacing, `45 mm` below the bearing edge

### Assembly — `bass-surface-drum-asm.sldasm`

Mate sequence:
1. `frame-cylinder` fixed
2. `internal-doubler` mated to inside of frame seam
3. 6× `lug-bracket` patterned around frame at 60° using global axis
4. `clamp-ring` floated above frame (will rest on head)
5. Head (purchased) modelled as a simple surface for visualization only — not part of the build

## Configurations

- `frame-cylinder` part has two configs:
  - `formed` (3D rolled cylinder with bends)
  - `flat-pattern` (DXF export)
- `clamp-ring` part has one config (laser-cut flat).
- Drum assembly has two configs: `Variant-A-clamp-ring` and `Variant-B-rope-laced` (Variant B uses a flesh-hoop + counter-hoop instead of clamp ring; documented but not modelled for V0).

## Equations

```text
"DevelopedLength" = pi * ("HEAD_OD" - "FRAME_THICKNESS")
"ClampRingOD" = "HEAD_OD" + 70
"LugPCD" = "HEAD_OD" + 50
"LugAngularSpacing" = 360 / "LUG_COUNT"
```

## DXF Export Plan

| Source Part           | DXF File                    | Layers              | Units |
|----------------------|----------------------------|---------------------|-------|
| `frame-cylinder` flat | `drawings/frame-flat.dxf`  | CUT, BENDS, ETCH    | mm    |
| `internal-doubler`    | `drawings/doubler-flat.dxf`| CUT                 | mm    |
| `clamp-ring`          | `drawings/clamp-ring.dxf`  | CUT, ETCH           | mm    |
| `lug-bracket`         | `drawings/lug-bracket.dxf` | CUT, BENDS          | mm    |

## Without a SolidWorks Seat

If the fabricator does not have SolidWorks:
- The frame flat is a simple rectangle 2513 × 120 mm with two long-edge bends — can be drawn directly in LibreCAD or even by hand on the sheet
- The clamp ring is a flat annulus 870 OD / 770 ID — straightforward CAM
- Both can be procured as laser-cut parts from a service bureau using just dimensioned sketches; full SolidWorks geometry is optional for V0

See `flat-pattern-checklist.md` for the layered DXF spec and `cnc/setup-sheet.md` for the nesting plan.
