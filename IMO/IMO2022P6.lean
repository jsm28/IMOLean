/-
Copyright (c) 2025 Joseph Myers. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Myers
-/
import Mathlib


open scoped Cardinal

namespace IMO2022P6

/-- A cell of the board. -/
abbrev Cell (n : ℕ) : Type := Fin n × Fin n

/-- A Nordic square. -/
abbrev NordicSquare (n : ℕ) : Type := Cell n ≃ Finset.Icc 1 (n ^ 2)

/-- Whether two cells are adjacent. -/
def Adjacent {n : ℕ} (x y : Cell n) : Prop :=
  Nat.dist x.1 y.1 + Nat.dist x.2 y.2 = 1

/-- The definition of a valley from the problem. -/
def NordicSquare.Valley {n : ℕ} (ns : NordicSquare n) (c : Cell n) : Prop :=
  ∀ c' : Cell n, Adjacent c c' → (ns c : ℕ) < (ns c' : ℕ)

/-- The definition of an uphill path from the problem. -/
structure NordicSquare.UphillPath {n : ℕ} (ns : NordicSquare n) where
  /-- The cells on the path. -/
  cells : List (Cell n)
  nonempty : cells ≠ []
  first_valley : ns.Valley (cells.head nonempty)
  adjacent : cells.IsChain Adjacent
  increasing : cells.IsChain fun x y ↦ (ns x : ℕ) < (ns y : ℕ)

/-- The answer to be determined. -/
def answer : ℕ+ → ℕ := sorry

theorem result {n : ℕ+} :
    IsLeast {k : ℕ | ∃ ns : NordicSquare n, #ns.UphillPath = k} (answer n) := by
  sorry

end IMO2022P6
