# Cheat Sheet: Coq Proof Assistant to LeanProver

## Quick Start tips

- Lean is space sensitive and uses newlines instead of dots.
- The `by` keyword is used to invoke proof mode. Trust us and just put the `by` keyword on the same line as the `:=`. So always write `... := by` followed by a newline.
- Use VS Code and install the [lean4 extension](https://github.com/leanprover/vscode-lean4).

## Quick Reference Table

| Coq | Lean |
| --- | ---  |
| Theorem | theorem |
| admit | sorry |
| reflexivity | rfl |
| exact | exact |
| apply | apply |
| intros | intros |
| rewrite H | rewrite [H], rw [H] |
| rewrite <- H | rewrite [<- H], rw [<- H] |
| assumption | assumption |
| cbn | dsimp |
| simpl | simp |
| auto | simp |
| unfold | unfold |
| discriminate | contradiction |
| contradiction | contradiction |
| constructor | constructor |
| case | cases |
| elim | cases |
| destruct | cases |
| induction | induction |
| ; | <;> |
| - | `\.` |
| repeat | repeat |
| try | try |
| A\|B | (first\|A\|B)
| subst | subst_vars |
| generalize dependent | revert |
| remember | have |
| refine | refine |
| specialize | specialize |
| split | apply And.intro |
| symmetry | apply Eq.symm |
| left | left (requires mathlib) |
| right | right (requires mathlib) |
| ring | requires mathlib |
| exists | use (requires mathlib) |
| lia | linarith (requires mathlib) |
| inversion | ? |

## Details about Tactics

### intros

In Coq intros, introduces all hypotheses, but in Lean intros needs to name every hypothesis that it introduces. `intro` does not exist.

### destruct

Coq:

```
destruct H as [H1 H2]
```

Lean:

```
cases H with
| intro H1 H2 =>
```

### split

split is a different tactic in Lean, but you can use `constructor` or `apply And.intro`.

```
constructor
case left => exact H2
case right => exact H1
```

```
apply And.intro
case left => exact H2
case right => exact H1
```

### rewrite

`rewrite H` in Coq is `rewrite [H]` in Lean
`rw [H]` is the same as `rewrite [H]` followed by `try rfl`

Reverse rewriting in Coq is done:

```
rewrite <- H
```

In Lean we can provide a list so we put the rule in braces: `rewrite [<- H]`.

### cbn

`dsimp` was the closest we could find.

### simpl

`simp` is kind of the same, but more powerful, as it includes at least reflexivity.

`simp only` is less powerful

`simp only [Nat.add_zero]` only uses the theorems in the list to simplify

`simp [Nat.add_zero]` uses the theorems in the list to simplify and also all the usual theorems

Other variants include: `simp_all`, `simp [*]`, `simp [*] at *`, `simp at H`

See the [Lean Tactics file](https://github.com/leanprover/lean4/blob/master/src/Init/Tactics.lean) for more documentation.

### remember

See the [Tatics chapter of Theorem proving in Lean 4](https://leanprover.github.io/theorem_proving_in_lean4/tactics.html#structuring-tactic-proofs) for how to use `have`.

### induction

Coq:

```
induction x as [ | x0 IHx0].
- ...
- ...
```

In Lean you need to intro a variable before you can do induction on it:

```
intros x
induction x
case zero =>
  ...
case succ x0 IHx0 =>
  ...
```

### refine

In Lean instead of using `_` use `?_`

`refine (Or.intro_right _ ?_)`

Here the `_` is the inferred type and the `?_` is the hole to prove in the next step.

### auto

`auto` in Coq is like `simp` in Lean, because it is also extensible. You can add more theorems to this tactic by annotating the theorems with `@[simp]`.

### Other useful tactics

Lean requires all hypothesis that you intend to use to be named. You can use the `rename_i` tactic to rename the most recent inaccessible names in your context.

## Searching for theorems

Mathlib4 has several alternatives for finding theorems and next steps, see:

- #find
- apply?
- exact?
- rewrite?

## Ltac

[quote4](https://github.com/gebner/quote4) is a great meta programming library that by chance also allows you to do pattern matching on the goal and hypothesis. It does not include the capabilities of Coq's `context`, but we found in all those cases we could just `try rewrite ...`.

Using this library we have made an attempt to recreate [Ltac in Lean](https://github.com/katydid/proofs/blob/main/Katydid/Std/Ltac.lean).

Using this Ltac library we created a tactic to automate proofs about lists, called [balistic](https://github.com/katydid/proofs/blob/main/Katydid/Std/Balistic.lean).

## References

- [Tactics chapter of Theorem Proving in Lean4](https://leanprover.github.io/theorem_proving_in_lean4/title_page.html)
- [Lean Tactics File](https://github.com/leanprover/lean4/blob/master/src/Init/Tactics.lean)

## Authors

- [Paul Cadman](https://www.linkedin.com/in/paul-cadman/)
- [Gregor Feierabend](https://www.linkedin.com/in/gregorfeierabend/)
- [Walter Schulze](https://awalterschulze.github.io/)

