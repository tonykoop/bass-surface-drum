(* SPDX-License-Identifier: CERN-OHL-W-2.0 *)
(* Wolfram QA 2026-05-30: estimate - pending measurement, not fabrication authority.
   Variables and associations with Estimate suffix are planning values only unless
   later replaced by measured validation data or reviewed design-table authority. *)

(* Bass Surface Drum — Parametric Acoustic Model
   First-principles ideal circular-membrane model.
   Reads parameter values; predicts Bessel modes; computes rim tension and frame load. *)

ClearAll["Global`*"];

(* ============================================================
   Inputs — pull these from parameters.csv when wiring downstream
   ============================================================ *)
headEffectiveDiameterMMEstimate = 760;
membraneSurfaceDensityEstimate = 1.20;     (* kg/m^2 — thick steerhide estimate *)
targetF01Estimate = 50;                    (* Hz — target fundamental *)
frameDepthMMEstimate = 120;
frameThicknessMMEstimate = 1.5;

(* Derived: effective radius in meters *)
a = headEffectiveDiameterMMEstimate / 2 / 1000;   (* m *)

(* ============================================================
   Bessel mode ratios — circular membrane J_m roots
   ============================================================ *)
besselRoots = {
  {"(0,1)", 2.4048},
  {"(1,1)", 3.8317},
  {"(2,1)", 5.1356},
  {"(0,2)", 5.5201},
  {"(3,1)", 6.3802},
  {"(1,2)", 7.0156},
  {"(4,1)", 7.5883},
  {"(2,2)", 8.4172}
};

(* Solve for TEstimate (tension per unit length) given target f01 *)
alpha01 = besselRoots[[1, 2]];
TEstimate = membraneSurfaceDensityEstimate * (2 Pi a targetF01Estimate / alpha01)^2;   (* N/m *)

(* Predicted modal frequencies *)
modeFreq[alpha_] := (alpha / (2 Pi a)) Sqrt[TEstimate / membraneSurfaceDensityEstimate];

