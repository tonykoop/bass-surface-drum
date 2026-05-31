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
   Outputs
   ============================================================ *)
Print["Predicted modal frequencies:"];
predictedModes
Print["Structural summary (frame ring under membrane load):"];
structuralSummaryEstimate
Print["Sensitivity to head and tension:"];
sensitivityEstimate

(* ============================================================
   Calibration slot — fill in after first prototype measurement
   measurements = {
     <|"mode" -> "(0,1)", "predictedHz" -> 50.0, "measuredHz" -> ???|>,
     <|"mode" -> "(1,1)", "predictedHz" -> 79.7, "measuredHz" -> ???|>,
     ...
   };
   ============================================================ *)
