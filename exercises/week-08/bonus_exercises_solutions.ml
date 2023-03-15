(* bonus exercises for Einführung ins Programmieren *)
(* Version of 2023-03-10 *)
(* kira@tailorsoft.de *)



(* Bonusübung 1 *)

type ganz =
  | O
  | S of ganz
  | P of ganz;;

(* achtung, wenn du die Konstruktoren O und S für nats benutzen möchtest, musst du *)
(* denen für Ganzzahlen andere Namen geben. *)

(* Bonusübung 2 *)

let test_vorgaenger_ganz kandidat =
  let b1 = (kandidat O = P O)
  and b2 = (kandidat (S O) = O)
  and b3 = (kandidat (P O) = P (P O))
  and b4 = (kandidat (S (S (S O))) = S (S O))
  and b5 = (kandidat (P (P (P O))) = P (P (P (P O))))
  in b1 && b2 && b3 && b4 && b5;;

    
let vorgaenger_ganz g =
  match g with
  | O -> P O
  | S n -> n
  | P _ -> P g;;


let vorgaenger_ganz_korrekt = test_vorgaenger_ganz vorgaenger_ganz;;

(* Du könntest auch das folgende schreiben, das ist allerdings unelegant und macht *)
(* ursprünglich positive Zahlen immer länger. Außerdem ist das Ergebnis dabei nicht *)
(* eindeutig und du kannst keinen vernünftigen Test dafür schreiben. *)

let vorgaenger_ganz_schlecht g = P g;;



let test_nachfolger_ganz kandidat =
  let b1 = (kandidat O = S O)
  and b2 = (kandidat (S O) = S (S O))
  and b3 = (kandidat (P O) = O)
  and b4 = (kandidat (P (P O)) = P O)
  and b5 = (kandidat (S (S O)) = S (S (S O)))
  in b1 && b2 && b3 && b4 && b5;;


let nachfolger_ganz g =
  match g with
  | O -> S O
  | P n -> n
  | S _ -> S g;;


let nachfolger_ganz_korrekt = test_nachfolger_ganz nachfolger_ganz;;


(* Bonusübung 3 *)


let test_int_to_ganz kandidat =
  let b1 = (kandidat 0 = O)
  and b2 = (kandidat 1 = S O)
  and b3 = (kandidat 3 = S (S (S O)))
  and b4 = (kandidat (-1) = P O)
  and b5 = (kandidat (-2) = P (P O))
  in b1 && b2 && b3 && b4 && b5;;


let rec int_to_ganz i =
  if i = 0 then O
  else if i < 0
  then P (int_to_ganz (i+1))
  else S (int_to_ganz (i-1));;

let int_to_ganz_korrekt = test_int_to_ganz int_to_ganz;;


let test_ganz_to_int kandidat =
  let b1 = (kandidat O = 0)
  and b2 = (kandidat (S O) = 1)
  and b3 = (kandidat (S (S O)) = 2)
  and b4 = (kandidat (P O) = (-1))
  and b5 = (kandidat (P (P (P (P (P (P O)))))) = (-6))
  in b1 && b2 && b3 && b4 && b5;;

let rec ganz_to_int g =
  match g with
  | O -> 0
  | S n -> 1 + (ganz_to_int n)
  | P n -> (ganz_to_int n) - 1;;


let ganz_to_int_korrekt = test_ganz_to_int ganz_to_int;;


(* Bonusübung 4 *)

(* Funktion aus tools kopiert. *)

let rec normalise_g g =
  let rec visit rest acc repeat =
    match rest with
    | O -> if repeat then normalise_g acc else acc
    | S (P n) -> visit n acc true
    | P (S n) -> visit n acc true
    | S n -> visit n (S acc) repeat
    | P n -> visit n (P acc) repeat
  in visit g O false;;


(* Schreibe Plus, Minus und Mal für Ganzzahlen. *)

let test_plus_g kandidat =
  let b1 = (kandidat O O = O)
  and b2 = (kandidat (S O) O = (S O))
  and b3 = (kandidat (P O) O = P O)
  and b4 = (kandidat (P O) (S O) = O)
  and b5 = (kandidat (S (S (S (S O)))) (P O) = (S (S (S O))))
  in b1 && b2 && b3 && b4 && b5;;

let rec plus_g g1 g2 =
  match g1 with
  | O -> normalise_g g2
  | S g -> plus_g g (S g2)
  | P g -> plus_g g (P g2);;

let plus_g_korrekt = test_plus_g plus_g;;






(* end of file *)
