<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Assembly Manual — Bass Surface Drum

The frame must be fully fabricated, painted, and cured (see `fabrication-plan.md`) before starting this manual. Allow 24 h between final paint and head mount.

## What you have at the start

- 1 finished frame (rolled cylinder, bearing flange + stiffening bead + 6 lug brackets, painted)
- 1 clamp ring (4 mm CRS annulus, edge-broken, painted)
- 6 M10 × 35 mm bolts, 12 washers, 6 nylon-insert locknuts
- 1 thick steerhide head blank (1.5–2 mm × 1000 mm round, **raw, untrimmed**)
- 1 soft cinematic mallet (bought)

## Tooling

- Bucket of clean cool water, big enough to soak the head blank
- Clean cloths (3–4 large)
- Tape measure, sharpie, scissors (large)
- 17 mm box wrench × 2
- Torque wrench reading 5–25 Nm (optional but recommended)

## Head Preparation (V0 — steerhide, Variant A clamp ring)

### Step 1 — Soak (1–2 hours)

1. Place the steerhide blank in the bucket of cool water. **Hair side up if hair is still on; flesh side up if it's been dressed.**
2. Soak for 1 hour. The hide should be supple but not floppy — it should remember its shape when you fold it.
3. Remove and lay flat on a clean towel. Pat off excess water but leave the surface moist.

### Step 2 — Mark the center (5 minutes)

1. Find the center of the hide visually (the geometric center, not the center of any markings).
2. Mark a 5 mm dot with a sharpie at the center.
3. Draw a faint guide circle at 920 mm diameter centered on the dot (this is the trim line — do not cut yet).

### Step 3 — Position on frame

1. Lay the frame on the floor, bearing flange up.
2. Place the hide centered over the frame, sharpie dot aligned with the visual center of the frame opening.
3. Smooth the hide so it drapes naturally around the bearing flange, with about 60 mm of overhang past the flange on all sides.

### Step 4 — Install clamp ring

1. Lower the clamp ring over the frame and head, aligning bolt holes with lug brackets.
2. Insert all 6 bolts from above with one washer each.
3. From below, install washer + locknut on each bolt. **Finger-tight only at this stage.**

### Step 5 — First-pass tension (star pattern)

Star-pattern order for 6 bolts (numbered clockwise from a reference point):

```text
1 → 4 → 2 → 5 → 3 → 6
```

1. Pass 1: turn each bolt in star order 1 full turn past finger-tight.
2. Pass 2: another 1 full turn each, star order.
3. **Stop**. Look at the hide: it should be evenly snug, with the bearing flange visibly indenting it but no pucker or wrinkle.

### Step 6 — Wait (12 hours)

Walk away. The hide will continue to take its set against the bearing flange. Do not over-tighten — the hide is wetter and weaker now than it will be in 24 h.

### Step 7 — Second-pass tension

1. After 12 h, return. Star-order another 1/2 turn each bolt.
2. Tap the center with the mallet. Listen — you should hear a low boom even if it sounds dead and pitchless still. The pitch will rise as it dries.
3. Wait another 12 h.

### Step 8 — Tune to band

1. With the head approaching dry: tap center, measure with phone tuner.
2. Add 1/8 turn each bolt in star order if pitch is below 42 Hz.
3. Loosen 1/8 turn each bolt in star order if pitch is above 60 Hz.
4. Repeat until the fundamental sits in [42, 60] Hz comfortably with the band centered around 50 Hz.

Target torque on the final bolt: roughly **15–18 Nm**. Track the torque on the most-recently-tuned bolt so the next re-head can re-establish the same state.

### Step 9 — Trim overhang

Once the head is tuned and stable for 24 h:

1. With sharp scissors, trim the head overhang to leave 8 mm of margin past the clamp ring.
2. Inspect for any flesh-side roughness; sand lightly with 220-grit if there are loose fibers.
3. Apply a light coat of leather conditioner (Aussie or similar) only to the **flesh side** (the visible underside through the frame). Never condition the strike face — it must remain dry.

## Variant B (Rope-Laced Flesh-Hoop) — Brief

For makers who want the traditional rope-laced aesthetic:

1. Replace clamp ring with a 3 mm CRS flesh-hoop (separate part, OD 920 mm / ID 800 mm).
2. Add a 4 mm CRS counter-hoop below the frame.
3. Drill 16 evenly-spaced holes around both hoops for rope lacing.
4. Lace 8 mm nylon rope in a W-pattern: up through the counter-hoop, over the frame, into the flesh-hoop, back down to the counter-hoop, etc.
5. Tune by pulling slack out of the W-pattern at each lacing point, then locking with friction knots.

Variant B is more theatrical and produces a very similar acoustic result, with one tradeoff: the W-laces introduce small azimuthal tension variation that slightly damps the (1,1) and (2,1) modes.

## Acceptance check (final)

- [ ] Fundamental measured: ___ Hz (must be in [42, 60])
- [ ] Off-center strike produces a clear two-tone transient with the second peak around 1.6× the fundamental
- [ ] Head is taut everywhere — no flat spots when pressed by hand
- [ ] All bolts/locknuts tight (no rattle when frame is shaken upside down)
- [ ] No visible head cracking, hair pulling, or seam splitting
- [ ] Bearing flange contact is uniform around the rim — no gaps

If any acceptance check fails: stop, document in `validation.csv` with notes, and consult `risks.md` for the failure-mode map.

## Re-heading at end of head life

Steerhide bass heads typically last 5–10 years of moderate use. Signs to re-head: pitch drift outside acceptance band even at full tension, visible cracking, dead spots.

To re-head: loosen all bolts, lift the clamp ring, peel the old head, soak a new blank, repeat from Step 2.
