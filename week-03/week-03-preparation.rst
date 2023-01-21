======================
Vorbereitung für OCaml
======================

* Die Struktur einer Sprache wird von ihrer Grammatik vorgegeben.

* Die Sprache hat drei Lagen: Zeichen, Wörter und Sätze:

  * zulässige Zeichen sind für gewöhnlich Buchstaben, Zahlen, Satzzeichen, usw. und
    einige dieser Zeichen sind "Separatoren";
    
  * zulässige Wörter sind Folgen von Zeichen, die von Separatoren getrennt werden
    (zum Beispiel Leerzeichen) und in der lexikalischen Struktur der Sprache
    definiert sind (bei natürlichen Sprachen heißt das so viel wie: die, die im
    Wörterbuch stehen; bei Programmiersprachen sprechen wir gleich noch darüber,
    welche Wörter zulässig sind)
    
  * zulässige Sätze sind Folgen von Wörtern, die grammatikalisch korrekt sind.

    Während diese drei Lagen eine Beschreibung für natürliche Sprachen sind, sind sie in
    Programmiersprachen Vorschrift: Was nicht lexikalisch oder grammatikalisch
    korrekt ist, das wird direkt abgelehnt.

* In Emacs, wenn man ``M-x run-ocaml`` eingibt, startet man damit eine
  "Read-Eval-Print-Loop" (oft als REPL abgekürzt, auch Toplevel-Loop genannt, oder
  einfach Toplevel). Emacs schreibt dann ``#`` als Eingabeaufforderung und der
  Benutzer schreibt einen OCaml-Ausdruck beendet von ``;;`` und drückt Enter. Das
  System liest diesen Ausdruck und

  * wenn der Ausdruck lexikalisch oder grammatikalisch inkorrekt ist, wird eine
    Fehlermeldung gezeigt.
    
  * wenn der Ausdruck lexikalisch und grammatikalisch korrekt ist, wird er
    ausgerechnet. Das Ergebnis ist eines der folgenden:
    
    * Wenn die Berechnung (eng: evaluation) einen Fehler verursacht, wird eine
      Fehlermeldung gezeigt und die Read-Eval-Print-Loop wird fortgesetzt.
      
    * Wenn die Berechnung länger dauert als wir Zeit haben zu warten (zum Beispiel,
      weil sie in einer endlosen Schleife läuft), passiert nichts bis jemand ``C-c
      C-c`` (also zweimal Strg und C zugleich) drückt; daraufhin wird eine
      Fehlermeldung angezeigt und die Read-Eval-Print-Lopp wird fortgesetzt.
      
    * Wenn die Berechnung mehr Speicherplatz braucht als auf unserem System zur
      Verfügung steht, wird ein Fehler gedruckt und die Read-Eval-Print-Loop
      fortgesetzt.
      
    * Wenn die Berechnung mit einem Ergebnis abgeschlossen wird, wird dieses Ergebnis
      angezeigt und die Read-Eval-Print-Loop fortgesetzt.

    ``C-c C-d`` stoppt den OCaml-Prozess.

* OCaml ist eine Sprache von Ausdrücken.

