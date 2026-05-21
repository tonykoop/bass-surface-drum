<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Tuning Notes — Bass Surface Drum

## Target

Fundamental `f_01 ≈ 50 Hz` (G1, 49.0 Hz). Acceptance band `[42, 60] Hz`. This is a *room-filling sub-bass* target — not a precise musical pitch.

## Tuning Levers (in order of authority)

1. **Head choice (σ)** — surface mass density. Sets the *band*.
2. **Tension (T)** — total rim load. Sets the *pitch within the band*.
3. **Radius (a)** — fixed at fabrication.

## Method

This is a **single-tension drum**: there is one even tension around the rim, not lug-by-lug independent tension. With Variant A (clamp ring), the six M10 bolts are tightened in a star pattern in **three passes**:

- Pass 1: hand-tight, then 1/4 turn each, star order
- Rest 10 min
- Pass 2: 1/4 turn each, star order
- Rest 10 min
- Pass 3: tap-tune — strike center with mallet, listen, and add 1/8 turn at a time evenly until the fundamental sits in `[42, 60] Hz`.

Use a phone tuner app or a USB mic + Sonic Visualiser for measurement; the fundamental is a clean low Hz peak.

## Sensitivity Table

| Scenario              | σ (kg/m²) | T (N/m) | Predicted f_01 (Hz) |
|-----------------------|----------:|--------:|--------------------:|
| Nominal               | 1.20      | 2960    | 50.0                |
| Dry hide, stiffer     | 0.95      | 2960    | 56.2                |
| Humid hide, heavier   | 1.45      | 2960    | 45.5                |
| Low tension, cinematic| 1.20      | 2100    | 42.1                |
| High tension, tight   | 1.20      | 4200    | 59.6                |

(See `wolfram-starter.wl` for the math.)

## Off-Center Strike

Strike about **1/3 of the radius from rim toward center** to excite (1,1) and produce the 50 Hz / ~80 Hz major-sixth transient. This is the cinematic-boom voice.

Strike center for the cleanest fundamental (least overtone content). Use this for the slow processional voice.

## Re-tuning Cadence

Frame drums of this scale shift several Hz with humidity and temperature. Plan to re-check before each performance. A 5–10% pitch swing day-to-day is normal and should not be over-corrected; the acceptance band is wide for this reason.

## What Not To Do

- Do **not** over-tighten one bolt to "fix" a side that sounds different — the head must be evenly tensioned. If one side rings differently, lower all bolts by a uniform amount and start the star pattern over.
- Do **not** keep the drum at high tension between performances; relax the tension bolts by ~10% to preserve the hide.
- Do **not** apply heat to dry the head faster — let it relax naturally over 24 h after wet-mount.

## V1 Tuning Upgrades (not in V0 packet)

- Add **calibrated tension gauge** on one bolt to lock and repeat the tuning state
- Add **multi-mic strike-response capture** for objective tuning records
- Investigate **off-center mass damping** (a small adhesive pad inside the membrane) for shifting the (1,1)/(0,1) ratio for different musical voices
