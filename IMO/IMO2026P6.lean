/-
Copyright (c) 2026 Joseph Myers. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Joseph Myers
-/
import Mathlib


namespace IMO2026P6

theorem result {a : ℕ → ℕ} (one_lt : ∀ i, 1 < a i)
    (one_lt_gcd : ∀ n, IsLeast {m | a n < m ∧ ∀ i ≤ n, 1 < Nat.gcd m (a i)} (a (n + 1))) :
    ∃ (T L : ℕ), 0 < T ∧ 0 < L ∧ ∀ n, a (n + T) = a n + L := by
  sorry

end IMO2026P6
