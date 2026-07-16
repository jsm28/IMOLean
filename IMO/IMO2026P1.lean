/-
Copyright (c) 2026 Joseph Myers. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Myers
-/
import Mathlib


namespace IMO2026P1

/-- Whether it is valid to move from `p₁` to `p₂`. -/
def ValidMove (p₁ p₂ : Fin 2026 → ℕ) : Prop :=
  ∃ i j, i ≠ j ∧ 1 < p₁ i ∧ 1 < p₁ j ∧ (∀ k, k ≠ i → k ≠ j → p₂ k = p₁ k) ∧
    p₂ i = Nat.gcd (p₁ i) (p₁ j) ∧
      p₂ j = Nat.lcm (p₁ i) (p₁ j) / Nat.gcd (p₁ i) (p₁ j)

/-- Whether it is valid to move from `p₁` to `p₂`, or they are the same and there is no valid move
from that position. -/
def ValidOrNoMove (p₁ p₂ : Fin 2026 → ℕ) : Prop :=
  ValidMove p₁ p₂ ∨ p₁ = p₂ ∧ ¬∃ i j, i ≠ j ∧ 1 < p₁ i ∧ 1 < p₁ j

/-- Whether a sequence of positions if a valid one starting with a given position (known to be a
valid starting position), with the convention that the position is unchanged when there are no
valid moves. -/
def ValidSeq (p₀ : Fin 2026 → ℕ) (p : ℕ → Fin 2026 → ℕ) : Prop :=
  p 0 = p₀ ∧ ∀ i, ValidOrNoMove (p i) (p (i + 1))

theorem result {p₀ : Fin 2026 → ℕ} (h0 : ∀ i, 1 < p₀ i) :
    (∀ p, ValidSeq p₀ p → ∃ j, ∃! k, 1 < p j k) ∧
      ∃ M, ∀ p, ValidSeq p₀ p → ∀ j, (∃! k, 1 < p j k) → ∀ k, 1 < p j k → p j k = M := by
  sorry

end IMO2026P1
