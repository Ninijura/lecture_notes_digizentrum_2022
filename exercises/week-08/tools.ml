(* tools for bonus exercises Einführung ins Programmieren Digitalzentrum Süderbrarup. *)
(* version of 2023-03-15 *)
(* kira@tailorsoft.de *)

(* Stelle sicher, dass du die folgende Typendefinition eingelesen hast. *)
(* type ganz = O | S of ganz | P of ganz;;*)


let test_normalise candidate =
  let b1 = (candidate O = O)
  and b2 = (candidate (S O) = S O)
  and b3 = (candidate (P O) = P O)
  and b4 = (candidate (P (S O)) = O)
  and b5 = (candidate (S (P O)) = O)
  and b6 = (candidate (S (P (P (S (P (S (S O))))))) = S O)
  in b1 && b2 && b3 && b4 && b5 && b6;;

let rec normalise_g g =
  let rec visit rest acc repeat =
    match rest with
    | O -> if repeat then normalise_g acc else acc
    | S (P n) -> visit n acc true
    | P (S n) -> visit n acc true
    | S n -> visit n (S acc) repeat
    | P n -> visit n (P acc) repeat
  in visit g O false;;


let normalise_correct = test_normalise normalise_g;;
