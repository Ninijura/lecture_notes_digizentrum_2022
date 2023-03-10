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

   # type nat_v1 =
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

   # type nat =
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

Nimm dir den :download:`OCaml-Code
<../exercises/week-08/exercises_for_week-08.ml>` für diese Woche zur Hand.

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


Konvertieren von ``int`` zu ``nat``
===================================

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


Übung 39
========

Nutze das, was du letzte Woche gelernt hast und oben genannten Basis- und
Induktivfall um die Konvertierungsfunktion ``int_to_nat`` zu schreiben. 



Konvertieren von ``nat`` zu ``int``
===================================

Für die Konvertierung von ``nat`` zu ``int`` haben wir von Anfang an nur zwei
mögliche Bereiche für das Input:

* = O
* < O

Das lässt sich auch anders schreiben:

* = O
* = S n, wo n ein Wert ist. 

Das ergibt sich ganz logisch aus unserer Typendefinition. Guck dir gerne die
Typendefinition noch einmal an und sieh die zwei Fälle dort. 


Wir könnten jetzt also die Funktion ganz einfach schreiben wie wir gerade die andere
geschrieben haben:

::

   let rec nat_to_int_v1 n =
     if n = O
     then 0
     else 1 + (nat_to_int_v1 (n - 1));;

Doof nur, dass das ``(-)`` nur für Integer definiert ist und nicht für ``nat`` s. Wir
könnten nun natürlich eine Vorgänger-Funktion für die natürlichen Zahlen definieren,
aber es geht auch einfacher.


Zwischenspiel über ``match``
============================

**Mimer:** In OCaml können wir einen Wert auf seine Struktur überprüfen und je nachdem, wie
dieser Wert konsturiert ist eine andere Berechnung ausführen.

**Alfrothul:** Das verstehe ich nicht.

**Brynja:** Ich schon, glaube ich. Wir haben zum Beispiel bei ``nat`` zwei
Konstruktoren: ``O`` und ``S n``, wo ``n`` eine andere ``nat`` ist.

**Alfrothul:** Okay... wenn wir also Booleans nehmen, haben wir auch wieder zwei
Konstruktoren, ``true`` und ``false``, stimmt das?

**Mimer:** Genau, du bist auf dem richtigen Wege.

**Sigrid:** Ich muss das ausprobieren, sonst verstehe ich das nicht. Also Mimer, wie
schreibe ich das?

**Mimer:**

::

   match w with
   | ... -> ...
   | ... -> ...
   | etc.

wo w ein Wert ist. Links von den ``->`` steht die Struktur, mit der w verglichen wird
und rechts davon die Berechnung, die dann ausgeührt werden soll.

**Sigrid:** Okay. Wenn ich jetzt also zum Beispiel die ``not``-Funktion für Booleans
schreiben wollte, wäre das so:

::

   # let not_v1 b =
     match b with
     | true -> false
     | false -> true ;;
   val not_v1 : bool -> bool = <fun>
   #

**Brynja:** Ich glaube schon, aber lass es uns lieber testen: 

::
   
   # not_v1 true;;
   - : bool = false
   # not_v1 false;;
   - : bool = true
   #

**Alfrothul:** Dann kann ich mir ja auch bei Integern das ganze ``if`` schenken. Ich
schreibe einfach:

::

   # let rec int_to_nat_v2 i =
      match i with
      | <= 0 -> O
      | > 0 -> S (int_to_nat_v2 (i-1));;
   Error: Syntax error
   #

Hm... oder auch nicht?

**Mimer:** Nein, ``<=`` und ``>`` sind Operatoren, keine Struktur.

**Brynja:** Ich glaube, wir könnten da aber die Struktur von Booleans benutzen.

**Alfrothul:** Wieso denn Booleans? Die haben hiermit doch gar nichts zu tun.

**Brynja:** Nicht direkt. Aber in einem ``if`` hast du ja immer einen Boolean als
Test. Warum nicht auch hier?

::

   # let rec int_to_nat_v2 i =
     match (i <= 0) with
     | true -> O
     | false -> S (int_to_nat_v2 (i-1));;
   val int_to_nat_v2 : int -> nat = <fun>
   #

**Alfrothul:** Hm! Cool!

**Sigrid:** Ich glaube ich sehe, wie das mit ``nat`` Sinnvoll ist:

