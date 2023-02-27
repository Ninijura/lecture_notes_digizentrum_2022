==============
Mehr Rekursion
==============

Der Sinn dieses Kapitels ist es, das Prinzip der Rekursion an einem gängigen Beispiel
zu üben:

Die Faktorialfunktion
=====================

Das Ergebnis Faktorialfunktion angewandt auf eine natürliche Zahl x ist
x*x-1*x-2*...*2*1. Oder in Worten: Das Produkt von allen natürlichen Zahlen von 1
bis x. Wir schreiben das Faktorial von x auch x!.

Zur Veranschaulichung hier ein paar Beispiele:

::

   0! = 1 (per Definition, lässt sich also nicht berechnen)
   1! = 1
   2! = 2 * 1 = 2
   3! = 3 * 2 * 1 = 6
   4! = 4 * 3 * 2 * 1 = 24
   5! = 5 * 4 * 3 * 2 * 1 = 120
   etc.

Hier lässt sich schon ein Muster erkennen, das eine rekursive Struktur hat:

::

   n! = n * (n-1)!

Oder wieder mit Beispielen:

::

   0! = 1 (hier ist 0 unser Basisfall)
   1! = 1 * 0! = 1
   2! = 2 * 1! = 2
   3! = 3 * 2! = 6
   4! = 4 * 3! = 24
   5! = 5 * 4! = 120
   etc.


Übung 36
========

* Beschreibe den Basisfall und den Induktionsfall für die Faktorial-Funktion.
  (Tipp: Die Lösung steht schon fast fertig in diesem Abschnitt.)

* Schreibe eine Testfunktion für die Faktorialfunktion.

* Schreibe die Faktorialfunktion in OCaml.

* Benutze deinen Test um zu überprüfen, ob du die Faktorialfunktion richtig
  geschrieben hast.


Bonus für Schnelle: Die Fibonacci-Funktion
==========================================

Die Fibonacci-Funktion ist eine induktiv definierte Zahlenreihe (das heißt jede neue
Zahl ist an ihren Vorgängern definiert). Anders als die Funktionen, die wir bisher
gesehen haben, hat die Fibonacci-Funktion zwei Basisfälle.

Hier ist der Anfang der Reihe:

::

       n =  0  1  2  3  4  5  6  7   8   9   10
   fib n =  0  1  1  2  3  5  8  13  21  34  55  


Die beiden Basisfälle sind definiert als:

::

   fib 0 = 0
   fib 1 = 1

Der Induktionsfall nimmt immer die beiden vorhergegangenen Zahlen und addiert
sie. Hier ein paar Beispiele:

::

   fib 2 = fib 1 + fib 0
   fib 3 = fib 2 + fib 1
   fib 4 = fib 3 + fib 2
   ...

Übung 37
========

* Schreibe Basisfall und Induktionsfall für die Fibonacci-Funktion auf.
  (Tipp: Der Basisfall steht schon im obigen Abschnitt.)

* Schreibe eine Testfunktion für die Fibonacci-Funktion.

* Schreibe die Fibonacci-Funktion in OCaml.
  (Tipp: mit zwei Basisfällen brauchst du natürlich auch zwei bedingte Ausdrücke
  (if-statements).)

* Benutze deinen Test zum zu überprüfen, ob du die Fibonacci-Funktion richtig
  geschrieben hast. 
 



Version of "mehr_rekursion"
===========================

[2022-02-27] Erstellt
