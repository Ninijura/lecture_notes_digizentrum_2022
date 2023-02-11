=====================================================
Zehn Minuten denken spart zehn Stunden programmieren
=====================================================

Die einfachste Art eine Funktion zu durchdenken bevor wir sie schreiben ist indem wir
einen Test schreiben.

Wir haben letze Wochen Funktionen gesehen, die andere Funktionen als Output
haben. Diese Woche arbeiten wir mit Funktionen, die andere Funktionen als Parameter
haben.


Die Nachfolger-Funktion
=======================

Die Nachfolger-Funktion ist die Funktion, die für einen ``int`` x als Input den
``int`` x+1 als Output gibt.

Wenn wir einen Test für die Nachfolger-Funktion schreiben möchten, dann können wir
nicht die gesamte Funktion testen, sondern müssen uns ein paar Zahlen aussuchen, für
die wir testen.

Zum Beispiel:

::

   let test_nachfolger kandidat = 
       (kandidat 0 = 1)
    && (kandidat 1 = 2) 
    && (kandidat 41 = 42)
    && (kandidat (-4) = (-3))
    (* etc *) ;;


Wenn wir diese funktion auf eine Funktion anwenden, die ein Kandidat für die
Nachfolger-Funktion ist, dann passiert folgendes:

* der Kandidat wird auf 0 angewendet und es wird überprüft ob das Ergebnis 1 ist;
  falls ja, dann wird

* der Kandidat auf 1 angewendet und überprüft ob das Ergebnis 2 ist, falls ja, dann
  wird

* der Kandidat auf 41 angewendet und überprüft ob das Ergebnis 42 ist, falls ja, dann
  wird

* der Kandidat auf -4 angewendet und überprüft ob das Ergebnis -3 ist, falls ja,

* dann wird ``true`` als Ergebnis des Tests ausgedruckt.

Falls in einem der obigen Schritte das Ergebnis des Kandidaten nicht das erwartete
ist, ist das Ergebnis des Tests ``false``.

Die Logik hinter dem ganzen ist, dass wir den Kandidaten mit verschiedenen Inputs
überprüfen. Jeders Resultat wird mit dem Boolschen Test ``=`` überprüft und das
Ergebnis ist ein Boolean, der angibt, ob das Resultat so ist wie erwartet.

Die ``&&`` zwischen den einzelnen Tests sind eine weitere Boolsche Funktion, die wir
am Ende von Woche 05 kurz gesehen haben: das Ergebnis ist nur ``true``, wenn ALLE
Inputs ``true`` sind. Wenn die Kandidatenfunktion also eine einzige Falsche antwort
gibt, ist das Resultat des gesamten Tests, dass die Funktion nicht korrekt ist.

Nehmen wir die folgende Funktion:

::

   fun x -> 1;;

Diese Funktion würde den ersten Testfall korrekt bestehen, weil sie ``1`` als
Ergebnis gibt. In den anderen Fällen hätte sie jedoch weniger Glück. Zum Beweis:

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

Wir haben letzte Woche gesehen, dass wir Variablen definieren können, indem wir
schreiben ``let <name> = <value>``.

Wir haben auch gesehen, dass wir funktionen schreiben können mit ``fun <parameter> ->
<expression>``.


Wir können das ganze abkürzen indem wir schreiben ``let <name> <parameter> =
<expression>`` statt ``let <name> = fun <parameter> -> <expression>``.


Übung 29
========

