/-
Copyright (c) 2025 Joseph Myers. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Myers
-/
import Mathlib


namespace IMO2020P4

/-- A cable car's starting and finishing points. -/
structure Car (n : ℕ) : Type where
  /-- The starting point. -/
  start : Fin (n ^ 2)
  /-- The finishing point. -/
  finish : Fin (n ^ 2)
  start_lt_finish : start < finish

/-- The cable cars of a company. -/
structure Company (n k : ℕ) : Type where
  /-- The individual cars. -/
  cars : Fin k → Car n
  injective_start : Function.Injective fun i ↦ (cars i).start
  injective_finish : Function.Injective fun i ↦ (cars i).finish
  monovary_start_finish : Monovary (fun i ↦ (cars i).start) (fun i ↦ (cars i).finish)

/-- A linkage between two stations. -/
structure Company.linkage {n k : ℕ} (c : Company n k) : Type where
  /-- The sequence of cars used. -/
  cars : List (Fin k)
  nonempty : cars ≠ []
  valid : cars.IsChain fun i j ↦ (c.cars i).finish = (c.cars j).start

/-- The first station in a linkage. -/
def Company.linkage.start {n k : ℕ} {c : Company n k} (x : c.linkage) : Fin (n ^ 2) :=
  (c.cars (x.cars.head x.nonempty)).start

/-- The last station in a linkage. -/
def Company.linkage.finish {n k : ℕ} {c : Company n k} (x : c.linkage) : Fin (n ^ 2) :=
  (c.cars (x.cars.getLast x.nonempty)).finish

/-- The property of two stations being linked (in the given order). -/
def Company.linked {n k : ℕ} (c : Company n k) (l h : Fin (n ^ 2)) : Prop :=
  ∃ x : c.linkage, x.start = l ∧ x.finish = h

/-- The answer to be determined. -/
def answer : (Set.Ioi 1) → ℕ := sorry

theorem result (n : Set.Ioi 1) :
    IsLeast {k : ℕ | ∀ A B : Company n k, ∃ i j, A.linked i j ∧ B.linked i j} (answer n) := by
  sorry

end IMO2020P4
