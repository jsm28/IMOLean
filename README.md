# IMO Lean formalization conventions

This repository presents my (Joseph Myers's) suggestions for
appropriate conventions for Lean formalizations of IMO problem
statements, along with examples of problem statements formalized
following those conventions.

It represents my personal views on appropriate conventions for such
formalizations (along with a set of formalizations intended to be
written uniformly, by a single person, following those conventions)
and is not associated with any project to create such formalizations
or to use such formalizations as a challenge for human or AI problem
solvers or formalizers.  In parts it reflects my dissatisfaction with
the lack of public documented conventions for such issues, or with
some particular choices that have been made in the past, in existing
public collections of such problems or solutions.

People are welcome to use and adapt these conventions for such
projects (including ones for non-Lean ITPs) if they so wish.  Problem
statements here may also be of use for projects such as
[Compfiles](https://dwrensha.github.io/compfiles/), though it is
important to check statements carefully and report any mistakes, given
the high risk of making mistakes in formal statements when those
statements are not validated by writing a formal solution based on a
human solution.  There are many [common
pitfalls](https://leanprover-community.github.io/extras/pitfalls.html)
to consider when writing Lean.

The conventions here draw on my experience with formalizing some past
problem statements and solutions, including both formalizations of IMO
problems with solutions for the mathlib archive, and formalizations of
statements of [all the non-geometry IMO 2024 shortlist
problems](https://github.com/jsm28/IMOShortlist2024Lean) (with
solutions in only a handful of cases) ahead of that IMO while chairing
the Problem Selection Committee.  However, those past formalizations
do not necessarily follow these conventions, both because my views on
appropriate conventions evolved based on the experience writing those
formalizations, and because of cases where appropriate conventions in
the context of a solution seem different from appropriate conventions
for a problem stated on its own (for potential use as a challenge by
human or AI solvers or formalizers) without a corresponding formal
solution present.

These conventions and associated formalizations may change over time
(especially as the conventions expand to cover more issues and the
formalizations are adapted to follow the conventions more closely),
and more formalizations may be added.  Corrections to mistakes in the
formalizations are particularly welcome, as is pointing out areas of
inconsistency between the formalizations and the conventions, or areas
not covered by the conventions that should be so covered.  Formalizing
solutions to the formal statements here is encouraged as a way of
checking the correctness of the statements; however, such solutions
are out of scope for this repository so should go in other public
repositories instead.

Where existing public repositories such as the mathlib archive and
Compfiles do not have a formal solution to a problem, those may be
appropriate locations for such a solution; I strongly encourage first
contributing any more generally relevant definitions and lemmas to
mathlib proper since that is one of the main benefits of formalizing
competition problem solutions.  Where such repositories do have a
formal solution, it may be a useful basis for a formal solution to the
formal statement here, whether through adapting it to prove my version
of the statement directly, or through adding a proof that one version
implies the other.

The formalizations here are intended to be based directly on the
English wording of problems as originally given to contestants at the
IMO.  Note that most pre-2006 [papers on
imo-official](https://www.imo-official.org/problems.aspx) are retyped
versions, sometimes paraphrased rather than reflecting the original
wording; if you'd like me to consider pre-2006 papers for addition to
the formalizations here, please contribute scans of papers actually
given to contestants for my [collection of such
scans](https://www.imo-register.org.uk/papers/).

By releasing such conventions I hope to encourage other people writing
such formalizations to consider (and document) what conventions they
wish to use, especially where a fully literal translation into Lean
might involve making choices that are less idiomatic for Lean code
(and so more awkward to work with when using mathlib APIs).  I
especially commend the following points from these conventions to
people establishing their own conventions:

(a) use appropriate separate definitions within the problem statement
when appropriate (so requiring any AI solvers to be able to handle a
context of multiple top-level definitions rather than having all
non-library content within a single `theorem` for which a proof is to
be filled in, with local definitions artificially converted into
hypotheses of that theorem, as was done for [AlphaProof at IMO
2024](https://deepmind.google/discover/blog/ai-solves-imo-problems-at-silver-medal-level/);
being able to handle local definitions is also likely to be important
for practical usability of an AI solver in many contexts);

(b) state problems in standard mode (any answer to be determined by a
human in the original competition is also to be determined by AI
solvers using the formal statement) rather than easy mode (formal
statement tells a solver what answer is to be proved), and generally
make the formal statements reflect the entirety of what humans are to
prove (so also do not ask for only one direction of an if-and-only-if,
as some benchmark problems have been known to do, for example);

(c) when any problem is most naturally stated using a
mathlib-appropriate definition of a standard concept, contribute that
definition and associated API to mathlib rather than having a local
definition as part of the problem (or in the case of challenges
intended to be based on future problems, contribute the definitions
most likely to be relevant to mathlib in advance to reduce the risk of
needing a local definition for a future problem statement).

Anyone setting a challenge based on formal problem statements should
note that having detailed, public formalization conventions would
assist entrants in creating additional examples using those
conventions as training material.  Compare, for example, [the detailed
documentation of both English and LaTeX conventions used for problems
in the AI Mathematical Olympiad Progress Prize
2](https://www.kaggle.com/c/ai-mathematical-olympiad-progress-prize-2/overview/note-on-language-and-notation).

These conventions are written specifically for IMO problems and the
concepts that appear in such problems.  It is likely that additional
conventions would be appropriate for different competitions covering
other subject material (especially those at undergraduate level, for
example).  If a challenge is based on new problems not originally set
for humans in informal language, it might be appropriate in some cases
to go further in the direction of idiomatic Lean rather than trying to
following any particular English version closely.

Although having such public conventions stated well in advance of any
such challenge would help make it fair rather than potentially biased
to entrants who happened to prefer statements more similar to those
used in the final challenge (and allowing multiple entrants each to
produce their own Lean statements would also result in potential bias,
as well as being inconsistent with a single natural language normally
only having a single version of the problems for human contestants at
the IMO), there are of course also valid and important uses for
formalizations that deliberately do not follow any kind of uniform
conventions.  In particular, any kind of practical AI research
assistant that could be given problems to attempt by human
mathematicians should not expect such statements (if given in formal
form at all rather than informal form) to follow any consistent
conventions, so should be robust to a wide range of styles in problem
statements, which may mean training on a wide range of styles is also
beneficial.  Even in such cases, it is still important to consider
questions such as the handling of junk values, to ensure that the
formal statement actually has the correct mathematical content.

These conventions are mainly concerned with problem statements rather
than with the details of how to validate the correctness of a claimed
formal solution in any kind of automated way; there are various
subtleties about such validation and, as of July 2025, such validation
is not as convenient as it might be.  A solution should have a type
definitionally equal to that in the problem statement; for "determine"
problems, this applies with the answer substituted, and the answer
must satisfy human inspection as being legitimate rather than a
restatement of the problem; care must be taken about ensuring that
neither meta code nor instances in the claimed solution affect the
interpretation of the problem or the claimed answer (possibly by
comparing a proof exported from the claimed solution when executed in
a sandbox environment with the type of the statement in its own file
with the text of a human-validated answer substituted into that file).
A solution should depend only on the standard three axioms (in
particular, `Lean.ofReduceBool`, as generated by `native_decide`, is
not typically considered legitimate in validating formalized
mathematics, and prevents passing an exported solution though an
external checker).

## Conventions for problems versus solutions

The conventions here are intended for problems stated on their own
rather than problem statements with accompanying solutions.  There are
a few main ways in which I think conventions for a problem statement
with a solution present naturally differ from those with for a problem
statement on its own.

* When a solution is present, it's typically convenient in a
  well-factored solution to have a series of lemmas building up
  information about the problem (rather than putting everything in a
  single long `by` tactic block).  With such a structure, it's also
  often convenient to have factored-out definitions for various
  definitions or conditions used within the problem statement, even
  when the conventions given here would not suggest having such
  definitions for a problem statement on its own (because a condition
  is used only once in the problem statement and does not involve any
  term defined as part of the original informal statement, for
  example).

* When a problem involves specific but arbitrary numbers (for example,
  the year of the competition), but only depends on more limited
  properties of such numbers (say, depends on the year being at least
  3, or on it being an even number), it's likely appropriate in a
  formal solution to generalize to arbitrary `N` satisfying the
  required conditions, including in any local definitions used as part
  of the problem statement, and only prove the result for a specific
  `N` at the end.  (This would have been particularly relevant in Lean
  3, where large numerals were internally represented as large terms
  involving `bit0` and `bit1`, which could thus slow down Lean and
  sometimes have unwanted consequences when tactics made changes
  inside such a term.  That issue does not apply in Lean 4.  The
  general principle still applies as a matter of good practice,
  however, and in particular if a solution involves induction on `N`
  it may be more convenient to have the statement in terms of general
  `N`.)

  Example: my formalization of IMO 2024 P5 in the mathlib archive
  expresses things for `N` monsters, `N + 1` columns and `N + 2` rows,
  but a statement of the problem on its own following these
  conventions uses `2022`, `2023` and `2024` directly in all the
  definitions used to set up the problem statement.

## Overall source file structure

* Except where stated otherwise, mathlib
  [style](https://leanprover-community.github.io/contribute/style.html)
  and
  [naming](https://leanprover-community.github.io/contribute/naming.html)
  conventions apply, and sources should pass linting accordingly.

* When a file following these conventions is presented as a challenge
  to an AI solver, all comments and doc strings should be removed.  In
  particular, doc strings may be needed on definitions to pass
  linting, but should not be present when given to an AI.  If an AI
  receives an informal problem statement alongside the formal
  statement, that should be provided separately, not as part of a doc
  string in a formal problem statement file.  A source file may also
  have doc strings or comments to explain how the formal concepts
  correspond to the informal ones, in more complicated cases, but
  those should not be given to an AI.  Rationale: while human IMO
  contestants may receive papers in up to three natural languages,
  those versions do not include any comments explaining what terms in
  one version correspond to what terms in another version; it's up to
  the contestant to work out the correspondence between different
  versions.

* Statements use `import Mathlib`.  An AI may modify imports, as long
  as the types used for the problem statement, and any answer the AI
  is to determine, remain definitionally equal to those presented to
  the AI (as a function of the answer, in the case where the AI has to
  provide an answer to a "determine" problem).

* Each source file contains a single `theorem` (using `sorry` in its
  proof) for the problem statement.  That theorem is intended to be
  proved (replacing `sorry`) by anyone using these statements as a
  challenge.  As usual for Lean code, hypotheses preferably go to the
  left of the colon.  If the original problem was in multiple parts,
  the theorem statement is a conjunction between the results for those
  multiple parts (using `∧`, or `∃` if a dependent conjunction is
  required because the type of a later part depends on the result from
  an earlier part) even though it would be more idiomatic Lean to have
  separate results for separate parts.

* In the case of problems asking for some answer to be determined,
  there is a separate definition for the answer, giving its expected
  type and defined to `sorry`, and referenced in the `theorem`
  statement, which must also be filled in by a solver, with an answer
  that is acceptable to a human reviewer as a genuine answer to the
  problem (rather than just repeating the problem statement, for
  example); there is no general form of such answers defined for
  automated checking.  When there are multiple parts to the problem
  that require such answers, a product type (or other type as needed,
  such as a Sigma type, if the type of the answer to a later part
  depends on the answer to an earlier part) is used so that all the
  parts of the answer go in a single definition.  A solver may add
  `noncomputable` to this `def` as needed even if not present in the
  original statement; computability in the Lean sense is not relevant
  to whether something is considered a proper answer to a problem.

* The main overall structure of a source file (without doc strings or
  comments), after the imports, is:

  ```lean
  namespace IMO1637P6

  def answer : Set ℕ := sorry

  theorem result :
      {n : ℕ | ∃ a b c : ℕ, 0 < a ∧ 0 < b ∧ 0 < c ∧ a ^ n + b ^ n = c ^ n} = answer := by
    sorry

  end IMO1637P6
  ```

  A legitimate solution in that example might use `{1, 2}` as its
  definition of `answer`.  A solver that just copied the set from the
  statement of `result` and then used `rfl` as the proof, although
  passing type checking, would not be considered by a human reviewer
  of the answer to have produced a legitimate answer.  (Real examples
  where automated checking for legitimate definitions of `answer`
  would be hard would involve problems where the answer is more
  complicated to state than the sort of small set of small natural
  numbers seen here.)

  As discussed below, problem statements may also reference local
  definitions (including both functions and types) from the source
  file in some cases where those are appropriate for a convenient and
  idiomatic statement of the problem.  There may also be `variable`
  declarations in some cases, and other declarations such as `open` or
  `open scoped`.

  The name `answer` is used even if in a particular case the type is
  such (e.g. `Prop`) that mathlib conventions would capitalize the
  name.  Unlike in some existing formalizations, there is no
  distinction based on whether the answer is a set either.

  If the expected form of the answer is a function of some data in the
  problem (for example, the locus of some point in terms of other
  points in a geometry problem), then that data is passed as arguments
  to `answer` (to the left of the colon), as are any hypotheses
  provided about that data.  All such hypotheses are passed to both
  `answer` and `result` even if in fact some of them are not needed
  and might result in unused arguments when the problem is solved.

## General principles

These overall principles guide both individual formalizations and
various of the more detailed conventions here.

* Formalizations should accurately reflect the entirety of what the
  original statement asks to be determined or proved by a human
  contestant (even if part of that literally-present content would be
  considered sufficiently obvious by humans that a human contestant
  would not have been expected to write anything for it on their
  script).  It should not be a partial or simplified version of the
  problem, or give any information that would have to be determined by
  a human contestant.

* Formalizations should avoid reinterpreting problem statements in
  terms of different mathematical concepts where concepts directly
  available in mathlib correspond more closely to the original
  formulation, even where the two versions are obviously (to humans)
  equivalent.  This may be overridden in particular cases by
  conventions specifying what mathlib definition is to be used for
  certain terminology in problem statements, and is also in tension
  with the following principle.

* Formalizations should be in reasonably idiomatic Lean following
  mathlib conventions.  Sometimes this may mean the informal statement
  is adjusted more to produce the formal version than would be typical
  in a translation between different natural languages, in order to
  avoid a statement that, through its unidiomatic usages, is awkward
  to work with in Lean because of the need to translate within a
  solution to definitions that have more mathlib API available.

## Choice of types

There is often a choice to be made in the Lean types to be used for
variables in an informal problem statement.  For example, if a
statement says something is a positive integer, that might be
expressed using the type `ℕ+`, or using the type `ℕ` or `ℤ` with a
separate hypothesis that the value is positive, or using a subtype of
one of those types.  A hypothesis of being positive might be expressed
as `0 < n`, or `n ≠ 0` when using `ℕ`.

The guiding principle here is that the types `ℕ`, `ℤ`, `ℚ` and `ℝ` are
generally more convenient to use with mathlib than more restricted
types (with fewer lemmas available) such as `ℕ+`, `ℚ≥0` and `ℝ≥0`.
Thus, use of `ℕ`, `ℤ`, `ℚ` and `ℝ` is preferred here.  For positive
integers, `ℕ` is used with a separate hypothesis in the form `0 < n`.
(The mathlib convention that hypotheses use `n ≠ 0` but conclusions
use `0 < n` is not followed.  Rather, "positive" is literally
translated as `0 < n` while "nonzero" is literally translated as `n ≠ 0`.)

The same principle generally applies for the codomain of a function: a
less restricted type is used with a hypothesis on the values.
However, for the domain of a function that is the subject of a problem
(typically a functional equation), a more restricted type is used to
avoid the function in the formal statement having additional junk
information (values at arguments that do are not part of the domain in
the informal statement).  If a function type is itself the domain of
another function (including a local definition in the informal problem
statement), that makes it appropriate to use a more restricted type
for the codomain of that function type to avoid junk values for the
other function or definition,

In the limited case where the informal statement has restricted types
for both the domain and codomain and expressions that are only valid
given a restricted type for the codomain (for example, $f(f(x))$ for a
function from the positive integers to the positive integers), it's
appropriate to use a restricted type for the codomain in the formal
statement as well.  If a suitable restricted type is not defined in
mathlib for the specific case required, then, when the restriction is
to positive values, the instances in
`Mathlib.Algebra.Order.Positive.Ring` and
`Mathlib.Algebra.Order.Positive.Field` may be useful if more
complicated arithmetic is used before passing values back into the
function.  Unless required for expressions in the problem statement to
be valid, however, arithmetic in a less restricted type would
generally be used.

When more restricted types are used for functions with a domain or
codomain given by an interval (for example, IMO 1994 P5), definitions
such as `Set.Ioi` or `Set.Icc` are used for those intervals (along
with the coercion from set to subtype) unless that interferes with use
of instances in mathlib.

For a problem involving sets there may be the question of whether to
use `Set` or `Finset`.  If a set is specified in the problem as being
finite, or is finite for structural reasons (such as being a subset of
a finite interval, for example) and used with operations (such as
summation, or cardinality expected to be a natural number) that make
the most general sense with a finite set, then `Finset` should be used
in the Lean statement; if finiteness is not involved in the statement,
`Set` is used.  This means that cardinality of `Set` is generally only
used where finiteness is something that would have to be proved (or
disproved) by the solver (for example, IMO 2024 P6); in particular, it
is unlikely that `Set.ncard` is appropriate to use, because of its
junk value; if finiteness is to be proved (or disproved), then
`Cardinal.mk` (notation `#`) is more appropriate, while if finiteness
is structural, `Finset` is more appropriate.

When an informal problem involves $n$ values, they are typically given
indices from 1 to $n$; similarly, an infinite sequence of values is
typically given indices from 1 upwards in informal mathematics.  The
normal convention in Lean and mathlib, following many programming
languages, is for 0-based indices, and those are used in these
formalization conventions.  When translating a problem to 0-based
indices for the formal statement, appropriate care must be taken to
adjust any uses of indices in the expressions in the problem (for
example, $i a_i$ could become `(i + 1) * a i` in the formal
statement).  For informal indices from 1 to $n$, the type `Fin n` is
used (and `((i : ℕ) + 1) * a i` might be needed in that example,
because while the modulo arithmetic on `Fin n` is typically
appropriate within indices, it generally is not outside them).

Occasionally indices in an informal statement start somewhere other
than 0 or 1 (for example, IMO 2012 P2).  In those cases, an
appropriate subtype (typically given by an interval) is used in the
formal statement rather than applying any adjustment to indices for
the formal statement other than converting from 1-based to 0-based.

In a case (such as IMO 2022 P1) where the problem asks to determine
indices with a given property, the indices in the `answer` to be
determined are as in the informal statement (although the rest of the
formal problem statement still works with 0-based indices when
indicated by the above conventions).

## Default (junk) values

There are various cases where informal mathematics uses partial
functions, or functions returning values in a type different from
their arguments, but formal mathematics uses a different definition to
achieve a total function with a result in a more convenient type.  In
particular, division by zero returns 0 in Lean, while subtraction in
`ℕ` truncates to zero, and division in `ℕ` and `ℤ` also truncates to
achieve a result in the same type.  (There are other cases that may be
encountered in particular areas of olympiad mathematics, such as
default cases for angles involving a zero vector.)

These junk values do not appear in informal mathematics.  Rather, if
an informal statement involves division in a hypothesis, there is an
implicit hypothesis that there is no division by zero; if it involves
division in a conclusion, it must implicitly also be proved that the
value being divided by is not zero.  Similarly, a reference to an
angle $ABC$ implies that $B$ is not $A$ or $C$.  Subtraction of two
values in `ℕ` might return a negative number in informal mathematics,
and an [attempted AI solution to IMO 2001
P6](https://arxiv.org/pdf/2205.11491#page=30) once ran into an
incorrect formal statement in miniF2F that wrongly used truncating
subtraction.  Division of natural numbers or integers returns a
rational number in informal mathematics, not another natural number or
integer.  Square roots of negative numbers are either undefined or
return a complex number in informal mathematics, rather than
defaulting to zero as in mathlib.

A basic principle for formal statements is that they should not ask
the solver to prove something about junk values because those are not
part of the original problem statement.  This means adding extra
hypotheses or conclusions as needed to reflect the intended informal
meaning; it also leads to the principle above about using
appropriately restricted types for the domain of a function to avoid
the function in the formal statement having more (junk) information
than the function in the informal statement.  If a problem asks to
find the set of positive integers, say, with a given property, and the
formal statement uses a more relaxed type, say `answer: Set ℕ`, then
the property of being positive must be part of the formal statement,
to avoid the question arising of whether 0 satisfies the given
property.

It is only necessary for top-level expressions to be meaningful
without junk values rather than all subexpressions.  In particular,
there are some well-known expressions such as `n * (n - 1) / 2` where
it is well-known that the division always results in an integer and
immediately clear that the result of the expression is correct for all
`n : ℕ` even though `n - 1` uses a junk value for `n = 0`.  In those
cases, the well-known expression may be used without needing extra
hypotheses or casts to `ℚ`.  Similarly, when dividing by a value that
is obviously nonzero (typically because it is positive for structural
reasons such as being a sum of a positive value and a nonnegative
value), or taking the square root of a value that is obviously
nonnegative, such hypotheses may also be avoided.  An expression `a <
b - c` for `a b c : ℕ` is also valid (as when the subtraction uses a
junk value, the inequality is always false for both the junk value and
the mathematical result of the subtraction).

On rare occasions, a problem might explicitly use an expression for
which junk values are correct (for example, explicitly applying the
floor function to the division of positive integers).  In those cases,
the Lean operator with that truncating (or similar) effect may be used
directly.

Definitions that panic on some arguments, such as `getElem!`
(`some_list[index]!`), should not be used.

## Use of standard definitions

If a problem uses a standard mathematical concept or notation that is
defined in mathlib, the formal statement should use the corresponding
mathlib definition; if it uses a standard mathematical concept or
notation that should be defined in mathlib but is missing there, the
definition should be added to mathlib in order to use it in the formal
statement.

This applies even when the problem gives its own definition of the
standard concept for the benefit of contestants not familiar with the
terminology or notation.  For example, IMO 2024 P1 and IMO 2010 P1
define the floor function, but the floor function defined in mathlib
should be used rather than replicating the particular definition given
in an individual problem statement.  Similarly, IMO 2013 P3 defines
the excircle of a triangle and then uses that to define points of
tangency, but the definition of `touchpoint` for a simplex in mathlib
should be used rather than replicating the problem's own definition in
a problem statement.

If a problem refers to something happening eventually, or for
sufficiently large values of some expression, this is expressed
directly in the problem using appropriate inequalities, rather than
using `∀ᶠ` (`Filter.Eventually`) with `Filter.atTop`.  The two forms
can be translated to each other using `Filter.eventually_atTop`; note
that the `simp`-normal form is the one expressed directly with
inequalities, not the one with filters, so even in mathlib the version
with filters is arguably not the idiomatic one.

It is conventional in mathlib to use `<` rather than `>` in
statements, and these conventions follow that, even when the original
informal statement uses `>`.

Some standard concepts may be written in several different informal
ways, where it is immediately obvious that all are equivalent to the
same standard formal definition, and in such cases it is appropriate
to use the standard formal definition from mathlib rather than
replicating the details of how it was restated in a given problem.  In
particular, `Monotone`, `Antitone`, `StrictMono`, `StrictAnti`,
`Pairwise` and `Set.Pairwise` should be used as appropriate (including
`Set.Pairwise` on the coercion of a `Finset`, when a `Finset` is being
used); if values are given as pairwise different, this is
`Function.Injective`.  Monotonicity may be given in forms such as $a_1
\le a_2 \le \dots \le a_n$, which should still be translated to use
definitions such as `Monotone`.  Similarly, `Monovary` and `Antivary`
should be used when appropriate; the definitions allow one function to
take equal values when the other does not, but this is still
sufficient when the problem uses strict inequality if the functions
are given as injective (for example, IMO 2020 P4).  Bundled
`Function.Embedding` and `Equiv` should be used in problems where a
function, or combinatorial configuration information, is given
together with information about being injective or bijective.

The proposition that a value is the least or greatest with a given
property should be expressed using `IsLeast` or `IsGreatest`.  Note
that proving such a result includes proving that such a least or
greatest value exists; it is generally not valid from an informal
statement to assume that without proving it.

Statements about primality use `Nat.Prime` (or the combination of
being greater than 1 and not prime for a composite number).
Coprimality uses `Nat.Coprime`.  If all the (positive) divisors of a
positive integer are needed, use `Nat.divisors`; `Nat.primeFactors`,
`Nat.primeFactorsList` and `Nat.factorization` may be used when a
factorization is needed in a different form.

Statements about digits of a natural number use `Nat.digits` even for
statements about the final digits (such as IMO 1978 P1) or the number
of digits that might be mathematically more natural to reason about in
a form expressed with modular arithmetic or inequalities.  Note that
`Nat.digits` returns an empty list for `0`, unlike informal
convention.

To assert that a number in one type can be expressed in another type
(for example, that a real number is rational), use constructs such as
`x ∈ Set.range ((↑·) : ℤ → ℝ)`.

When a problem involves dividing some collection into two parts, it's
generally appropriate for the formal statement to refer to one part as
the complement of the other (using `ᶜ` or set difference as
appropriate) rather than separately naming the two parts and having
hypotheses on their union and (empty) intersection.  In such cases,
statements about the number of elements with some property in one part
may sometimes immediately imply such a statement for the other part,
and then only one part of such a statement needs to be given (in
definitions, hypotheses or conclusions).  See, for example, IMO 2020
P3, IMO 2021 P1 and IMO 2022 P1 (in the last case, the formal
statement asserts `2 * n` coins of which `n` are of one type, rather
than literally `n` of each type).

See subsequent sections for more details on the use of standard
definitions in the particular cases of graphs, games and geometry
problems.

Occasionally there is a standard concept for which no definition in
mathlib is appropriate because it makes more sense for the mathlib
idiom to be a direct expansion of a definition.  For example, rather
than having a mathlib definition for the concept of an angle being
acute it's appropriate just to use `θ < π / 2`.  (However, it's
appropriate to have a mathlib definition for the concept of a simplex
being acute-angled, which could be expressed in various different ways
and for which some associated API makes sense.)

## Use of local definitions

If a problem defines its own terminology, not appropriate for mathlib,
this should generally have a corresponding `def` in the formal problem
statement.  Such terminology is normally specific to the problem in
question; occasionally it might instead be inappropriate for mathlib
because it differs from a standard definition of the same term, or
because although the term is standard the meaning is context-specific
(for example, when problems refer to points or lines in "general
position", the precise ways in which the position is general depend on
the context, so a definition specific to the problem is appropriate).
Sometimes, most often in combinatorics problems, there may be a series
of linked definitions used to set up the context for the problem (for
example, types used to describe the configurations the problem deals
with).  If the problem defines its own notation (for example, naming a
function used in the problem statement), this should be treated the
same as the case where it defines terminology (gives words some
special meaning).

Even where a problem does not define its own terminology or notation,
it can sometimes be convenient to use a local `def` in the formal
statement.  As a general principle, if writing the formal statement in
a natural way without such a `def` would involving duplicating some
mathematical element of the problem (for example, a condition
satisfied by some mathematical object), the duplicated element should
be factored out into a local `def`.  If the formal statement does not
duplicate such an element, and that element does not have its own
terminology or notation in the informal statement, then it's
appropriate not to have a local `def` for that element in the formal
statement.

## Graphs

Some IMO combinatorics problems can be interpreted more or less
directly in terms of graphs.

If the problem explicitly refers to graphs (IMO 1991 P4) then
mathlib's graphs should be used in the formal statement, and the same
applies if the problem is essentially about graphs but using different
terminology rather than the word "graph" (e.g. IMO 2019 P3 or IMO 2023
shortlist C7).

Many more problems are not so directly about graphs (neither
explicitly about graphs, nor a graph theory problem in shallow
disguise), but may involve some kind of adjacency relation (e.g. IMO
2022 P6, IMO 2023 P5 or IMO 2024 P5).  Such problems should be
expressed without using mathlib graphs; they should be considered more
similar to problems that don't even involve an adjacency relation but
where graphs might nevertheless be of use in solving the problem
(e.g. IMO 2020 P3).

## Games

Some IMO combinatorics problems involve games, in the broad sense of a
sequence of dependent choices to be made by one or more players, where
each choice depends on information from the previous ones (either
information revealed in response to the previous choices, or moves
made by other players in response to those choices).

Most such games do not fit readily with the mathlib `SetTheory.PGame`
(Conway-style two-player well-founded games of perfect information,
where the player unable to move loses).  A game may have imperfect
information, or only one player, or ask to determine something other
than a winner, such as the highest score a player can guarantee
(e.g. IMO 2018 P4) or how quickly a player can guarantee to end the
game (e.g. IMO 2024 P5).  A game might not be well-founded (infinite
plays might be possible), or the fact that it terminates (or that one
player can ensure it terminates) might be part of what has to be
proved.

Thus, rather than using `SetTheory.PGame` in the limited cases where
it matches the game in question closely enough, ad hoc types should be
used for all problems about games.  This makes the formulations of
such problems more similar to each other than if a small proportion of
cases used `SetTheory.PGame`.  It also makes such formulations more
similar to those of problems with a single player (possibly not
expressed in those terms) and perfect information, but still involving
dependent choices and asking about whether a configuration with some
property can be achieved (e.g. IMO 2010 P5 or IMO 2019 P3).

When defining types for strategies or similar, it is important to
ensure that strategies only depend on information legitimately
available to the player, not on information not (yet) revealed to
them, whether as part of the type or part of a hypothesis that a
strategy is valid.

Games also pose complications for avoiding junk values in the objects
the problem asks about.  In principle, a strategy for a game only
needs to give a move in positions that could be reached by following
the strategy.  Defining a type for strategies that is so heavily
dependently typed to avoid any unnecessary information is likely to be
awkward, however, so a type for strategies may include junk
information about moves chosen in unreachable positions (provided it
is ensured that a strategy gives a valid move whenever one exists and
the position is reachable).

## Geometry

The following conventions for geometry problems are based on ones
originally developed for formalizing IMO 2019 P2.

A problem is assumed to take place in the plane unless that is clearly
not intended, so it is not required to prove that the points are
coplanar (whether or not that in fact follows from the other
conditions).  The context for a geometry problem is thus of the form

```lean
variable {V P : Type*}
variable [NormedAddCommGroup V] [InnerProductSpace ℝ V] [MetricSpace P]
variable [NormedAddTorsor V P]
variable [Fact (finrank ℝ V = 2)]
```

where these lines may be reformatted as needed, and `V` and `P` may be
renamed (in particular, if the problem has points by those names).  If
a problem (typically combinatorial geometry) references coordinates,
then instead `EuclideanSpace ℝ (Fin 2)` is used.

A reference to an angle `∠XYZ` is taken to imply that `X` and `Z` are
not equal to `Y`, in accordance with the general principles on
avoiding junk values, and those implications are included as
hypotheses for the problem whether or not they follow from the other
hypotheses.

Similarly, a reference to `XY` as a line (or ray) is taken to imply
that `X` does not equal `Y` and that is included as a hypothesis, and
a reference to `XY` being parallel to something is considered a
reference to it as a line.  A reference to `XY` meeting or
intersecting something (probably a line or circle) is also considered
a reference to it as a line.  Saying that `XY` and `AB` meet or
intersect at `P` is considered to mean that `P` lies in the
intersection (but does not assert that the two lines are different, so
possibly other points could lie in the intersection as well).

However, such an implicit hypothesis about two points being different
is included only once for any given two points (even if it follows
from more than one reference to a line or an angle), if `X ≠ Y` is
included then `Y ≠ X` is not included separately, and such hypotheses
are not included in the case where there is also a reference in the
problem to a triangle including those two points, or to strict
betweenness of three points including those two, or to one point being
a vertex of a triangle (or on a side, or on a line between two
vertices, including more specific constructions such as the midpoint
of a side) and the other point being in its interior (including more
specific constructions guaranteed to be in the interior, such as the
centroid or incenter); a point on the circumcircle of a triangle,
constructed as the second intersection with the circumcircle of a line
through a vertex and an interior point of the triangle, does not need
a hypothesis that it is different from any point on the boundary of
the triangle.  If a center cannot equal a vertex of a triangle (for
example, the circumcenter), no hypothesis is needed that they are
different.  A reference to a triangle is taken to mean a nondegenerate
triangle.

A reference to a circle is taken to mean one with positive radius (not
included in the definition of `Sphere` in mathlib), but the implicit
hypothesis on the radius can be omitted in cases where it is
sufficiently obvious from the other hypotheses, such as when it is
specified as a circumcircle, incircle or excircle of a triangle or
when two distinct points are given on the circle.

Where such references implying some form of nondegeneracy appear in
the conclusion of a problem rather than as a hypothesis of the
problem, the corresponding formal statement appears as part of the
formal conclusion rather than as a hypothesis (for example, if the
conclusion of a problem asks something about the circumcircle of a
triangle `XYZ` that was not mentioned in the hypotheses, the fact that
those points do form a nondegenerate triangle is considered something
to be proved).

If a line or plane is referred to other than by naming points that
produce it as an affine span, a hypothesis on the `finrank` of the
`AffineSubspace` is sufficient to assert that it is a line or a plane,
without needing to add an explicit `FiniteDimensional` hypothesis
(since any finite (nonzero) `finrank` implies `FiniteDimensional`).

If betweenness is stated, it is taken to be strict betweenness.
However, segments and sides are taken to include their endpoints
(unless this makes a problem false), although those degenerate cases
might not necessarily have been considered when the problem was
formulated and contestants might not have been expected to deal with
them.  A reference to a point being on a side or a segment is
expressed directly with `Wbtw` rather than more literally with
`affineSegment`.

Concurrency of lines, circles or other geometrical elements is
represented as the intersection being a nonempty set of points; the
same applies where such elements are set to "intersect" or "meet".  If
they are said to concur, intersect or meet at a named point, that is
represented as the point being an element of the intersection (of the
infimum, if all the elements in question are lines or other affine
subspaces).  Thus, these terms are taken to include the case where two
or more lines might be the same line.

Distance between a point and a line (or other set) uses
`Metric.infDist`.

A reference to an incircle or excircle of a triangle being tangent to,
meeting or touching a side, side line or ray extending a side is
represented as saying that point is the corresponding `touchpoint`
rather than literally replicating the particular way this is stated in
each problem.

## Geometrical statements in non-geometry problems

Geometrical statements often appear in non-geometry and combinatorial
geometry problems.

In general, those are to be expressed literally in formal statements.
However, some limited cases are considered purely combinatorial and so
expressed as such: problems with rectangular or triangular grids or
points ordered round a circle where the geometric elements are purely
adjacency or otherwise purely combinatorial of a very trivial form are
not expressed geometrically in Lean.  Saying that three numbers form
the sides of a triangle, e.g. IMO 2009 P5, is also considered as a
collection of inequalities, not a geometrical statement.

## Missing definitions in mathlib

The following are the geometry problems from IMO 2006 onwards.  For
each problem, I have indicated what extra definitions I think should
be added to mathlib for stating those problems cleanly in accordance
with these conventions (the complexity of those definitions and the
amount of associated API needed would vary substantially, and quite
likely significantly more material would be needed by solutions but
not by statements).  I don't think there are any such significant gaps
in API for non-geometry problems without geometrical elements, or
missing definitions for those problems listed as "OK" in this list.

* IMO 2006 P1: OK.
* IMO 2007 P2: parallelogram, cyclic quadrilateral, angle bisector.
* IMO 2007 P4: angle bisector, area of triangle.
* IMO 2008 P1: OK.
* IMO 2008 P6: convex quadrilateral, ray beyond.
* IMO 2009 P2: OK.
* IMO 2009 P4: angle bisectors.
* IMO 2010 P2: arcs.
* IMO 2010 P4: OK.
* IMO 2011 P6: triangle determined by lines.
* IMO 2012 P1: OK.
* IMO 2012 P5: OK.
* IMO 2013 P3: right-angled triangle not specifying which vertex.
* IMO 2013 P4: OK.
* IMO 2014 P3: convex polygons (quadrilateral).
* IMO 2014 P4: OK.
* IMO 2015 P3: cyclic order of five points on a circle.
* IMO 2015 P4: cyclic order of five points on a circle.
* IMO 2016 P1: angle bisectors.
* IMO 2017 P4: major and minor arcs.
* IMO 2018 P1: major and minor arcs.
* IMO 2018 P6: convex quadrilateral and its interior.
* IMO 2019 P2: OK.
* IMO 2019 P6: OK.
* IMO 2020 P1: convex quadrilateral and its interior, angle bisectors.
* IMO 2021 P3: OK.
* IMO 2021 P4: convex quadrilateral, ray beyond.
* IMO 2022 P4: convex pentagon and its interior.
* IMO 2023 P2: midpoint of arc, angle bisector.
* IMO 2023 P6: OK.
* IMO 2024 P4: OK.
* IMO 2025 P2: OK.

The following are non-geometry and combinatorial geometry problems in
that period for which a formal statement with geometrical elements
would be appropriate in accordance with these conventions, again
indicating what definitions should be added.

* IMO 2006 P2: regular polygon and its interior (though arguably only technically geometrical for intersection of chords etc.).
* IMO 2006 P6: convex polygon and its interior, area of a triangle and the polygon.
* IMO 2007 P6: OK.
* IMO 2011 P2: OK.
* IMO 2013 P2: OK.
* IMO 2013 P6: OK (only technically geometrical for intersection of chords).
* IMO 2014 P6: area (for defining finite regions, though being bounded would be more natural in the absence of that definition).
* IMO 2015 P1: OK.
* IMO 2016 P3: convex (cyclic) polygon, area of that polygon.
* IMO 2017 P3: OK.
* IMO 2018 P4: OK (only technically geometrical for \sqrt{5} distance)
* IMO 2020 P6: OK.
* IMO 2025 P1: OK.

The following are pre-2006 problems where some definition not in the
above lists seems appropriate to add to mathlib for a clean formal
statement in accordance with these conventions, or something otherwise
seems useful to remark about what definitions would be used.  In the
following list, problems are not mentioned if all definitions needed
are either already present in mathlib, or included in the
2006-and-later lists above.  Unlike the above lists, the wording
originally given to contestants was not generally available for
preparing the pre-2006 list.

* IMO 1959 P4: geometrical construction
* IMO 1959 P5: regular polygon (for square as case thereof)
* IMO 1959 P6: geometrical construction (in 3D), (isosceles trapezium / trapezoid), quadrilateral with circle inscribed
* IMO 1960 P4: geometrical construction
* IMO 1960 P6: cone and cylinder with inscribed sphere and their volumes
* IMO 1960 P7: (isosceles trapezium / trapezoid)
* IMO 1961 P5: geometrical construction
* IMO 1962 P5: geometrical construction, quadrilateral with circle inscribed
* IMO 1962 P6: (isosceles triangle not specifying which two edges equal)
* IMO 1963 P3: polygon and its interior angles (note that interior angles of a polygon aren't one of the kinds of angle currently in mathlib)
* IMO 1964 P3: area of a circle
* IMO 1964 P6: volume of a tetrahedron
* IMO 1965 P3: distance between two lines / between line and plane, (line being parallel to plane), angle between two (not coplanar) lines in 3D
* IMO 1966 P2: (isosceles triangle not specifying which two edges equal)
* IMO 1967 P1: parallelogram as a solid shape with its interior
* IMO 1967 P2: volume of a tetrahedron
* IMO 1967 P4: geometrical construction
* IMO 1971 P2: convex polyhedron and its vertices
* IMO 1972 P2: dissection of quadrilateral into quadrilaterals (= tiling of quadrilateral by quadrilaterals, roughly)
* IMO 1973 P4: length of a path in the plane (is this in mathlib?)
* IMO 1976 P3: tiling in 3D
* IMO 1978 P2: interior of a sphere
* (IMO 1979 P2 not considered geometrical, would be formalized purely combinatorially)
* IMO 1984 P5: perimeter of a polygon
* IMO 1986 P4: center of regular polygon
* IMO 1990 P2: two arcs determined by the endpoints
* (IMO 1992 P5: coordinate planes for projections onto them - even if statement formalized geometrically, probably too specific for mathlib definition)
* IMO 1996 P5: perimeter of a polygon
* IMO 2004 P3: tiling (of a rectangle)