Lies den :download:`OCaml-Code <../exercises/week-06/exercises_for_week-06.ml>` für
diese Woche in OCaml ein. (Benutze hierzu den ``#use <datei>``-Befehl in der
OCaml-Toploop.

OCaml druckt nun, welche Werte aus der Datei ausgelesen wurden.

Die ersten drei sind die folgenden:

::

   # #use "exercises_for_week-06.ml";;
   val test_nachfolger : (int -> int) -> bool = <fun>
   val nachfolger_v1 : int -> int = <fun>
   val nachfolger_v1_korrekt : bool = true
   #

Öffne nun die Datei um sie zu bearbeiten.

(In Emacs drücke ``C-x C-f``, gib den Pfad zu deiner Datei an und drücke ``<RET>``
(die Enter-Taste). Emacs zeigt dir nun die Datei an. Um die Datei und die
OCaml-Toploop nebeneinander anzuzeigen drücke ``C-x 3``.)

* Füge noch ein paar Testfälle zu der Funktion ``test_nachfolger`` hinzu. 
* Lies die Datei neu in OCaml ein und überprüfe, ob der Wert
  ``nachfolger_v1_korrekt`` noch immer ``true`` ist.

(Anmerkung: In diesem Fall ist die Funktion, die wir testen, sehr einfach
gestrickt. Das ist in der Realität selten der Fall und auch der Grund dafür, dass wir
immer zuerst Tests schreiben. In diesem Fall können wir uns daher ziemlich sicher
sein, dass der Wert ``nachfolger_v1_korrekt`` ``true`` sein sollte, sonst stimmt mit
dem Test etwas nicht. Wenn man kompliziertere Funktionen schreibt, die den Test nicht
bestehen, sollte man daher immer sowohl die Testfälle als auch die Funktion selbst
überprüfen.) 




Übung 30: Vorgänger
===================
Bearbeite den OCaml-Code für diese Woche.

a. Schreibe eine Test-Funktion für die Vorgänger-Funktion.

b. Schreibe eine Vorgänger-Funktion und teste sie.

Genauere Anweisungen sind in den Kommentaren der OCaml-Datei zu finden.


Übung 31: Größer und kleiner
============================

Bearbeite den OCaml-Code für diese Woche.

Das Ziel dieser Übung ist es, zwei neue Tests und die dazu gehörenden Funktionen zu
schreiben.

Die erste Funktion nimmt zwei Integer als Input und gibt den größeren als Output
zurück.

Die zweite Funktion nimmt zwei Integer als Input und gibt den kleineren als Output
zurück.

* Schreibe für jede der beiden Funktionen erst einen Test.
* Schreibe dann die Funktion.
* Lies dann die Datei neu in deinem OCaml-Prozess ein und überprüfe, ob die Funktion.



Testdeckung
===========

Wenn man Tests schreibt, ist es wichtig, dass man sich überlegt, was für
unterschiedliche Arten von Input man haben kann.

Nehmen wir zum Beispiel die ``groessere_von_zweien``-Funktion. Hier haben wir drei
Möglichkeiten dafür welche von den beiden Zahlen größer ist:

* das erste Input ist größer,
* das zweite Input ist größer, oder
* beide sind gleich groß.

Für jeden dieser drei Fälle sollte ein Test vorhanden sein. Wenn das nicht so ist,
kann man eine falsche Funktion schreiben, die trotzdem den Test besteht.

Im OCaml-Code für diese Woche liegt ein Beispiel dafür, welchen Fehler man machen
könnte, wenn man die ``groessere_von_zweien``-Funktion nicht ausreichend testet.

Der Test sieht wie folgt aus:

::

   let test_groessere_von_zweien_falsch kandidat =
   (kandidat 1 2 = 2)
   && (kandidat 4 19 = 19)
   && (kandidat (-1) 4 = 4)
   && (kandidat 0 42 = 42)
   && (kandidat 3 3 = 3);;


und die falsche Funktion so:

::

   let groessere_von_zweien_falsch m n = n;;


Da im Test immer das zweite Input größer ist als das erste, fällt es nicht auf, dass
die Funktion gar nicht das größere Input zurück gibt, sondern einfach immer nur das
zweite Input.


Übung 32: Testdeckung
=====================

Schreibe eine falsche Testfunktion für ``kleinere_von_zweien`` und eine falsche
Funktion, die der Test nicht als falsch deklariert. 

    

Version of "erst_denken_dann_programmieren"
===========================================
[2023-02-08] Erstellt

[2023-02-11] Fertiggestellt

