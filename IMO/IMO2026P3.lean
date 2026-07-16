/-
Copyright (c) 2026 Joseph Myers. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Myers
-/
import Mathlib


open scoped Finset

namespace IMO2026P3

/-- A strategy for Liu Bang. -/
structure Strategy (n : ℕ) where
  /-- The points marked by Liu. -/
  points : Finset (Set.Ioo (0 : ℝ) 1)
  card_points_le : #points ≤ n
  /-- Given the points marked by Xiang, and the indices of starting points of pieces claimed so
  far, the index of the next starting point to claim.  The choice is ignored for previous indices
  that cannot arise (on Liu's turn) from this strategy. -/
  claims : ∀ xiangPoints : Finset (Set.Ioo (0 : ℝ) 1), #xiangPoints ≤ n →
    Disjoint points xiangPoints → ∀ m, m ≤ #points + #xiangPoints →
      ∀ priorClaims : Fin m → Fin (#points + #xiangPoints + 1),
      {i : Fin (#points + #xiangPoints + 1) // i ∉ Set.range priorClaims}

/-- Given the points marked by Xiang and the claims (not necessarily valid given this strategy)
made by Xiang (with arbitrary claims for after all pieces have been claimed), the first `k` claims
made (valid only if `k` does not exceed the number of pieces and Xiang does not claim
already-claimed pieces). -/
def Strategy.play {n : ℕ} (s : Strategy n) (xiangPoints : Finset (Set.Ioo (0 : ℝ) 1))
    (card_xiangPoints_le : #xiangPoints ≤ n) (hd : Disjoint s.points xiangPoints)
    (xiangClaims : ℕ → Fin (#s.points + #xiangPoints + 1)) :
    (k : ℕ) → Fin k → Fin (#s.points + #xiangPoints + 1)
| 0 => Fin.elim0
| k + 1 => Fin.snoc (s.play xiangPoints card_xiangPoints_le hd xiangClaims k)
    (if Even k then (if h : k ≤ #s.points + #xiangPoints then
      s.claims xiangPoints card_xiangPoints_le hd k h
        (s.play xiangPoints card_xiangPoints_le hd xiangClaims k) else 0) else xiangClaims (k / 2))

/-- Whether the claims made by Xiang when playing a strategy are valid. -/
def Strategy.PlayValid {n : ℕ} (s : Strategy n) (xiangPoints : Finset (Set.Ioo (0 : ℝ) 1))
    (card_xiangPoints_le : #xiangPoints ≤ n) (hd : Disjoint s.points xiangPoints)
    (xiangClaims : ℕ → Fin (#s.points + #xiangPoints + 1)) : Prop :=
  Function.Injective (s.play xiangPoints card_xiangPoints_le hd xiangClaims
    (#s.points + #xiangPoints + 1))

/-- The sorted endpoints of the pieces from playing a strategy. -/
noncomputable def Strategy.playEnds {n : ℕ} (s : Strategy n)
    (xiangPoints : Finset (Set.Ioo (0 : ℝ) 1)) : List ℝ :=
  ((s.points ∪ xiangPoints).map (Function.Embedding.subtype _) ∪ {0, 1}).sort

/-- The length of a piece from playing a strategy. -/
noncomputable def Strategy.playPieceLength {n : ℕ} (s : Strategy n)
    (xiangPoints : Finset (Set.Ioo (0 : ℝ) 1))
    (i : Fin (#s.points + #xiangPoints + 1)) : ℝ :=
  (s.playEnds xiangPoints).getD ((i : ℕ) + 1) 0 - (s.playEnds xiangPoints).getD i 0

/-- The length achieved by Liu when playing a strategy against given claims by Xiang. -/
noncomputable def Strategy.playLength {n : ℕ} (s : Strategy n)
    (xiangPoints : Finset (Set.Ioo (0 : ℝ) 1)) (card_xiangPoints_le : #xiangPoints ≤ n)
    (hd : Disjoint s.points xiangPoints)
    (xiangClaims : ℕ → Fin (#s.points + #xiangPoints + 1)) : ℝ :=
  ∑ i : Fin (#s.points + #xiangPoints + 1) with Even ((i : Fin _) : ℕ),
    s.playPieceLength xiangPoints (s.play xiangPoints card_xiangPoints_le hd xiangClaims
      (#s.points + #xiangPoints + 1) i)

/-- The answer to be determined. -/
def answer : ℕ+ → ℝ := sorry

theorem result {n : ℕ+} : IsGreatest {c | ∃ s : Strategy n,
    ∀ (xiangPoints : Finset (Set.Ioo (0 : ℝ) 1)) (card_xiangPoints_le : #xiangPoints ≤ n)
      (hd : Disjoint s.points xiangPoints) (xiangClaims : ℕ → Fin (#s.points + #xiangPoints + 1)),
      s.PlayValid xiangPoints card_xiangPoints_le hd xiangClaims →
      c ≤ s.playLength xiangPoints card_xiangPoints_le hd xiangClaims} (answer n) := by
  sorry

end IMO2026P3