* Durch die Toplevel-Loop werden OCaml Ausdrücke ausgewertet und geben
  Ergebnisse. Diese Ergebnisse haben einen *Typen*: integer, boolean, string, etc.

  Doch nicht nur die Ergebnisse haben Typen. Jeder Ausdruck hat den Typen, den das
  Ergebnis hat, wenn OCaml diesen Ausdruck berechnet.

  (Zur Veranschaulichung ein beispiel an nicht-negativen Ganzzahlen, die den Typen
  integer haben. Wir schreiben hier **Ausdruck** ``:`` **Typ**.

  ``1 : int`` ist relativ klar. Eine nicht-negative Ganzzahl.
  ``1 + 1 : int`` ergibt sich für unsere Intuition daraus, dass wir das Ergebnis
  ausrechnen und sehen ahh! ``2 : int``.

  Wenn ein Programm allerdings nicht typen-korrekt ist, dann weiß der Computer damit
  nichts anzufangen. Ein Beispiel wäre: ``1 + 'x'``. Hier ist 1 ein Integer, während
  'x' ein Zeichen ist. Da die Operation ``+`` nur für Zahlen definiert ist, würde
  dieses Beispiel einen Typenfehler hervorrufen. 

  Computer haben leider keine Intuition, daher kommt über das mit den Typen noch ein
  ganzer Abschnitt inklusive Übungen.)

  Aber nicht nur Ausdrücke, die ein direktes Ergebnis haben, haben einen Typen. ALLE
  syntaktischen Konstrukte haben Typen. Etwas konkreter gesagt:

  * Nehmen wir einen Compiler von OCaml nach x86. Wenn wir diesen Compiler benutzen
    um ein OCaml-Programm auszuführen, dann geschieht das in zwei Schritten: (1,
    compile time) das Programm wird kompiliert (übersetzt), und (2, run time) wo das
    kompilierte Programm ausgeführt wird. Traditionell nennen wir alles was in der
    compile time passiert *statisch* und alles was zur run time gehört *dynamisch*.

    Zum Beispiel das Parsen (oder Zerlegen, also das Überprüfen, ob das Programm
    syntaktisch (grammatikalisch) korrekt ist) passiert in der compile time, und die
    Ausführung eine syntaktisch korrekten Programms geschieht in der run time: daher
    ist Parsen statisch.

    In OCaml ist die Typen-Analyse (also die Analyse, ob alle Ausdrücke den richtigen
    Typen haben) auch statisch.

  * Das bedeutet, dass OCaml eine *statisch typisierte* Sprache ist. Nur Ausdrücke,
    die sowohl syntaktisch korrekt als auch typen-korrekt sind, werden
    berechnet. Alle andere Ausdrücke werden vor der Berechnung mit einer
    Fehlermeldung abgelehnt.

    Der Vorteil dieser syntaktischen Disziplin ist, dass *die Ausführung eines
    OCaml-Programms niemals einen Syntaxfehler herbeiführt*, da nur syntaktisch
    korrekte Programme ausgeführt werden.

    Der Vorteil diser Disziplin mit Typen ist, dass *die Ausführung eines
    OCaml-Programms niemals einen Typenfehler herbeiführt*, da nur typenkorrekte
    Programme überhaupt ausgeführt werden.



Ein paar Erinnerungen
=====================
Der Sinn der folgenden Abschnitte ist, uns die mathematischen Grundlagen noch einmal
ins Gedächtnis zu rufen. Es ist nichts esotherisches oder kompliziertes dabei,
trotzdem solltet auch Überflieger die Abschnitte wenigstens überfliegen. 


Binäre Relationen - eine Erinnerung
===================================
Eine binäre Relation über zwei Mengen, A und B, ist eine Menge sortierter Paare,
(a,b) aus elementen a aus der Menge A und b aus der Menge B.

Zum Beispiel die Relations "größer als" über die Menge Z (Ganzzahlen) ist die Menge
von Paaren (i,j) für welche eine positive Zahl k existiert, so dass j=i+k.

Ein Beispiel zum Beispiel: (2,5) ist ein Paar von Ganzzahlen und die positive Zahl 3
existiert sodass 5=2+3. 

Wenn wir diese Relation mathematisch schreiben möchten, würden wir schreiben:

{(i,j)|i ist in Z, j ist in Z und es existiert eine positive Zahl k sodass j=i+k}


Mathematische Funktionen - eine Erinnerung
==========================================

Eine Funktion ist eine Relation zwischen zwei Mengen (also eine binäre Relation). Die
Mengen werden als Definitionsbereich und Zielmenge (eng.: domain und codomain)
bezeichnet und die Funktion definiert für jedes Element im Definitionsbereich ein
Element in der Zielmenge.

Beispiele von Funktionen:

