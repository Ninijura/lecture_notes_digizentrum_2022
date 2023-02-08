=====================================================
Zehn Minuten denken sparte zehn Stunden programmieren
=====================================================

Die einfachste Art eine Funktion zu durchdenken bevor wir sie
schreiben ist indem wir einen Test schreiben.

Wir haben letze Wochen Funktionen gesehen, die andere Funktionen als
Output haben. Diese Woche arbeiten wir mit Funktionen, die andere
Funktionen als Parameter haben.


Die Nachfolger-Funktion
=======================

Die Nachfolger-Funktion ist die Funktion, die für einen ``int`` x als
Input den ``int`` x+1 als Output gibt. 

Wenn wir einen Test für die Nachfolger-Funktion schreiben möchten,
dann können wir nicht die gesamte Funktion testen, sondern müssen uns
ein paar Zahlen aussuchen, für die wir testen.

Zum Beispiel:

::

   let test_nachfolger kandidat = 
       (kandidat 0 = 1)
    && (kandidat 1 = 2) 
    && (kandidat 41 = 42)
    && (kandidat (-4) = (-3))
    (* etc *) ;;


Wenn wir diese funktion auf eine Funktion anwenden, die ein Kandidat
für die Nachfolger-Funktion ist, dann passiert folgendes:

* der Kandidat wird auf 0 angewendet und es wird überprüft ob das
  Ergebnis 1 ist; falls ja, dann wird

* der Kandidat auf 1 angewendet und überprüft ob das Ergebnis 2 ist,
  falls ja, dann wird 

* der Kandidat auf 41 angewendet und überprüft ob das Ergebnis 42 ist,
  falls ja, dann wird

* der Kandidat auf -4 angewendet und überprüft ob das Ergebnis -3 ist,
  falls ja,

* dann wird ``true`` als Ergebnis des Tests ausgedruckt.

Falls in einem der obigen Schritte das Ergebnis des Kandidaten nicht
das erwartete ist, ist das Ergebnis des Tests ``false``.

Die Logik hinter dem ganzen ist, dass wir den Kandidaten mit
verschiedenen Inputs überprüfen. Jeders Resultat wird mit dem
Boolschen Test ``=`` überprüft und das Ergebnis ist ein Boolean, der
angibt, ob das Resultat so ist wie erwartet.

Die ``&&`` zwischen den einzelnen Tests sind eine weitere Boolsche
Funktion, die wir am Ende von Woche 05 kurz gesehen haben: das
Ergebnis ist nur ``true``, wenn ALLE Inputs ``true`` sind. Wenn die
Kandidatenfunktion also eine einzige Falsche antwort gibt, ist das
Resultat des gesamten Tests, dass die Funktion nicht korrekt ist.

Nehmen wir die folgende Funktion:

::

   fun x -> 1;;

Diese Funktion würde den ersten Testfall korrekt bestehen, weil sie
``1`` als Ergebnis gibt. In den anderen Fällen hätte sie jedoch
weniger Glück. Zum Beweis:

::
   
   # test_nachfolger (fun x -> 1);;
   - : bool = false
   #

Nehmen wir die folgende Funktion:

::

   fun x -> x+1;;

Hier erwarten wir, dass diese Funktion den Test besteht, denn nach
unserem besten Wissen sieht sie richtig aus. Der Beweis:

::

   # test_nachfolger (fun x -> x+1);;
   - : bool = true
   #

Wir können der Funktion auch einen Namen zuweisen und den Test mit
diesem Namen wiederholen:

::

   # let nachfolger x = 
     x + 1;;
   val nachfolger : int -> int = <fun>
   # test_nachfolger nachfolger;;
   - : bool = true
   #


Noch mehr syntaktischer Zucker
==============================

Wir haben letzte Woche gesehen, dass wir Variablen definieren können,
indem wir schreiben ``let <name> = <value>``.

Wir haben auch gesehen, dass wir funktionen schreiben können mit ``fun
<parameter> -> <expression>``.




  

    

Version of "erst_denken_dann_programmieren"
===========================================
[2023-02-08] Erstellt

