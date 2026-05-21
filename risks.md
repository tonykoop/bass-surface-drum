<!-- SPDX-License-Identifier: CC-BY-4.0 -->
# Risk Register — Bass Surface Drum

## Safety

| Risk | Likelihood | Severity | Mitigation |
|---|---|---|---|
| TIG arc burn / UV exposure during 2513 mm seam weld | medium | medium | Full PPE, rest hands every 30 mm, attempt back-purge to reduce sugaring |
| Slip-roll pinch on 2600 mm blank | medium | high | Two-person operation, roller stand for trailing edge |
| Bead-roller hand pinch on final pass | low | medium | Push sticks for last 100 mm |
| Clamp ring drop (14 kg 4 mm plate) | medium | medium | Two-person lift, gloves, protect bearing flange |
| Sharp edges on un-deburred frame blank | high | low | Deburr after every cut before forming |
| Paint VOC exposure during cure | medium | medium | Ventilated cure space, 24 h before any contact |
| M10 bolt under tension snapping during tuning | low | high | Grade 8.8 minimum; replace any bolt that has been over-torqued past 25 Nm |

## Ergonomic

| Risk | Likelihood | Severity | Mitigation |
|---|---|---|---|
| Drum too heavy to carry one-handed | high | low | This is a stage/floor instrument; document carrying with a strap or two-person carry |
| Mallet causes hand fatigue | low | low | Bought mallets have well-known handles; not a fabrication concern |
| Player strikes the bearing flange and dents head | medium | low | Strike zone is at least 100 mm inside the flange; document in `assembly-manual.md` |

## Manufacturability

| Risk | Likelihood | Severity | Mitigation |
|---|---|---|---|
| 4 mm bearing-flange radius cracks CRS at the bend | medium | medium | Coupon test before production; fallback to 6 mm radius or local anneal |
| Cylinder rolls oval instead of round | medium | high | Multi-pass rolling, measure at 6 points every pass, jig if needed |
| Seam weld craters at start/stop | medium | medium | Use TIG runoff tabs (extra material before and after the seam) |
| Stiffening bead doesn't reach 3 mm depth | medium | high | Add 4th pass if needed; if still shallow, add a separate welded-in ring |
| Doubler doesn't lay flat against inside of curved frame | medium | low | Pre-roll the doubler to roughly match frame ID before spot-welding |
| Lug-bracket PCD drifts off true | medium | medium | Use a jig — wood disk with 6 wedges glued at 60° spacing |

## Acoustic-failure modes

| Risk | Likelihood | Severity | Mitigation |
|---|---|---|---|
| Fundamental lands above 60 Hz (too tight) | medium | low | Loosen in star pattern; if still high, swap to heavier σ head |
| Fundamental lands below 42 Hz (too loose) | medium | low | Tighten in star pattern; if still low, swap to lighter σ head or smaller diameter |
| Off-center strike does not excite (1,1) cleanly | low | medium | Re-tension head evenly; check for one-lug-overtightened condition |
| Azimuthal pitch varies > 1 Hz around rim | medium | medium | This means head tension is uneven — full re-tension start over from finger-tight |
| Bearing flange contact is uneven | medium | high | Frame is out of round; this requires re-rolling or a new frame |
| Head develops dead spot over time | low | medium | Hide may be drying unevenly; condition flesh side only, not strike face |
| Hide cracks at first full-tension state | low | high | Hide was over-tensioned while wet; release immediately, dry slowly, retry with new hide |
| Cinematic mallet too hard, produces high-frequency artifact | low | low | Choose softer mallet (felt vs. wool); the bought mallet matters |

## Supply

| Risk | Likelihood | Severity | Mitigation |
|---|---|---|---|
| Hide supplier out of stock for thick steerhide | medium | medium | Document synthetic Remo bass head as fallback; will shift acceptance band slightly |
| CRS sheet from service center delivered out of spec | low | medium | Measure incoming and reject if outside +/- 5% on thickness |
| Laser-cut clamp ring delivered with rough kerf | medium | low | Specify "deburred" in RFQ; if not deburred, hand-deburr before paint |

## IP / Release

| Risk | Likelihood | Severity | Mitigation |
|---|---|---|---|
| Dual license confusion downstream | low | low | LICENSE pointer file + per-file SPDX headers (this packet follows that) |
| Hide sourcing flagged as ethical concern | medium | low | Document supplier provenance; offer synthetic-head alternative as default for ethically-concerned makers |

## Release Gates

The packet remains **private** until each of these is cleared:

- [ ] Human frame-drum player review (someone who has played 800 mm-class frame drums)
- [ ] Metal-forming safety/process review by shop lead
- [ ] Supplier/IP/public-release review
- [ ] Measured V0 prototype validation data exists in `validation.csv`
- [ ] At least one capstone photo set has been shot per `photo-shotlist.md`

## Sandbox / Manager notes

This packet was authored in a Claude sprint pane. The repo was successfully `gh repo create`d as `tonykoop/bass-surface-drum` and pushed; subsequent commits go through gh PR + squash-merge cycles. No sandbox-DNS blockage was hit for this lane.
