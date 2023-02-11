(* Der OCaml-Code für die Übungen in Woche 06 *)
(* kira@tailorsoft.de *)
(* version of 2023-02-11 *)



(* Der Test für die Nachfolger-Funktion *)
(* Übung 29: füge noch ein paar Tests zu dieser Funktion hinzu. Danach lies den Code *)
(* neu in deinem OCaml-Prozess ein und übeprüfe ob die Nachfolger-Funktion noch immer *)
(* den Test besteht. *) 
let test_nachfolger kandidat = 
  (kandidat 0 = 1)
  && (kandidat 1 = 2) 
  && (kandidat 41 = 42)
  && (kandidat (-4) = (-3))
(* etc *) ;;

(* eine Implementation der Nachfolger-Funktion *)
let nachfolger_v1 x =
  x + 1;;

let nachfolger_v1_korrekt = test_nachfolger nachfolger;;



(* Übung 30a: schreibe einen Test für die Vorgänger-Funktion *)
let test_vorgaenger kandidat =
  (kandidat 1 = 0)
  && (kandidat 5 = 4)
(* etc. *);; 


(* Übung 30b: schreibe eine Vorgänger-Funktion und überprüfe sie indem du den Wert *)
(* "vorgaenger_v1_korrekt" definierst; orientiere dich am obigen Beispiel. *)
let vorgaenger_v1 x =
  "..." ;;

let vorgaenger_v1_korrekt = false;;



(* Übung 31 *)
(* fülle im folgenden die Tests und die Funktionskörper aus. Überprüfe danach, ob *)
(* deine Funktion die Tests besteht. *)

let test_groessere_von_zweien kandidat =
  () (* ... *) ;;


let groessere_von_zweien_v1 m n =
  () (*...*);;

let groessere_von_zweien_v1_korrekt = false;;



let test_kleinere_von_zweien kandidat =
  () (* ... *) ;;


let kleinere_von_zweien_v1 m n =
  () (*...*);;

let kleinere_von_zweien_v1_korrekt = false;;



(* ein Beispiel für einen Test, der nicht genug Fälle testet und eine Funktion, die *)
(* falsch ist, den Test aber trotzdem besteht. *)

let test_groessere_von_zweien_falsch kandidat =
  (kandidat 1 2 = 2)
  && (kandidat 4 19 = 19)
  && (kandidat (-1) 4 = 4)
  && (kandidat 0 42 = 42)
  && (kandidat 3 3 = 3);;

let groessere_von_zweien_falsch m n = n;;

let groessere_von_zweien_falsch_korrekt =
  test_groessere_von_zweien_falsch groessere_von_zweien_falsch;; 


(* und jetzt mit eurer Test-funktion *)

let groessere_von_zweien_falsch_tatsaechlich_korrekt =
  test_groessere_von_zweien groessere_von_zweien_falsch;;




(* Übung 32 *)

(* schreibe einen falschen Test für die Funktion, die von zwei Integer-Inputs den *)
(* kleineren als Output gibt. *) 
let test_kleinere_von_zweien_falsch kandidat =

  () (* ... *);;

(* schreibe eine Funktion, die nicht immer den kleineren von ihren zwei *)
(* Integer-Inputs als Output gibt, aber dennoch von deinem falschen Test nicht *)
(* entlarvt wird. *) 
let kleinere_von_zweien_falsch m n =
  () (* ... *) ;;

(* das Resultat hier sollte true sein *)
let kleinere_von_zweien_falsch_korret =
  test_kleinere_von_zweien_falsch kleinere_von_zweien_falsch;;

(* das Resultat hier sollte false sein *)
let kleinere_von_zweien_falsch_tatsaechlich_korrekt =
  test_kleinere_von_zweien kleinere_von_zweien_falsch;; 





let rec nter_nachfolger x =
  if x = 0
  then 0
  else 1 + (nter_nachfolger (x - 1));;


let rec verdoppel x =
  if x = 0
  then 0
  else 2 + (verdoppel (x - 1));;


(* Übung 33 *)
(* Schreibe einen Test für eine verdreifachungs-Funktion für natürliche Zahlen. *))


(* Schreibe eine Verdreifachungs-Funktion für natürliche Zahlen nach den obigen *)
(* Beispielen. *)


(* Wende deinen Test auf deine verdreifaungs-Funktion an. *)




(* end of exercises_for_week-06.ml *)