::

   # let n = S (S O);;
   val n : nat = S (S O)
   # match n with
     | O -> "n ist null"
     | S

Uhm... ich brauche hier mal Hilfe. Der Konstruktor ``S`` nimmt ja ein Argument, wie
schreibe ich denn das?

**Mimer:** Gut bemerkt! Wenn du einen Konstruktor hast, der Argumente nimmt, kannst
du den Argumenten Namen geben indem du Namen an ihre Stelle schreibst. Du kannst sie
auch anonym sein lassen, indem du einfach einen Unterstrich schreibst.

**Alfrothul:** Ich will! Darf ich?

**Sigrid:** Klar.

**Alfrothul:** 

::
        
     | S m -> "n ist nicht null";;
   - : string = "n ist nicht null"
   #

**Brynja:** Sieht gut aus, aber warum hast du denn dem Argument einen Namen gegeben,
wenn du es dann gar nicht benutzt. Das könnte man doch bestimmt anders machen...

::

   # match n with
     | O -> ("n ist null", O)
     | S m -> ("n ist nicht null und der vorgaenger ist:", m);;
   - : string * nat = ("n ist nicht null und der vorgaenger ist:", S O)
   #

**Sigrid:** Das sieht mir aber nach einer ziemlich sinnlosen Berechnung aus.

**Alfrothul:** Aber mir hat es beim Verstehen geholfen. Also wenn wir im Zweig ``S
m`` landen, dann wissen wir, dass das Input, in diesem Fall ``n``, eine ``nat`` ist,
die größer als null ist, weil ihr Konstruktor ``S`` war. Und wir definieren dass ``n
= S m``, womit wir wissen, dass ``m`` der Vorgänger von ``n`` ist.

**Sigird:** Klingt sinnvoll. Ich muss mir das nochmal genauer angucken und ein
Bisschen damit ausprobpieren.

**Brynja:** Ich habe noch eine Idee: Tupel.

**Alfrothul:** Was ist damit?

**Sigrid:** Stimmt! Damit kann man doch bestimmt die einzelnen Elemente aus einem
Tupel raus holen.

::

   # let tup = (1, 'a', "Hello World");;
   val tup : int * char * string = (1, 'a', "Hello World")
   # match tup with
     | (a, b, c) -> a + 5;;
   - : int = 6
   #

Stimmt, geht.

**Brynja:** Geht aber auch mit weniger Namen:

::

   # match tup with
     | (a, _, _) -> a + 5;;
   - : int = 6
   #
 

Übung 40
========

Um mit ``match`` etwas vertraut zu werden, schreibe eine Vorgänger-Funktion für
natürliche Zahlen.

Tipp: Der Vorgänger von O ist in diesem Fall O.


Übung 41
========

Um noch vertrauter mit ``match`` und den ``nat`` s zu werden, schreibe eine
Vor-Vorgänger-Funktion.

Tipp: Dieses Mal müsste dein ``match`` drei Fälle haben (also drei Zeilen unter dem
``match n with``); eine für O, eine für S m und eine für S (S m).

   

Konvertieren von ``nat`` zu ``int`` (forgesetzt)
================================================

Nun wissen wir, wie wir ``match`` effektiv nutzen um Schichten von ``nat`` s
abzupulen. (Yay! Noch mehr Zwiebeldenken!)

Wir haben uns die beiden Möglichkeiten für Inputs ja vorhin schon angeschaut. Nun
wird es Zeit, das ganze in die Tat umzusetzen.


Übung 42
========

Schreibe die Funktion ``nat_to_int`` und teste sie.

Dieses Mal darfst du alles ganz alleine schreiben, ohne dass ich was vorsage.



Endbemerkung
============

Damit ist der Kurs abgeschlossen. Natürlich war das nur ein kleiner Vorgeschmack auf
die große Welt des Programmierens. Wenn du mehr lernen willst, dann kann ich nur
empfehlen das `Material von Olivier Danvy
<https://delimited-continuation.github.io/YSC1212/2022-2023_Sem1/index.html>`_ zu
lesen.

Im folgenden Kapitel findest du noch ein paar Bonus-Übungen, die du mit dem bisher
gelernten bewältigen können solltest.

Ich stehe auch weiterhin gerne für Nachfragen zur Verfügung. Entweder persönlich hier
im DiZ oder per eMail. 



Version of 'induktive_typen_definieren'
=======================================
Erstellt [2023-03-08]
