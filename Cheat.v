Lemma add_comm:
  forall a b:Prop, a /\ b -> b /\ a.
Proof.
  intros a b H.
  destruct H as [H1 H2].
  split.
  - exact H2.
  - exact H1.
Qed.

Theorem plus_assoc :
 forall x y z:nat, (x+y)+z = x+(y+z).
Proof.
induction x as [ | x0 IHx0].
- simpl; reflexivity.
- simpl. intros y z. rewrite IHx0. reflexivity.
Qed.

Require Export Coq.Lists.List.
Export Coq.Lists.List.ListNotations.

Theorem list_cons_ne_nil (A: Type) (x : A) (xs : list A):
  x :: xs <> [].
  intros h'.
  discriminate.
Qed.

Require Import Coq.micromega.Lia.

Theorem length_gt_zero:
  forall {A: Type} (xs: list A),
  xs <> [] -> 0 < length xs.
Proof.
induction xs.
- contradiction.
- cbn.
  lia.
Qed.