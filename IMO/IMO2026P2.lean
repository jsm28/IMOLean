/-
Copyright (c) 2026 Joseph Myers. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Myers
-/
import Mathlib


open Affine EuclideanGeometry Module

namespace IMO2026P2

variable {V P : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [MetricSpace P]
variable [NormedAddTorsor V P] [Fact (finrank ℝ V = 2)]

/-- The affine-independence hypotheses supply the nondegeneracy witnesses required to construct
the triangles in the statement.  The notation `∠` denotes the undirected Euclidean angle. -/
theorem result {A B C M N K L O : P} (affineIndependent_ABC : AffineIndependent ℝ ![A, B, C])
    (M_eq_midpoint_AB : M = midpoint ℝ A B) (N_eq_midpoint_AC : N = midpoint ℝ A C)
    (affineIndependent_BMC : AffineIndependent ℝ ![B, M, C])
    (affineIndependent_BNC : AffineIndependent ℝ ![B, N, C])
    (affineIndependent_ABL : AffineIndependent ℝ ![A, B, L])
    (affineIndependent_AKC : AffineIndependent ℝ ![A, K, C])
    (K_mem_interior_BMC : K ∈ (⟨_, affineIndependent_BMC⟩ : Triangle ℝ P).interior)
    (L_mem_interior_BNC : L ∈ (⟨_, affineIndependent_BNC⟩ : Triangle ℝ P).interior)
    (K_mem_interior_ABL : K ∈ (⟨_, affineIndependent_ABL⟩ : Triangle ℝ P).interior)
    (L_mem_interior_AKC : L ∈ (⟨_, affineIndependent_AKC⟩ : Triangle ℝ P).interior)
    (angle_KBA_eq_angle_ACL : ∠ K B A = ∠ A C L)
    (angle_LBK_eq_angle_LNC : ∠ L B K = ∠ L N C)
    (angle_LCK_eq_angle_BMK : ∠ L C K = ∠ B M K)
    (affineIndependent_AKL : AffineIndependent ℝ ![A, K, L])
    (O_eq_circumcenter : O = (⟨_, affineIndependent_AKL⟩ : Triangle ℝ P).circumcenter) :
    dist O M = dist O N := by
  sorry

end IMO2026P2
