=====================
Sturkturiertere Tests
=====================

In diesem Kapitel schauen wir uns an, wie wir Tests besser strukturieren
können. Außerdem lernen wir die neue grammatikalische Form ``let <name> =
<expression> in <expression>``.


Lokale Variablen
================

Wir haben schon gesehen, wie wir globale Variablen definieren:

::

   let <name> = <expression> {and <name> = <expression>}*

Manches mal brauchen wir aber in einer Funktion Variablen, die wir nicht vorher
definieren können und die wir nach Abschluss der Funktion nie wieder benutzen
wollen. Dafür brauchen wir eine andere grammatikalische Variante des ``let``.

::

   let <name> = <expression> in <expression>

Für diesen Ausdruck gilt die folgende Typenregel:

::

        G |- e1 : t1     (x1 : t1), G |- e0 : t0
   LET ------------------------------------------
        G |- let x1 = e1 in e0 : t0


In Worten:

* in einer beliebigen Typenumgebung ``G`` hat der Ausdruck ``let x1 = e1 in e0`` den
  Typen ``t0``, wenn (1) in disere Umgebung der Ausdruck ``e1`` den Typen ``t1`` hat
  und (2) der Ausdruck ``e0`` den Typen ``t0`` hat, wenn die Umgebung erweitert wird
  mit der Bindung von ``x1`` zum Typen ``t1``.


Außerdem:

* Wenn wir den Ausdruck ``let x1 = e1 in e0`` evaluieren, dann evaluieren wir zuerst
  ``e1`` in der aktuellen Typenumgebung.

  * Wenn die Evaluieren nicht terminiert, dann terminiert die Evaluierung von ``let
    x1 = e1 in e0`` auch nicht.

  * Wenn die Evaluierung einen Fehler hervorruft, ruft die Evaluierung von ``let x1 =
    e1 in e0`` denselben Fehler hervor.

  * Wenn ``e1`` zum Wert w1 evaluiert wird, dann vereinfacht sich die Evaluierung von
    ``let x1 = e1 in e0``  dazu, dass wir ``e0`` in einere Umgebung evaluieren, wo
    der Name ``x1`` den Wert w1 repräsentiert.

    Wir können das auch graphisch darstellen:

    .. ditaa::

       globale Bindungen

       +--------------------------+
       | x1 steht für den Wert w1 |
       |                          |
       |  e0                      |
       +--------------------------+

    Die Bindung von ``x1`` ist lokal. Das bedeutet, dass sie aus der Umgebung
    gelöscht wird sobald wir ``e0`` evaluiert haben.



    




Version of "tests_strukturieren"
================================

[2022-02-22] Erstellt
