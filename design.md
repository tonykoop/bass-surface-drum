<!-- SPDX-License-Identifier: CC-BY-4.0 -->
---
slug: bass-surface-drum
display_name: Bass Surface Drum
family: drum
subfamily: frame-drum
acoustic_class: single-membrane-low-tension
target_tuning:
  fundamental_hz: 50
  acceptance_band_hz: [42, 60]
  partials_strategy: bessel-circular-membrane-modes
geometry:
  head_outside_diameter_mm: 800
  head_effective_diameter_mm: 760
  frame_depth_mm: 120
  frame_wall_thickness_mm: 1.5
  rim_bearing_radius_mm: 4
ergonomic_envelope:
  player_position: seated or stand-mounted
  mallet: large soft cinematic mallet (bought)
  strike_zone: center for fundamental, off-center for higher modes
license:
  hardware: CERN-OHL-W-2.0
  docs: CC-BY-4.0
---

# Bass Surface Drum — Design

## Design Thesis

A very large, single-head frame drum with a **rolled sheet-metal frame** instead of the traditional bent-wood hoop. The membrane is a thick natural-skin head, tuned to a sub-bass acceptance band centered at 50 Hz (~G1) for cinematic boom and slow processional pulse. The instrument is read by a film/score composer as "the deep boom you feel in your chest"; it is played with a single soft mallet, struck near center for the fundamental and off-center to excite the (1,1) and (2,1) Bessel modes for a more complex transient.

The sheet-metal frame replaces wood for three reasons: (1) at 800 mm OD, steam-bent wood hoops of the required cross section are expensive and warp-prone; (2) a rolled steel hoop holds true-round to a tighter tolerance than wood, which keeps the head bearing edge flat and the tuning even around the circumference; (3) the steel hoop can be flanged out at the head edge to form a precise bearing radius integral to the frame, eliminating a separate wood bearing-edge fabrication step.

## Family Position

This is a *single-pitch sub-bass* member of the frame-drum family. Related instruments in this sprint round and elsewhere in the catalog:

- `bowed-frame-drum` — mid-pitch frame drum (~450 mm OD) with internal tone bar
- `tunable-snare-frame-array` — three small chromatic frame drums on a stand
- `sheet-metal-talking-drum` — pressure-tuned hourglass two-head drum
- `dundun` (instrument-builds wiki) — membrane shell studies with measured strike/pitch comparisons

The bass-surface-drum is intentionally low-pitch, single-head, and low-tension. It does not compete with the higher-pitch frame drums; it sits below them and adds a foundational pulse.

## Acoustic Model

The membrane is modeled as an **ideal circular membrane under uniform tension**. The transverse modes are indexed by `(m, n)` where `m` is the number of nodal diameters and `n` is the number of nodal circles. Frequencies are:

```text
f_mn = (α_mn / (2 π a)) * sqrt(T / σ)
```

where:

- `a` — effective membrane radius (m). For an 800 mm OD frame with the head clamped just inside the rim, `a ≈ 0.380 m`.
- `T` — tension per unit length at the rim (N/m).
- `σ` — surface mass density of the membrane (kg/m²).
- `α_mn` — the nth positive root of the Bessel function J_m. The relevant low-order roots:

| Mode | α_mn  | Ratio to f_01 |
|------|-------|---------------|
| (0,1) | 2.4048 | 1.000 |
| (1,1) | 3.8317 | 1.593 |
| (2,1) | 5.1356 | 2.135 |
| (0,2) | 5.5201 | 2.295 |
| (3,1) | 6.3802 | 2.653 |
| (1,2) | 7.0156 | 2.917 |

For a target `f_01 = 50 Hz` with `σ = 1.20 kg/m²` (thick natural skin, ~1.5 mm × 800 kg/m³ effective wet-density baseline) and `a = 0.380 m`:

```text
T = σ * (2 π a f_01 / α_01)^2
T = 1.20 * (2 π * 0.380 * 50 / 2.4048)^2
T ≈ 2960 N/m
```

That is `~16.9 N per mm` of rim circumference — moderate tension, comfortably below the failure load of a properly prepared 1.5–2.0 mm steerhide head. Total radial pull on the frame is:

```text
F_total ≈ T * 2 π a ≈ 7064 N (≈ 1590 lbf)
```

The frame must resist this without ovalizing more than ~0.5 mm out-of-round (a working ovalization budget — see `risks.md` for measurement protocol).

## Tuning Strategy

This drum is tuned by **head selection plus single global tension adjustment**, not by per-lug tuning. The tension is set once per head, then the head is allowed to relax for 24 h before measurement.

Three tuning levers, in order of authority:

