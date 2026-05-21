<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# CNC Setup Sheet — Bass Surface Drum

## Tools assumed

- **Plasma or fiber laser** for the clamp ring (4 mm plate) and lug brackets (3 mm sheet)
- **Slip roll** with 400 mm minimum forming radius for the frame cylinder
- **Press brake** with 4 mm-radius punch+die for the top-edge bearing flange
- **Bead roller** with 6 mm round bead die for the bottom-edge stiffening bead
- **TIG welder** with argon shielding, ER70S-2 filler
- **Spot welder** OR M5 button-head + countersunk holes for the internal doubler attachment

If any of those tools is unavailable, see `../fabrication-plan.md` for the substitution table.

## Operations summary

| Op | Part           | Machine     | Setup            | Cycle (est.) |
|----|---------------|-------------|------------------|--------------|
| 1  | frame-flat     | shear or laser | one cut from 2600×150 stock | 2 min |
| 2  | clamp-ring     | laser/plasma | nested at center of 900×900 plate | 8 min |
| 3  | lug-bracket × 6| laser/plasma | nested on 500×250 sheet | 6 min |
| 4  | doubler        | shear        | offcut from frame stock | 1 min |
| 5  | frame top flange | press brake | 4 mm radius punch + die | 4 min |
| 6  | frame bottom bead | bead roller | 6 mm round die, 3 passes | 6 min |
| 7  | frame roll-up  | slip roll    | 3 passes; check round at each | 20 min |
| 8  | frame seam weld | TIG bench    | tabs interlocked first, then full pass | 15 min |
| 9  | doubler attach | spot welder  | 6 spots | 2 min |
| 10 | lug-bracket bend × 6 | press brake | 3 mm radius punch + die | 6 min |
| 11 | lug-bracket weld × 6 | TIG | jig to frame at 60° spacing | 30 min |
| 12 | clamp-ring deburr | by hand | edge break + corner break | 5 min |
| 13 | final deburr + paint | hand + spray | matte black enamel | 30 min |

Total shop time: ~2.5 hours plus paint cure.

## Nesting plan

See `operations.csv` for tool-by-tool nesting. The plan minimizes machine changeovers by grouping all plasma/laser cuts first, then all press-brake bends, then all roll operations, then welding.

## Tolerances

- Frame OD after roll: **800 mm ± 1.0 mm**, out-of-round < 1.5 mm. Tighter is better — the more circumferentially-even the rim, the more even the head tension.
- Bearing flange radius: **4 mm ± 0.5 mm**.
- Stiffening bead depth: **3 mm minimum** (must be visible from inside the frame).
- Bolt-hole position on clamp ring: **PCD ± 0.5 mm**, hole-to-hole angular ± 0.5°.
- Lug bracket bolt-hole position on frame: ± 1 mm acceptable (the M10 clearance hole absorbs small misalignments).

## Safety

- Slip-roll: pinch hazard. Two operators for a 2600 mm blank; the trailing edge must be supported on a roller stand.
- TIG arc: standard arc-weld PPE. The frame seam is a long-pass weld; consider a back-purge to reduce sugaring on the inside.
- Bead roller: hand-pinch hazard. Use push sticks for the last 100 mm.
- Heavy lifting: a finished frame weighs ~4 kg; the clamp ring ~14 kg of 4 mm plate. Two-person lift recommended for the clamp ring.