predictedModes = Dataset[
  AssociationThread[
      {"mode", "alpha", "freqHz", "ratioToF01"},
      {#[[1]], #[[2]], modeFreq[#[[2]]], modeFreq[#[[2]]]/targetF01Estimate}
    ] & /@ besselRoots
];

(* ============================================================
   Frame load — total radial pull on the hoop
   ============================================================ *)
totalRadialPullEstimate = TEstimate * 2 Pi a;   (* N *)

(* ============================================================
   Hoop ring-bending sanity (NOT the closed-form pressure-vessel hoop stress —
   a rolled hoop loaded by a uniform radial line load at one edge bends as
   a curved beam. The dominant question is whether ovalization stays
   within the 0.5 mm budget.

   For a thin ring of radius R, thickness t, depth d, width 1 (per the
   line load), with uniform radial inward load q (N/m):
     ovalization δ ≈ q R^4 / (E I)
   where I is the second moment of area of the *section that resists
   bending in the ring plane*. For a rectangular hoop section d × t
   loaded edge-on, I = (d * t^3)/12 is the wrong axis; the relevant
   axis for in-plane ovalization is t through the wall and the section
   modulus depends on the depth-direction integration.

   We compute both bounds:
     - Lower bound (worst): treat the hoop as a thin ring of just the
       1.5 mm wall, I = t^3 d / 12 (depth d acts as ring width).
     - Upper bound (best): include the rolled stiffening bead, which
       adds an order of magnitude to I.
   ============================================================ *)
Esteel = 200 * 10^9;   (* Pa *)
R = a;                 (* approximation: head radius ~ frame radius *)
tMeters = frameThicknessMMEstimate / 1000;
dMeters = frameDepthMMEstimate / 1000;

(* Treat the line load as concentrated at the top edge of the hoop — *)
(* this is approximate; the load applies an edge moment too, ignored here. *)
qLineLoad = TEstimate;   (* N/m — the membrane tension at the rim *)

ImmWorst = (tMeters^3 dMeters)/12;                              (* m^4 *)
ovalizationWorstM = qLineLoad R^4 / (Esteel ImmWorst);          (* m *)
ovalizationWorstMM = 1000 ovalizationWorstM;

(* Best-bound — a stiffening bead of effective triangular section
   ~6mm rise × 12mm chord adds I_bead ≈ 6mm * 1.5mm^3 / 3 + parallel-axis terms;
   we approximate the bead+wall composite as 5× the worst-case I. *)
ImmBest = 5 ImmWorst;
ovalizationBestM = qLineLoad R^4 / (Esteel ImmBest);
ovalizationBestMM = 1000 ovalizationBestM;

structuralSummaryEstimate = <|
  "totalRadialPullN" -> totalRadialPullEstimate,
  "tensionPerLengthNperM" -> TEstimate,
  "ovalizationWorstBoundMM" -> ovalizationWorstMM,
  "ovalizationBestBoundMM" -> ovalizationBestMM,
  "ovalizationBudgetMM" -> 0.5,
  "withinBudgetWorst" -> (ovalizationWorstMM <= 0.5),
  "withinBudgetBest" -> (ovalizationBestMM <= 0.5)
|>;

(* ============================================================
   Sensitivity — what shifts the fundamental?
   ============================================================ *)
f01OfSigmaAndT[sigma_, Tlocal_] := (alpha01/(2 Pi a)) Sqrt[Tlocal/sigma];

sensitivityEstimate = Dataset[{
  <|"scenario" -> "nominal",
    "sigma_kgm2" -> 1.20, "T_Nperm" -> 2960,
    "f01_Hz" -> f01OfSigmaAndT[1.20, 2960]|>,
  <|"scenario" -> "dry-hide-stiffer",
    "sigma_kgm2" -> 0.95, "T_Nperm" -> 2960,
    "f01_Hz" -> f01OfSigmaAndT[0.95, 2960]|>,
  <|"scenario" -> "humid-hide-heavier",
    "sigma_kgm2" -> 1.45, "T_Nperm" -> 2960,
    "f01_Hz" -> f01OfSigmaAndT[1.45, 2960]|>,
  <|"scenario" -> "low-tension-cinematic",
    "sigma_kgm2" -> 1.20, "T_Nperm" -> 2100,
    "f01_Hz" -> f01OfSigmaAndT[1.20, 2100]|>,
  <|"scenario" -> "high-tension-tight",
    "sigma_kgm2" -> 1.20, "T_Nperm" -> 4200,
    "f01_Hz" -> f01OfSigmaAndT[1.20, 4200]|>
}];

(* ============================================================
   Calibration slot — fill in after first prototype measurement
   measurements = {
     <|"mode" -> "(0,1)", "predictedHz" -> 50.0, "measuredHz" -> ???|>,
     <|"mode" -> "(1,1)", "predictedHz" -> 79.7, "measuredHz" -> ???|>,
     ...
   };
   ============================================================ *)

(* ============================================================
   Interactive deployable app — circular-membrane bass surface drum.
   Exposes head diameter, membrane surface density, and target fundamental
   as controls; recomputes tension, Bessel modal frequencies, and the
   frame-ring ovalization bounds live. ALL OUTPUTS ARE EMPIRICAL ESTIMATES.
   ============================================================ *)

(* Pure helpers parameterized by the live controls (no global state) *)
tensionFor[dia_, sigma_, f01_] :=
  sigma * (2 Pi (dia/2/1000) f01 / alpha01)^2;   (* N/m *)

modeFreqFor[alpha_, dia_, sigma_, f01_] :=
  (alpha / (2 Pi (dia/2/1000))) Sqrt[tensionFor[dia, sigma, f01]/sigma];

ovalizationMMFor[dia_, sigma_, f01_, iFactor_] := Module[
  {Rloc = dia/2/1000, tM = frameThicknessMMEstimate/1000,
   dM = frameDepthMMEstimate/1000, q, ImmW},
  q = tensionFor[dia, sigma, f01];
  ImmW = iFactor (tM^3 dM)/12;
  1000 q Rloc^4 / (Esteel ImmW)
];

bassSurfaceDrumExplorer = Manipulate[
  Module[
    {Tloc, pull, ovWorst, ovBest, modeRows, f01},
    f01 = targetF01;
    Tloc = tensionFor[headDiaMM, sigmaKgm2, f01];
    pull = Tloc * 2 Pi (headDiaMM/2/1000);
    ovWorst = ovalizationMMFor[headDiaMM, sigmaKgm2, f01, 1];
    ovBest  = ovalizationMMFor[headDiaMM, sigmaKgm2, f01, 5];
    modeRows = {#[[1]], #[[2]],
        Round[modeFreqFor[#[[2]], headDiaMM, sigmaKgm2, f01], 0.1],
        Round[modeFreqFor[#[[2]], headDiaMM, sigmaKgm2, f01]/f01, 0.001]} & /@
      besselRoots;
    Column[{
      Style["Bass Surface Drum — Acoustic & Frame Estimates", Bold, 14],
      Style["All values are EMPIRICAL ESTIMATES — pending prototype measurement.",
        Italic, Gray],
      Grid[{
        {"Required rim tension (ESTIMATE)",
          Row[{NumberForm[Tloc, {6, 0}], " N/m"}]},
        {"Total radial frame pull (ESTIMATE)",
          Row[{NumberForm[pull, {6, 0}], " N"}]},
        {"Frame ovalization, worst bound (ESTIMATE)",
          Row[{NumberForm[ovWorst, {5, 2}], " mm"}]},
        {"Frame ovalization, best bound (ESTIMATE)",
          Row[{NumberForm[ovBest, {5, 2}], " mm"}]},
        {"Within 0.5 mm budget (best bound)?",
          If[ovBest <= 0.5, "YES (estimate)", "NO (estimate)"]}
        }, Frame -> All, Alignment -> Left, Background -> {None, {LightYellow}}],
      Style["Predicted Bessel modal frequencies (ESTIMATE)", Bold],
      Grid[
        Prepend[modeRows, {"mode (m,n)", "alpha", "freq Hz", "ratio f01"}],
        Frame -> All, Alignment -> Left,
        Background -> {None, {LightBlue, {White}}}]
    }, Spacings -> 1.2]
  ],
  {{headDiaMM, headEffectiveDiameterMMEstimate,
    "head effective diameter (mm) — ESTIMATE"}, 400, 1000, 10,
    Appearance -> "Labeled"},
  {{sigmaKgm2, membraneSurfaceDensityEstimate,
    "membrane surface density (kg/m^2) — ESTIMATE"}, 0.6, 2.0, 0.05,
    Appearance -> "Labeled"},
  {{targetF01, targetF01Estimate,
    "target fundamental f01 (Hz) — ESTIMATE"}, 30, 90, 1,
    Appearance -> "Labeled"},
  ControlPlacement -> Left,
  SaveDefinitions -> True
]