1. **Head surface density `σ`** — set by skin choice. Cowhide, elk, water-buffalo, donkey, and synthetic Remo-style heads each occupy a different `σ` band.
2. **Effective tension `T`** — set by the tensioning mechanism (rope, bolt-and-bracket, or hoop lugs — see `tuning-notes.md`).
3. **Effective radius `a`** — set by frame geometry; nominally fixed at fabrication time but can shift slightly with re-clamping.

The acceptance band `[42, 60] Hz` is wide because (a) skin properties vary batch-to-batch by ±20%, (b) humidity shifts pitch by ~5%, (c) the goal is "deep boom that fills a room," not a precise musical pitch.

## Frame Mechanics

The frame is a **rolled 1.5 mm cold-rolled steel cylinder**, 800 mm OD, 120 mm deep, with two integral rolled-edge features:

- **Head bearing edge (top)**: the top edge of the frame is flanged outward into a smooth 4 mm radius, forming the bearing surface the head sits against. This is rolled in the same operation as the frame, on a slip-roll with a profile shoe.
- **Stiffening bead (bottom)**: a 6 mm rolled-in convex bead at the bottom edge provides anti-ovalization stiffness without adding weight or a separate hoop ring.

The frame seam is a **butt + TIG weld** running vertically through one location on the cylinder. The weld is dressed flush externally and internally; a 50 mm-wide doubler strip is spot-welded on the inside across the seam to hand back stiffness lost at the weld and to take the local pull from the seam's bearing edge.

Total radial pull `F_total ≈ 7064 N` is resisted by hoop stress in the frame. Hoop stress is:

```text
σ_hoop = F_total / (2 π a t) — incorrect for a thin shell loaded uniformly at one edge
```

That equation is the closed-form pressure-vessel hoop stress and is not the right one here. For a shell loaded by a uniform radial line load at one edge, the correct deflection/stress model is the **circular ring bending** problem — see `wolfram-starter.wl` for the calibrated calculation. Sanity check: a rolled 1.5 mm steel hoop with a stiffening bead is empirically used for sub-bass concert bass drums of similar diameter; this design uses thicker stock and a deeper section than a typical 14"–18" snare hoop, so the structural envelope is conservative.

## Head Selection (V0)

V0 prototype head: **thick raw steerhide, hand-prepared, wet-mounted then lap-tensioned dry**.

- Source: bought from a hide-prep supplier (see `sourcing.csv`)
- Diameter: 1000 mm hide blank, trimmed to 920 mm post-mount
- Effective surface density: 1.0 – 1.5 kg/m² depending on hydration and final-tension state
- Mounting style: clamp ring (option A) OR rope-laced flesh-hoop (option B) — both documented in `assembly-manual.md` for cost/sound A/B

## Tensioning System

Two variants, choose at build time:

- **Variant A — clamp ring** (recommended, lower part count): a separate rolled 4 mm steel clamp ring sits over the wet head; six M10 tension bolts pull the clamp ring down toward six brackets welded to the outside of the frame. Bolts are torqued in a star pattern; tension is even by construction.
- **Variant B — rope-laced flesh-hoop** (traditional, more parts, more theater): the head is folded over a steel flesh-hoop ring just inside the frame; nylon rope laces between the flesh-hoop and a second counter-hoop below the frame in W-pattern. Pulling and re-tying the W-laces tunes the drum.

Variant A is the default; variant B is documented for makers who want the traditional rope aesthetic.

## Off-Center Strike Modes

When struck off-center (about 1/3 of the way from rim to center), the (1,1) Bessel mode is excited and the drum produces a transient with two predicted frequencies:

```text
f_01 ≈ 50 Hz   (fundamental, sustained)
f_11 ≈ 80 Hz   (first overtone, decays faster)
```

The 50/80 Hz pair is musically a **major sixth** (50 → 80 is exactly 8:5, or 1.6×). This is not arbitrary; it falls out of the Bessel root ratios and is part of why frame drums sound the way they do.

## What This Packet Does Not Decide

- Final head material (V0 is steerhide; V1 candidates include water-buffalo and synthetic Remo Ambassador-style 14-mil bass head)
- Exact lug bracket weld geometry (welded vs. through-bolted vs. clinched-from-inside)
- Final hammered/raised surface texture of the frame outer face (cosmetic; optional)
- Stand vs. floor-rest mounting hardware (left to the makerspace skill in a follow-up packet)

## References Used (qmd citations)

- `instrument-builds/docs/textbook/appendix/family-spec-csv.md` — frame-drum family parameters
- `instrument-builds/docs/textbook/chapters/03-instrument-families.md` — drum-family taxonomy
- `instrument-wiki/synthesis/wolfram-model-patterns.md` — "Membrane and shell studies" pattern for `frame-drum`/`dundun`-class instruments
- `handpan/design.md` and `handpan/wolfram-starter.wl` — template for parametric design + Wolfram model pairing

See `agent-record.md` for full citation list and queries run.
