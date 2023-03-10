(* exercises for week-08 of Einführung ins Programmieren *)
(* Version of 2023-03-10 *)
(* kira@tailorsoft.de *)


(* Eine ausgeschriebene Version des Typen für natürliche Zahlen *)


type nat_v1 =
  | Null
  | Nachfolger of nat_v1;;


(* Eine leserlichere Version des Typen der natürlichen Zahlen. *)

type nat =
  | O
  | S of nat;;



(* Platzhalter-Funktionen, die genutzt werden können um den Test auszuführen. Das *)
(* Ergebnis des Tests sollte in dem Fall aber false sein. *)

let int_to_nat i = O;;

let nat_to_int n = 0;;

(* Übung 38 *)

(* Erweitere die Testfunktion unten. *) 

let test_int_nat_konvertierung kandidat_itn kandidat_nti =
  let b1 = (kandidat_itn 0 = O)
  and b2 = (kandidat_itn (kandidat_nti (S (S (S O)))) = S (S (S O)))
  and b3 = (kandidat_nti (kandidat_itn 15) = 15)
  and b4 = (kandidat_nti (S O) = 1)
             (* etc... *)
  in b1 && b2 && b3 && b4;;

(* Bearbeite entweder die obige Testfunktion so, dass du die Ergebnisse für jede *)
(* einzelne Funktion als Teil eines Tupels bekommst, oder schreibe weitere *)
(* Testfunktionen für jede der beiden Funktionen int_to_nat und nat_to_int. *)



(* Übung 39 *)

(* Schreibe eine Funktion, die Integer natürlichen Zahlen umwandelt. *)

(* let rec int_to_nat i = 
   if i <= 0 
   then ...
   else ... ;; *)


(* Führe den Test für die int_to_nat Funktion aus um zu sehen, ob deine Funktion *)
(* richtig ist. *)



(* Übung 40 *)

(* Benutze match um eine Vorgänger-Funktion für natürliche Zahlen zu schreiben. *)

(* Du bekommst den Test von mir geschenkt. *)

let test_vorgaenger_nat kandidat =
  let b1 = (kandidat O = O)
  and b2 = (kandidat (S O) = O)
  and b3 = (kandidat (S (S O)) = (S O))
  and b4 = (kandidat (S (S (S (S (S (S (S O))))))) = (S (S (S (S (S (S O)))))))
  (* etc. *)
  in b1 && b2 && b3 && b4;;


(* let vorgaenger_nat n =
     match n with
     ...;; *)


(* überprüfe ob deine Funktion den Test besteht. *)

(* let vorgaenger_nat_korrekt = test_vorgaenger_nat vorgaenger_nat;; *)




(* Übung 41 *)

(* Hier ist ein Anfang für eine Testfunktion. Füge selbst mehr Testfälle hinzu. *)

let test_vorvorgaenger_nat kandidat =
  let b1 = (kandidat O = O)
  and b2 = (kandidat (S (S (S (S (S (S (S O))))))) = (S (S (S (S (S O))))))
             (* etc. *)
  in b1 && b2;;

(* let vorvorgaenger_nat n = 
     match n with 
     | ...
     | ...
     | ... ;; *)




(* Übung 42 *)

(* schreibe die nat_to_int Funktion *)








(* end of file exercises_for_week-08.ml *)
