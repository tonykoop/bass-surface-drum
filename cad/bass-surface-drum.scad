// bass-surface-drum.scad — parametric membrane-frame envelope master
// =====================================================================
// SOURCE OF TRUTH: parameters.csv (design-intent parameter table) + design.md.
// AUTHORITY: pending_measurement. HONEST ENVELOPE SCAFFOLD, NOT fabrication
//   authority until reviewed against SolidWorks masters (see solidworks-plan.md)
//   or measured prototype evidence.
//
// SCOPE / BOUNDARY (per V5 percussion addendum):
//   - Models the rolled steel FRAME cylinder + bearing flange lip + bottom
//     stiffening bead + clamp ring + tension-bolt field + membrane disc as a
//     parametric ENVELOPE, so overall geometry traces to parameters.csv.
//   - TUNING-SENSITIVE geometry is OUT OF SCOPE: the exact rolled bead/flange
//     profile (bead roller setup), the membrane tension field, and the acoustic
//     head-mount are hand-refined / process-defined regions and are NOT modeled
//     as fabrication solids here.
//
// Render check: openscad -o /tmp/bass-surface-drum-check.stl this-file (exit 0)
// =====================================================================

/* [Head / membrane — parameters.csv] */
head_outside_diameter_mm   = 800;   // parameters.csv head_outside_diameter
head_effective_diameter_mm = 760;   // parameters.csv head_effective_diameter
membrane_thickness_mm      = 1.5;   // head_material_v0 steerhide-raw-1.5mm

/* [Frame — parameters.csv] */
frame_depth_mm             = 120;   // parameters.csv frame_depth
frame_wall_thickness_mm    = 1.5;   // parameters.csv frame_wall_thickness (CRS)
bearing_edge_radius_mm     = 4;     // parameters.csv frame_bearing_edge_radius
stiffening_bead_radius_mm  = 6;     // parameters.csv frame_stiffening_bead_radius

/* [Clamp ring / tension — parameters.csv, Variant A] */
clamp_ring_thickness_mm    = 4;     // parameters.csv clamp_ring_thickness
tension_bolt_count         = 6;     // parameters.csv tension_bolt_count
tension_bolt_dia_mm        = 10;    // parameters.csv tension_bolt_thread M10
clamp_ring_width_mm        = 30;    // ASSUMPTION: radial ring width; not tabulated

/* [Render] */
$fn = 96;                 // resolution; toruses use $fn_bead for CGAL speed
$fn_bead = 24;            // cross-section facets for rolled bead/flange toruses
show_membrane = true;

// Derived (formulas) ------------------------------------------------
frame_or = head_outside_diameter_mm / 2;              // outer radius
frame_ir = frame_or - frame_wall_thickness_mm;        // inner radius
membrane_r = head_effective_diameter_mm / 2;          // effective radius
bolt_circle_r = frame_or + clamp_ring_width_mm / 2;   // bolt circle on ring

// Rolled steel frame cylinder --------------------------------------
module frame_cylinder() {
    difference() {
        cylinder(h = frame_depth_mm, r = frame_or);
        translate([0, 0, -1]) cylinder(h = frame_depth_mm + 2, r = frame_ir);
    }
}

// Bearing flange lip (rolled outward at top) — envelope torus -------
// Seated slightly below the rim so it fuses with the wall (manifold-clean).
module bearing_flange() {
    translate([0, 0, frame_depth_mm - bearing_edge_radius_mm])
        rotate_extrude()
            translate([frame_ir, 0])
                circle(r = bearing_edge_radius_mm, $fn = $fn_bead);
}

// Bottom stiffening bead (rolled-in) — envelope torus --------------
// Center lifted to r-radius so the bead sits fully above the floor plane.
module stiffening_bead() {
    translate([0, 0, stiffening_bead_radius_mm])
        rotate_extrude()
            translate([frame_ir, 0])
                circle(r = stiffening_bead_radius_mm, $fn = $fn_bead);
}

// Clamp ring + tension bolt field (Variant A) ----------------------
module clamp_ring() {
    translate([0, 0, frame_depth_mm + bearing_edge_radius_mm])
    difference() {
        cylinder(h = clamp_ring_thickness_mm,
                 r = frame_or + clamp_ring_width_mm);
        translate([0, 0, -1])
            cylinder(h = clamp_ring_thickness_mm + 2, r = membrane_r);
        for (i = [0 : tension_bolt_count - 1])
            rotate([0, 0, i * 360 / tension_bolt_count])
                translate([bolt_circle_r, 0, -1])
                    cylinder(h = clamp_ring_thickness_mm + 2,
                             r = tension_bolt_dia_mm / 2);
    }
}

// Membrane disc (single head) --------------------------------------
module membrane() {
    translate([0, 0, frame_depth_mm + bearing_edge_radius_mm])
        cylinder(h = membrane_thickness_mm, r = membrane_r);
}

// Assembly ---------------------------------------------------------
module bass_surface_drum() {
    // Metal frame parts unioned so coincident faces fuse into one manifold solid
    color("SlateGray")
        union() {
            frame_cylinder();
            bearing_flange();
            stiffening_bead();
        }
    color("Gainsboro") clamp_ring();
    if (show_membrane) color("Tan") membrane();
}

bass_surface_drum();

echo(str("membrane_r = ", membrane_r, " mm; frame_or = ", frame_or,
         " mm; bolts = ", tension_bolt_count, " x M", tension_bolt_dia_mm));
