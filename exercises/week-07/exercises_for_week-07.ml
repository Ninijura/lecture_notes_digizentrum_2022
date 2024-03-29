(* exercises for week-07 of Einführung ins Programmieren *)
(* Version of 2023-02-27 *)
(* kira@tailorsoft.de *)


let test_nter_nachfolger kandidat =
  let b1 = (kandidat 0 = 0)
  and b2 = (kandidat 3 = 3)
  and b3 = (kandidat 17 = 17)
  in b1 && b2 && b3;;


let rec nter_nachfolger x =
  if x = 0
  then 0
  else 1 + (nter_nachfolger (x - 1));;


let nter_nachfolger_korrekt = test_nter_nachfolger nter_nachfolger;; 


(* Basierend auf der obigen Funktion können wir eine Verdoppelungs-Funktion *)
(* definieren. Wie bekannt schreiben wir erst einen Test, dann die Funktion, und *)
(* zuletzt überprüfen wir, ob die Funktion den Test besteht. *)

(* Hier ist eine neue Art, einen Test zu schreiben. Die Funktionsweise ist genau so *)
(* wie wir sie in Woche-06 gesehen haben, aber das ganze ist ein wenig *)
(* übersichtlicher strukturiert. Mehr dazu im nächsten Kapitel.*)

let test_verdoppel kandidat =
  let b1 = (kandidat 0 = 0)
  and b2 = (kandidat 4 = 8)
  and b3 = (kandidat 1 = 2)
  and b4 = (kandidat 21 = 42)
  in b1 && b2 && b3 && b4;;


let rec verdoppel x =
  if x = 0
  then 0
  else 2 + (verdoppel (x - 1));;


let verdoppel_korrekt = test_verdoppel verdoppel;;


(* Übung 33 *)
(* Schreibe einen Test für eine verdreifachungs-Funktion für natürliche Zahlen. *)


(* Schreibe eine Verdreifachungs-Funktion für natürliche Zahlen nach den obigen *)
(* Beispielen. *)


(* Wende deinen Test auf deine verdreifaungs-Funktion an. *)


(* Übung 34 *)

(* Probiere Kombinationen wie: *)
(* let x = 1;; *)
(* let y = "hi";; *)
(* let z = 15 and y = 26 in x + y + z;; *)
(* etc... *)


(* Übung 35 *)

(* Schreibe deinen Test für die Verdreifachungs-Funktion um, so dass du für jeden *)
(* Testfall eine Lokale Variable definierst und hinterher nur noch die Variablen *)
(* zusammensetzen musst.  *)



(* Übung 36 *)

(* Faktorialfunktion: *)
(* Basisfall:      0! = ...
   Induktionsfall: n! = ... *)

(* let test_faktorial kandidat = ... *)


(* let rec fak n = ... *)


(* let fak_korrekt = test_faktorial fak;; *)


(* Übung 37 *)

(* Fibonacci-Funktion: *)
(* Basisfall:        fib 0 = ... *)
(* Induktionsfall:   fib n = ... *)


(* let test_fib kandidat = ... *)


(* let rec fib x = ... *)


(* let fib_korrekt = test_fib fib;; *)



(* end of file *)
