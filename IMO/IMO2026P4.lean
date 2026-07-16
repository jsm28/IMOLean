/-
Copyright (c) 2026 Joseph Myers. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Myers
-/
import Mathlib


open Affine EuclideanGeometry Module
open scoped Real

namespace IMO2026P4

variable {V P : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [MetricSpace P]
variable [NormedAddTorsor V P] [Fact (finrank ℝ V = 2)]

/-- The condition to win immediately with a given triangle. -/
def WinsNow (t : Triangle ℝ P) (θ : ℝ) : Prop :=
  ∃ i, ∠ (t.points i) (t.points (i + 1)) (t.points (i + 2)) = θ

/-- A choice of perimeter point not at a vertex by Mulan. -/
structure Move (t : Triangle ℝ P) where
  /-- The vertex opposite the point chosen. -/
  i : Fin 3
  /-- The point chosen. -/
  p : P
  sbtw_p : Sbtw ℝ (t.points (i + 1)) p (t.points (i + 2))

/-- One half of the triangle split by a move. -/
def Move.half {t : Triangle ℝ P} (m : Move t) (c : Prop) [Decidable c] : Triangle ℝ P :=
  if c then ⟨![t.points m.i, t.points (m.i + 1), m.p], by
    have h : AffineIndependent ℝ ![t.points m.i, t.points (m.i + 1), t.points (m.i + 2)] := by
      convert t.independent.comp_embedding (finCycle m.i).toEmbedding
      ext i; fin_cases i <;> simp [add_comm]
    convert! h.affineIndependent_update_of_notMem_affineSpan (i := 2) (p₀ := m.p) ?_
    · ext i; fin_cases i <;> simp
    · obtain ⟨r, ⟨hr0, hr1⟩, hre⟩ := m.sbtw_p.mem_image_Ioo
      change AffineMap.lineMap (![t.points m.i, t.points (m.i + 1), t.points (m.i + 2)] 1)
        (![t.points m.i, t.points (m.i + 1), t.points (m.i + 2)] 2) r = m.p at hre
      rw [← hre,
        ← Finset.univ.affineCombination_affineCombinationLineMapWeights _ (by grind) (by grind)]
      intro hm
      apply hr0.ne'
      convert h.eq_zero_of_affineCombination_mem_affineSpan (by simp) hm (i := 2) (by simp)
        (by simp)
      simp⟩ else
    ⟨![t.points m.i, t.points (m.i + 2), m.p], by
    have h : AffineIndependent ℝ ![t.points m.i, t.points (m.i + 2), t.points (m.i + 1)] := by
      convert t.independent.comp_embedding ((Equiv.swap 2 1).trans (finCycle m.i)).toEmbedding
      ext i; fin_cases i <;> simp [add_comm]; grind
    convert! h.affineIndependent_update_of_notMem_affineSpan (i := 2) (p₀ := m.p) ?_
    · ext i; fin_cases i <;> simp
    · obtain ⟨r, ⟨hr0, hr1⟩, hre⟩ := m.sbtw_p.mem_image_Ioo
      change AffineMap.lineMap (![t.points m.i, t.points (m.i + 2), t.points (m.i + 1)] 2)
        (![t.points m.i, t.points (m.i + 2), t.points (m.i + 1)] 1) r = m.p at hre
      rw [← hre,
        ← Finset.univ.affineCombination_affineCombinationLineMapWeights _ (by grind) (by grind)]
      intro hm
      suffices 1 - r = 0 by
        grind
      convert h.eq_zero_of_affineCombination_mem_affineSpan (by simp) hm (i := 2) (by simp)
        (by simp)
      simp⟩

variable (P) in
/-- A strategy for Mulan chooses a move for the last triangle in a list of triangles seen (where
the choices are irrelevant for lists that cannot arise by this strategy, including those where
Mulan has already won). -/
abbrev Strategy := {k : ℕ} → (t : Fin (k + 1) → Triangle ℝ P) → Move (t (Fin.last k))

/-- Given the initial triangle and the choices made by Shan-Yu, the first `k` triangles from playing
a strategy (if it does not win before the end of that list). -/
def Strategy.play (s : Strategy P) (t₀ : Triangle ℝ P) (c : ℕ → Prop) [∀ k, Decidable (c k)] :
    (k : ℕ) → Fin k → Triangle ℝ P
| 0 => Fin.elim0
| 1 => ![t₀]
| k + 2 => Fin.snoc (s.play t₀ c (k + 1)) ((s (s.play t₀ c (k + 1))).half (c k))

open scoped Classical in
/-- Whether a strategy wins for Mulan, against all possible moves by Shan-Yu. -/
def Strategy.Winning (s : Strategy P) (θ : ℝ) : Prop :=
  ∀ (t₀ : Triangle ℝ P) (c : ℕ → Prop), ∃ k, WinsNow ((s.play t₀ c) (k + 1) (Fin.last k)) θ

/-- The answer to be determined. -/
def answer : Set ℝ := sorry

theorem result : {θ : ℝ | 0 < θ ∧ θ < π ∧ ∃ s : Strategy P, s.Winning θ} = answer := by
  sorry

end IMO2026P4
