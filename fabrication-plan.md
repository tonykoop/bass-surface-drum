<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Fabrication Plan — Bass Surface Drum

Sequence is: **cut → form → join → finish → inspect**, then head-mount as a separate phase covered in `assembly-manual.md`.

## 1. Cut

### 1.1 Frame blank
- Stock: CRS sheet 1.5 mm, 2600 × 150 mm.
- Tool: shear OR fiber laser.
- Output: a rectangle 2513 × 120 mm with **tab/slot pairs on the two short edges**:
  - Right edge: 4 tabs, each 6 × 10 mm, at 20/40/60/80% of depth
  - Left edge: 4 slots, each 6.5 × 11 mm, at matching positions
- Mark grain direction on the blank with chalk. Bends will run perpendicular to grain.

### 1.2 Clamp ring blank
- Stock: CRS plate 4 mm, 900 × 900 mm.
- Tool: fiber laser or plasma.
- Output: annulus OD 870 / ID 770 mm with 6× Ø11 mm holes on PCD 850 mm, plus one etched index notch on the OD.

### 1.3 Lug-bracket blanks
- Stock: CRS sheet 3 mm, 500 × 250 mm.
- Tool: fiber laser or plasma.
- Output: 6× L-bracket flats, each 80 × 70 mm with one Ø11 mm hole.

### 1.4 Doubler blank
- Stock: frame offcut.
- Tool: shear.
- Output: rectangle 50 × 120 mm.

**Deburr everything** before forming. Hand-file or Roloc-disk all cut edges; a slightly rounded edge resists crack initiation during the cylinder roll.

## 2. Form

### 2.1 Top-edge bearing flange (frame)
- Tool: press brake, 4 mm radius punch + matching die.
- Operation: 90° outward bend along the entire 2513 mm length, holding flange height to 8 mm.
- Springback compensation: overbend by 2°.
- **Coupon test first**: bend a 100 × 100 mm scrap to confirm no outside-fiber cracking. If cracks appear, increase radius to 6 mm or anneal locally with a propane torch.

### 2.2 Bottom-edge stiffening bead (frame)
- Tool: bead roller with 6 mm round die.
- Operation: 3 passes along the bottom 2513 mm edge, advancing the die ~1 mm per pass to reach final 3 mm depth.
- Inspect every pass: the strip must not buckle out of plane. If it starts to buckle, back off the die advance and add a pass.

### 2.3 Roll-up to cylinder (frame)
- Tool: slip roll, minimum forming radius ≤ 400 mm.
- Operation: 3 passes. After each pass measure the diameter at 6 points around the cylinder (0/60/120/180/240/300°). Adjust pinch until OD is 800 ± 1 mm and out-of-round < 1.5 mm.
- The bearing flange faces outward; the stiffening bead is at the bottom.

### 2.4 Bend lug brackets
- Tool: press brake, 3 mm radius punch + die.
- Operation: 90° bend at 40 mm from the horizontal datum on each of the 6 flats.

## 3. Join

### 3.1 Frame seam
- Interlock the tabs and slots; the cylinder should be self-jigging at the seam.
- TIG-weld the butt seam with ER70S-2 filler, ~60 A on 1.5 mm CRS.
- Back-purge if available (reduces oxide ("sugar") on the inside surface).
- Dress the outside weld flush with a grinder + Roloc disk. The inside need only be smoothed, not flushed.
- **Coupon test first**: weld a butt joint between two scrap strips and bend it 180° around a mandrel. If the weld cracks, adjust filler/heat input.

### 3.2 Internal doubler
- Position the 50 × 120 mm doubler **inside** the frame, centered over the seam.
- Spot-weld at 6 points in a 2 × 3 grid:
  - Columns at 25% and 75% of doubler width
  - Rows at 20%, 50%, 80% of doubler depth
- If no spot welder, drill 6× Ø5 mm through both doubler and frame, install M5 button-head countersunk fasteners from outside, nuts inside.

### 3.3 Lug brackets
- Jig 6 brackets around the frame at 60° spacing, with the vertical leg's bolt hole 45 mm below the bearing flange.
- Jig from a scrap plywood disk with 6 wedges; clamp brackets to wedges before tacking.
- Tack-weld first, check spacing with a tape, then full fillet weld each bracket-frame contact.

## 4. Finish

- Hand-deburr all sharp edges; the bearing flange must be smooth — the head will sit on it.
- Wire-wheel any weld discoloration.
- Wipe entire frame with acetone or denatured alcohol.
- Spray 2 coats of matte black enamel; flash-dry 30 min between coats; full cure 24 h.

## 5. Inspect (acceptance before head mount)

- [ ] Frame OD: 800 ± 1.0 mm (measure 6 places)
- [ ] Out-of-round: < 1.5 mm
- [ ] Bearing flange radius: 4 ± 0.5 mm (gauge with a radius card)
- [ ] Stiffening bead depth: ≥ 3 mm (measure with a depth gauge or feeler)
- [ ] Frame seam weld: dye-penetrant or visual; no visible cracks
- [ ] All 6 lug brackets: bolt-hole centers within ± 1 mm of designed PCD
- [ ] Doubler: 6 attachment points, no loose corners
- [ ] No sharp edges anywhere on the bearing flange (run a gloved hand around the inside and outside top edge)

## Tool Substitution Table

| Missing tool          | Substitute                                                          |
|-----------------------|---------------------------------------------------------------------|
| Fiber laser           | Plasma cutter (rougher edge — needs more deburring) or band saw     |
| Slip roll             | Roll-on-a-jig: clamp blank to a 400-mm pipe and roll by hand (slow) |
| Press brake (4 mm R)  | Hand-rolled flange with a forming mandrel (slow, less consistent)   |
| Bead roller           | Skip the bead; add a second internal doubler ring instead (heavier) |
| Spot welder           | M5 button-head bolts (see §3.2)                                     |
| TIG welder            | MIG with .024 wire and short bursts (less clean, but works on CRS)  |

## Safety call-outs

- **Pinch hazards** on slip roll, press brake, and bead roller. Two-person operation for the 2600 mm frame blank.
- **TIG arc + UV**: full PPE. The frame seam is a continuous 120 mm weld; rest hand every 30 mm to avoid arc-time-induced spatter.
- **Paint cure**: VOC ventilation. 24 h cure in a clean space before any contact with the bearing flange.

## What this plan does *not* cover

- Head preparation (wet-mount, lap-tension, trim) — see `assembly-manual.md`.
- Final tuning — see `tuning-notes.md`.
- Stand/floor-rest hardware — deferred to a follow-up packet from the makerspace skill.
