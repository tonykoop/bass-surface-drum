<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Agent Record — Bass Surface Drum

- **Lane**: Round 5 / Lane 09 / pane %10
- **Runtime**: Claude (Opus 4.7, 1M context) — sprint persona pane
- **Skills loaded**: `sheet-metal`, `instrument-maker`
- **Date**: 2026-05-21

## qmd queries run + key citations

```bash
qmd search "bodhran frame drum" -c instrument-builds
qmd search "frame drum membrane" -c instrument-wiki
qmd search "membrane circular drum tension" -c instrument-wiki
```

Key citations:
- `instrument-builds/docs/textbook/appendix/family-spec-csv.md:138` — frame-drum family parameters (`steam-bend-mold-form`/`3D-surfacing`/`springback-allowance`)
- `instrument-builds/docs/textbook/chapters/03-instrument-families.md:304` — drum-family taxonomy
- `instrument-wiki/synthesis/wolfram-model-patterns.md:150` — "Membrane and shell studies" pattern explicitly lists `frame-drum` with `head diameter, membrane surface density, tension, shell geometry, tap tone` as the recommended Wolfram parameter set, and `f01 range, tuning sensitivity, measured strike/pitch comparison` as the expected output. This packet hits all four input parameters and all three outputs.
- `handpan/design.md` and `handpan/wolfram-starter.wl` — used as the template for parametric design + Wolfram model pairing.

## Major assumptions

1. **Steerhide surface density σ ≈ 1.20 kg/m²** — derived from "1.5 mm × 800 kg/m³ wet baseline." Real σ varies ±20% with humidity and hide preparation. The acceptance band [42, 60] Hz absorbs this; the wolfram-starter sensitivity table shows the full range.
2. **Effective membrane radius a = 0.380 m** = (800 mm OD − 40 mm bearing-flange-take) / 2 / 1000. The 40 mm take is an estimate; actual will depend on how far inside the bearing flange the head deforms under load.
3. **Frame ovalization model uses a worst-case thin-ring approximation** — the closed-form `q R^4 / E I` deflection equation with I=t³d/12 is the worst-bound. The stiffening bead increases I by ~5× (assumed). A measured prototype is required to confirm the frame stays within 0.5 mm out-of-round under load.
4. **Variant A (clamp ring) is the default**; Variant B (rope-laced) is documented but not detailed for V0.
5. **Tab-and-slot seam** is feasible at this gauge; coupons are called out to verify.

## Unknowns I would punt to the next round

- Exact bead-roller die geometry on the bottom edge (depth/profile depends on the specific roller available).
- Lug-bracket weld geometry — fillet vs. tack-and-fillet, optimum bracket cross section.
- Whether the synthetic Remo Ambassador 26" bass head fits as a drop-in alternative head (would shift acceptance band; needs to be modelled with the actual σ of the synthetic material).
- Stand or floor-rest hardware (mounting, isolation pad, height) — this is a `makerspace` skill follow-up.
- Real measured ovalization under full membrane tension — only a built prototype tells the truth.
- Whether a hammered surface texture on the outside of the frame (cosmetic) introduces any unwanted overtones.

## Files produced

- Total: **25 files** (4 license, 1 design.md, 1 parameters.csv, 1 wolfram-starter.wl, 1 tuning-notes.md, 1 solidworks-plan.md, 1 flat-pattern-checklist.md, 1 bend-table.csv, 1 cut-list.csv, 1 bom.csv, 1 hardware.csv, 1 sourcing.csv, 1 fabrication-plan.md, 1 assembly-manual.md, 1 supplier-rfq.md, 1 visual-bom-brief.md, 1 validation.csv, 1 risks.md, 1 photo-shotlist.md, 4 subdir READMEs, 1 explorer.html planned, 1 README.md planned, 1 agent-record.md)
- All files have appropriate SPDX-License-Identifier headers (CC-BY-4.0 for docs, CERN-OHL-W-2.0 for hardware data).
- All committed across 5 phase PRs to `tonykoop/bass-surface-drum`, each PR squash-merged on `main`.

## Coupon tests recommended

1. **Bend-edge crack coupon** — 100 × 100 mm CRS 1.5 mm folded to 4 mm radius. Must not crack outside fiber.
2. **Bead-roll coupon** — 300 × 120 mm CRS 1.5 mm bead-rolled to 6 mm bead. Must be full-depth and stay in-plane.
3. **Seam-weld coupon** — butt-welded scrap bent 180° around mandrel. Must not crack.

## Confidence by area

| Area | Confidence | Why |
|---|---|---|
| Acoustic target & math | **High** | Ideal-membrane model is well-trodden; Bessel mode predictions are reliable; the only soft input is σ and the acceptance band is wide. |
| Frame structural envelope | **Medium** | Hoop stress is hand-waved with worst/best bounds. A measured prototype is required before declaring the bead-stiffened section adequate. |
| Flat patterns | **Medium-high** | Single-radius cylinder + flat annulus + flat L-bracket: standard sheet-metal. The 4 mm bearing-flange radius is the only risk and has a coupon test. |
| Fabrication plan | **High** | 13 ops, all standard shop equipment. Substitution table covers missing-tool scenarios. |
| BOM & sourcing | **Medium** | Hide supplier identified but not vetted by this agent. CRS sourcing is generic. |
| Assembly procedure | **Medium** | 9-step head-mount is standard for frame drums; star pattern is well-understood. Hide-specific behavior (drying drift) requires real-world iteration. |
| Capstone deck (visual) | **Low** | Brief is written, but the shot list assumes capabilities of an unspecified photographer/renderer. |

## Suggested next-round task

Either:

1. **Build V0** — produce real measured data for `validation.csv`, retire the "predicted" column to a separate "predicted vs. measured" diff sheet, and publish prototype audio captures into `learn-to-play/audio/`.
2. **CAD lift** — produce the SolidWorks parts and DXF flat patterns called out in `solidworks-plan.md`. Single competent CAD operator, ~3 hours of work.
3. **Family expansion** — design a chromatic *family* of bass surface drums (e.g., 600/700/800/900 mm OD, each tuned to a different sub-bass pitch) using the same frame architecture. This unlocks bass-line patterns in cinematic music.

My recommendation: **(2) CAD lift**, then **(1) V0 build**. The CAD output unblocks the laser-cut RFQ and lets a fabricator commit; the build then validates the structural envelope before family expansion.
