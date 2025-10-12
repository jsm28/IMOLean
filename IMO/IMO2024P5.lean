/-
Copyright (c) 2024 Joseph Myers. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Myers
-/
import Mathlib


namespace IMO2024P5

/-- A cell on the board for the game. -/
abbrev Cell : Type := Fin 2024 × Fin 2023

/-- A row that is neither the first nor the last (and thus contains a monster). -/
abbrev InteriorRow : Type := (Set.Icc 1 ⟨2022, by decide⟩ : Set (Fin 2024))

/-- Data for valid positions of the monsters. -/
abbrev MonsterData : Type := InteriorRow ↪ Fin 2023

/-- The cells with monsters as a Set, given an injection from rows to columns. -/
def MonsterData.monsterCells (m : MonsterData) :
    Set Cell :=
  Set.range (fun x : InteriorRow ↦ ((x : Fin 2024), m x))

/-- Whether two cells are adjacent. -/
def Adjacent (x y : Cell) : Prop :=
  Nat.dist x.1 y.1 + Nat.dist x.2 y.2 = 1

/-- A valid path from the first to the last row. -/
structure Path where
  /-- The cells on the path. -/
  cells : List Cell
  nonempty : cells ≠ []
  head_first_row : (cells.head nonempty).1 = 0
  last_last_row : (cells.getLast nonempty).1 = ⟨2023, by decide⟩
  valid_move_seq : cells.IsChain Adjacent

/-- The first monster on a path, or `none`. -/
noncomputable def Path.firstMonster (p : Path) (m : MonsterData) : Option Cell :=
  letI := Classical.propDecidable
  p.cells.find? (fun x ↦ (x ∈ m.monsterCells : Bool))

/-- A strategy, given the results of initial attempts, returns a path for the next attempt. -/
abbrev Strategy : Type := ⦃k : ℕ⦄ → (Fin k → Option Cell) → Path

/-- Playing a strategy, k attempts. -/
noncomputable def Strategy.play (s : Strategy) (m : MonsterData) :
    (k : ℕ) → Fin k → Option Cell
| 0 => Fin.elim0
| k + 1 => Fin.snoc (s.play m k) ((s (s.play m k)).firstMonster m)

/-- The predicate for a strategy winning within the given number of attempts. -/
def Strategy.WinsIn (s : Strategy) (m : MonsterData) (k : ℕ) : Prop :=
  none ∈ Set.range (s.play m k)

/-- Whether a strategy forces a win within the given number of attempts. -/
def Strategy.ForcesWinIn (s : Strategy) (k : ℕ) : Prop :=
  ∀ m, s.WinsIn m k

/-- The answer to be determined. -/
def answer : ℕ := sorry

theorem result : IsLeast {n | ∃ s : Strategy, s.ForcesWinIn n} answer := by
  sorry

end IMO2024P5
