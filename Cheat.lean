theorem add_comm:
  ∀ a b: Prop, a /\ b -> b /\ a := by
  intros a b H
  cases H with
  | intro H1 H2 =>
    exact ⟨H2, H1⟩

theorem and_comm':
  ∀ a b: Prop, a /\ b -> b /\ a := by
  intros a b H
  cases H with
  | intro H1 H2 =>
    apply And.intro -- constructor
    case left => exact H2
    case right => exact H1

theorem add_comm'':
  ∀ a b: Prop, a /\ b -> b /\ a := by
  intros a b H
  cases H
  apply And.intro
  case left => assumption
  case right => assumption

theorem add_comm''':
  ∀ a b: Prop, a /\ b -> b /\ a := by
  intros a b H
  have H1 := H.left
  have H2: b := H.right
  exact And.intro H2 H1

theorem plus_assoc:
  forall x y z: Nat,
  (x+y) + z = x + (y + z) := by
intros x y z
induction x with
| zero => simp
| succ x IH =>
  repeat rw [Nat.succ_add]
  rw [IH]

theorem list_cons_ne_nil (x : α) (xs : List α):
  x :: xs ≠ [] := by
  intro h'
  contradiction

open List

theorem length_gt_zero (xs: List α):
  xs ≠ [] -> 0 < length xs := by
intros h
induction xs with
| nil =>
  contradiction
| cons x xs' ih =>
  simp <;> apply Nat.zero_lt_succ