* Die "Nachfolger" (eng.: successor) Funktion über den Definitionsbereich der
  Ganzzahlen, Z ist die Relation {(i,j|i+1=j}. Hier sind sowohl Definitionsbereich
  als auch Zielmenge Z. 

  Oder in Worten: Die Paare (i,j), wo i und j Ganzzahlen sind und j genau eins größer
  ist als i. 

* Die "Absoluter Wert" Funktion (für Ganzzahlen) bildet negative Zahlen, -i, als die
  positive Zahl mit   gleichem Wert, i, ab und nicht-negative Zahlen als sich
  selbst. Hier ist der Definitionsbereich Z, Ganzzahlen, und die Zielmenge N, die
  nicht-negativen Zahlen.


Ein *Prädikat* ist eine Funktion, deren Zielmenge die Booleans sind (zur Erinnerung:
es gibt genau zwei Booleans: wahr und falsch (eng.: true und false) und sie werden
genutzt um einen Wahrheitswert darzustellen).

Beispiele von Prädikaten:

* Eine Funktion, die negative Zahlen zu falsch und positive Zahlen zu wahr abbildet.
* Eine Funktion, die gerade Zahlen zu wahr und ungerade Zahlen zu falsch abbildet.


Im Alltag betrachten wir Funktionen oftmals als Maschinen, denen ein Wert eingegeben
wird und die einen veränderten Wert zurückgeben. Wenn wir uns als Beispiel hierzu die
"Nachfolger"-Funktion noch einmal unter die Lupe nehmen, kann sie betrachtet werden
als:

``Nachfolger 1 = 2``

oder

``Nachfolger 4 = 5``.

Es ist auch gängige Praxis, funktionen mit einem Graphen (Kurvendiagramm)
darzustellen. Die "Nachfolger"-Funktion hätte zum Beispiel den Graphen y=x+1.

(Bonus: verstehst du, warum x+1 die "Nachfolger"-Funktion ist?)


Äquivalenz von Funktionen
=========================

Zwei Funktionen sind äquivalent, wenn sie den gleichen Graphen definieren.

Nehmen wir zwei Funktionen, ``f`` und ``g``, von den natürlichen Zahlen ``N`` zu den
Booleans ``B``.

::

   f : N -> B

   g : N -> B

(Wir könnten hier auch sagen, dass die Typen von ``f`` und ``g`` Funktionstypen von
Typ ``N`` nach Typ ``B`` sind. Mehr dazu später.)

Wir vergleichen zwei natürliche Zahlen mit dem Infix-Operator ``=N=`` und Booleans
mit dem Infix-Operator ``=B=``. (Infix bedeutet, dass der Operator zwischen seinen
Operanden steht, also wie wir gewöhnlich (+) und (-) zwischen zwei Zahlen
schreiben.)

Wir sagen nun, dass ``f`` und ``g`` äquivalent sind, wenn sie gleiche natürliche
Zahlen zu gleichen Booleans abbilden:

::

   für beliebige natürlichen Zahlen i und j
   und
   für beliebige Booleans x und y, wo f(i)=x und g(j)=y
   wenn i =N= j, dann x =B= y


Oder präziser:

::

   für eine beliebige natürliche Zahl i,
     f(i) =B= g(i)


Funktionen in der Informatik
============================

Nun können wir zu unserem Diagramm aus Woche-01 zurückkeheren.

Im Großen und Ganzen: Ein Programm (nennen wir es ``p``) verarbeitet Daten und
berechnet eine Funktion (nennen wir sie ``f``, sodass ``run p = f``) die
Input-Informationen (repräsentiert von Input-Daten) zu Output-Informationen abbildet
(repräsentiert von Output-Daten:

.. ditaa::

              Input-            f               Output-
            Information  -------------------> Information
                ^                                 ^
                |                                 |
  repräsentiert |                                 | repräsentiert
                |                                 |
                |                                 |
             Input-           run p             Output-
             Daten    ---------------------->   Daten

             
Etwas näher betrachtet: Wir können Funktoinen in OCaml implementieren. (Allerdings
Vorsicht: eine "OCaml-Funktion" ist keine mathematische Funktion.)


Äquivalenz von Programmen
=========================

Letzte Woche haben wir ja viel über äquivalente Programme gesprochen, als es um
Interpreter und Compiler ging.  Jetzt können wir genau definieren, was das eigentlich
bedeutet.

*Zwei Programme sind äquivalent, wenn die Funktionen, die sie berechnen, äquivalent
sind.* Das heißt wenn man sie mit dem gleichen Input laufen lässt, geben sie entweder
beide das gleiche Ergebnis oder sie divergieren beide (dh. laufen unendlich weiter
ohne jemals ein Ergebnis zu geben).



  
Version
=======
Erstellt [2023-01-15]
Erweitert [2023-01-18]
