============================
 Induktive Typen definieren
============================

In der letzten Woche haben wir gesehen, wie wir die induktive Strutktur von Typen
benutzen können um rekursive Funktionen zu schreiben.

Diese Woche wollen wir uns das ganze nochmal genauer ansehen und außerdem auch
lernen, wie wir unsere eigenen induktiven Typen definieren können.


Natürliche Zahlen neu definiert
===============================

Wir haben bisher den in OCaml bereits vorhandenen Typen ``int`` für natürliche Zahlen
benutzt. Das geht solange gut, bis unsere Funktion eine negative Zahl bekommt und
divergiert (unendlich läuft).

Für dieses Problem gibt es ein paar Lösungsansätze. Wir könnten:

* überprüfen, ob das Input mindestens 0 ist und andernfalls zum Beispiel -1 als
  Ergebnis zurückgeben,

* `Options-Typen <https://en.wikipedia.org/wiki/Option_type>`_ benutzen, oder

* eine `Exception <https://ocaml.org/docs/error-handling>`_ (wörtlich: Ausnahme,
  praktisch: Fehlermeldung) als Resultat zurück geben.

Wie man mit solchen Fehlern umgeht ist jedoch ein Thema für sich. Zwar ist es ein
wichtiger Teil des Programmierens, aber leider würde dieses Thema allein zwei
Unterrichtswochen in Anspruch nehmen.



Wir werden stattdessen einen neuen Typen definieren. Wie ihr später sehen werdet,
macht uns das auch das rekursive Programmieren leichter.

Eine natürliche Zahl ist eine nicht-negative Ganzzahl. Das gibt uns eine kleinste
mögliche natürliche Zahl: 0. Jede weitere natürliche Zahl ist (Zwiebeldenken) der
Nachfolger einer anderen natürlichen Zahl.

Wir könnten also alle natürlichen Zahlen wie folgt beschreiben:

::

   nat ::= 0 | Nachfolger nat

   
Genau das können wir nun auch OCaml beschreiben. Wir definieren einen neuen Typen mit
dem Keyword ``type``:

::

   <type-def>    ::= type <name> = | <constructor> {| <constructor>}*

   <constructor> ::= <cons-name> {of <type>}?

   <cons-name>   ::= eine Zeichenfolge mit einem Großbuchstaben am Anfang


Wenn wir also natürliche Zahlen definieren wollen, dann können wir das wie folgt tun:

::

   type nat_v1 =
   | Null
   | Nachfolger of nat_v1;;
   type nat_v1 = Null | Nachfolger of nat_v1


Wenn wir nun also eine 3 schreiben wollten, sähe das so aus: 

::

   # Nachfolger (Nachfolger (Nachfolger (Null)));;
   - : nat_v1 = Nachfolger (Nachfolger (Nachfolger Null))
   #

Das ist ziemlich viel zu tippen und auch nicht gut zu lesen. Daher kürzen wir das
ganze ab und benutzen ``O`` (großes o) als Null und ``S`` anstelle von Nachfolger:

::

   type nat =
   | O
   | S of nat;;
   type nat = O | S of nat


Wenn wir hier nun 3 schreiben wollen, sieht das wie folgt aus:

::

   # S(S(S O));;
   - : nat = S (S (S O))
   #

Schon viel leserlicher, aber noch immer keine "richtige" Zahl. 


Konvertieren zwischen ``int`` und ``nat``
=========================================

Eine gute Gelegenheit um das mit den rekursiven Funktionen noch etwas zu üben. Wir
schreiben einfach zwei Funktionen, ``int_to_nat`` und ``nat_to_int``, die zwischen
den Typen ``int`` und unserem eigenen Typen ``nat`` hin und her konvertieren können.

Diese Funktionen sind (für natürliche Zahlen) für einander die
`Umkehrfunktionen <https://de.wikipedia.org/wiki/Umkehrfunktion>`_.

Das bedeutet, wenn wir eine (nicht negative) Zahl erst in die eine, dann in die
andere Richtung konvertieren, dann bekommen wir die gleiche Zahl am Ende wieder
raus. Zum Beispiel:

::

   # int_to_nat (nat_to_int (S (S (S O))));;
   - : nat = S (S (S O))
   # nat_to_int (int_to_nat 13);;
   - : int = 13
   #

Wie immer fangen wir mit einem Test an. Dieses Mal können wir es aber ausnutzen, dass
wir die Eigenschaft haben, dass die beiden Funktionen einanders Umkehrfunktionen
sind. Wir können also den Test anfangen wie folgt:

::

   let test_int_nat_konvertierung kandidat_itn kandidat_nti =
   let b1 = (kandidat_itn 0 = O)
   and b2 = (kandidat_itn (kandidat_nti (S (S (S O)))) = S (S (S O)))
   and b3 = (kandidat_nti (kandidat_itn 15) = 15)
   and b4 = (kandidat_nti (S O) = 1)
   (* etc... *)
   in b1 && b2 && b3 && b4;;

   
Übung 38
========

Schreibe mindestens fünf weitere Tests in die Testfunktion. Achte gerne darauf, dass
alle möglichen Kombinationen von positiven Zahlen, negativen Zahlen und Null
überprüfst.

Tipp: Hier musst du überlegen, wie du einen negativen ``int`` zu ``nat`` konvertieren
möchtest. Die gängige Art wäre, sie alle zu ``O`` zu konvertieren.

Um die Funktionen unabhängig von einander testen zu können, kann es auch
hilfreich sein einzelne Testfunktionen zu schreiben. Alternativ könnte die letzte
Zeile des Tests zu einem Tupel gemacht werden. Hier würden wir z.B. erst alle Testfälle
für die ``int_to_nat`` Funktion zusammenfassen, dann alle Testfälle für die
``nat_to_int`` Funktion und zum Schluss alle gemeinsamen Testfälle. Im obigen
Beispiel würde das wie folgt ausseehen:

::

   ...
   in (b1, b2 && b3, b4);;


Schreibe deine Testfunktion so um (oder füge neue Testfunktionen hinzu), dass du
die Testergebnisse für beide Einzelfunktionen sowie die für beide Funktionen zusammen
sehen kannst. 


Konvertieren zwischen ``int`` und ``nat`` (fortgesetzt)
=======================================================

Fangen wir unsere Arbeit mit etwas an, was wir kennen: rekursive Funktionen über
Integer. Das bedeutet, dass wir als erstes die Funktion ``int_to_nat`` schreiben.

Wir haben uns schon beim Test überlegt, dass es drei Möglichkeiten für das Input
gibt:

* < 0
* = 0
* > 0

In den beiden ersten Fällen sollte das Ergebnis ``O`` sein, also können wir die
beiden reduzieren:

* <= 0
* > 0

Damit haben wir unsere Funktion auf einen Basisfall und einen Induktionsfall
gebracht. Jetzt müssen wir nur noch entscheiden, was wir im jeweiligen Fall machen
machen.

Der **Basisfall** ist einfach. Hier müssen wir nur ``O`` als Ergebnis zurück geben.

Der **Induktivfall** ist schwieriger. Hier müssen wir eine Lage vom ``int`` abpulen
und eine neue Lage zum ``nat`` hinzufügen. Den restlichen ``int`` müssen wir trotzdem
noch konvertieren und dann erst die nächste Lage ``nat`` hinzufügen. Das ganze könnte
also ungefähr so aussehen: ``S (int_to_nat (n-1))``





Version of 'induktive_typen_definieren'
=======================================
Erstellt [2023-03-08]
