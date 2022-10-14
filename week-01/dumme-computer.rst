==============================================================================================
 Welche Sprache spricht eigentlich ein Computer; oder: warum versteht Siri mich immer falsch?
==============================================================================================

Wer programmieren lernen will, der muss erst einmal verstehen, wie man sich seinem
Computer gegenüber verständlich macht.

Das Klischee, dass Computer eine Sprache sprechen, die nur aus 0'en und 1'en besteht
ist zwar nicht hundertprozentig treffend (die meisten Computerchips können auch eine
Handvoll anderer Wörter, genannt Instruktionen), aber eigentlich gar keine schlechte
Approximation. 

Also, wir wissen nun, dass der Computer in `Binärcode
<https://de.wikipedia.org/wiki/Bin%C3%A4rcode>`_ spricht und wir selbst aber eher
deutsch, englisch, oder eine andere `natürliche Sprache
<https://de.wikipedia.org/wiki/Nat%C3%BCrliche_Sprache>`_.
Das ganze lässt sich also wie folgt zusammenfassen:

.. ditaa::

   +----------+                  +-----------+
   |          |      Magie!      |           |
   | 01001101 | <--------------> | blablabla |
   |          |                  |           |
   +----------+                  +-----------+

.. epigraph::
   | Ich denke,
   | Sie sollten doch etwas spezifischer sein,
   | hier in Schritt zwei. 

   -- `Sydney Harris <https://www.researchgate.net/figure/Then-a-Miracle-Occurs-Copyrighted-artwork-by-Sydney-Harris-Inc-All-materials-used-with_fig2_302632920>`_


Informationen und Daten
=======================

Egal ob Computer oder Mensch, unsere Sprachen haben einige Dinge gemeinsam. Erstmal,
ganz grundlegend, benutzen wir unsere Sprache um Informationen auszutauschen. Wir
haben Wörter, über deren Bedeutung wir uns weitestgehend einig sind und setzen diese
zusammen in Sätzen, die dann hoffentlich die Information übermitteln, die wir im Sinn
hatten.

Wenn sich zwei Personen treffen, die beide deutsch sprechen, dann ist das relativ
unkompliziert. Beide Personen wissen, was die Wörter bedeuten und wie die Sätze
aufgebaut sein müssen, damit die andere Person sie versteht.


.. ditaa::

        Information A       Information B 
               |                 ^
               |                 |
   formulieren |                 | hören und
               |                 | verstehen
               v                 |
              Satz --------------+

Wenn ein Satz nicht klar formuliert war, dann kann es sein, dass Information A und
Information B nicht gleich sind. Zwischen Menschen kann so ein Missverständnis zu
gegenseitiger Frustration führen. Im Umgang mit Computern ist diese Frustration zwar
einseitig, dafür aber oftmals umso größer.

.. epigraph::
   | **Loki [verschmitzt]:** Habt ihr das gesehen?
   | Der Mann hat die Frau auf dem Fahrrad verfolgt!
   | **Alfrothul:** Oh nein! Wie gemein!
   | Ich hoffe, sie ist eine gute Läuferin!
   | **Brynja:** Gar nicht gemein.
   | Sie hat nicht bemerkt, dass ihr etwas
   | aus dem Fahrradkorb gefallen war.


Wenn sich aber zum Beispiel ein Deutscher und ein Franzose treffen, ist deren `Lingua
franca <https://de.wikipedia.org/wiki/Verkehrssprache>`_ (ironischerweise; siehe
Link) wahrscheinlich Englisch. Beide denken immernoch die gleichen Gedanken wie
zuvor, aber nun müssen sie andere Worte für die gleichen Konzepte benutzen. Die Sätze
sind auch anders aufgebaut.

Ungefähr so funktioniert das auch mit Computern. Statt der Worte haben wir Daten, die
Informationen repräsentieren:

.. ditaa::

       Datum      
         |
         |
         | repräsentiert
         |
         v
    Information 

(`NB <https://de.wiktionary.org/wiki/notabene>`_: Das Wort "Daten" (englisch "data")
kommt aus dem Lateinischen und ist eigentlich Plural. Der korrekte Singular ist
"Datum".)

Im Computer werden Daten von einem *Daten-Konstruktor* erstellt. Die Repräsentation
der Information kann zwei Eigenschaften haben.

* Eine Repräsentation ist *korrekt* (englisch: *sound*), wenn der richtige Gebrauch
  der Daten-Konstruktoren immer Daten erstellt, die wirklich das repräsentieren, was
  sie repräsentieren sollen. (Sonst ist die Repräsentation *inkorrekt* (*unsound*).)
* Eine Repräsentation ist *komplett* (englisch: *complete*), wenn wir alle
  Information, die wir repräsentieren möchten mit Gebrauch der Daten-Konstruktoren
  repräsentieren können. (Sonst ist die Repräsentation *inkomplett* (*incomplete*).)

In OCaml (der Programmiersprache, mit der wir in diesem Kurs arbeiten), hat die
Standard-Repräsentation von Integern (Ganzzahlen) eine feste Größe. Das heißt, dass
(in diesem Fall) nur Zahlen zwischen -4611686018427387904 und 4611686018427387903
repräsentiert werden können. Diese Repräsentation ist korrekt, für alle Zahlen
zwischen -4611686018427387904 und 4611686018427387903, da diese wirklich mathematische
Ganzzahlen darstellen. Diese Repräsentation ist nicht komplett, da Zahlen, die kleine
als -4611686018427387904 oder größer als 4611686018427387903 sind nicht dargestellt
werden können.



Erkenntnis über Repräsentationen
--------------------------------

Kurz gesagt: eine Repräsentation und das, was sie repräsentiert, sind zwei
unterschiedliche Dinge.

* Ein Name ist nicht das, was er benennt (z.B., wir sind nicht unsere Namen).
* Eine Adressse ist kein Haus.
* Eine `Note <https://de.wikipedia.org/wiki/Note_(Musik)>`_ ist nicht ihr Name (C, D,
  E, F, G, A, H) und auch nicht der Ton, den sie beschreibt.
* usw.

.. epigraph::

   | **Mimer:** Das erinniert mich an das Bild von `René Magritte <https://en.wikipedia.org/wiki/Ren%C3%A9_Magritte>`_?
   | **Alfrothul:** Du meinst die Pfeife?
   | **Brynja:** Eben nicht, das ist ja genau der Punkt.
   | **Mimer:** Genau. `"Der Verrat der Bilder" <https://de.wikipedia.org/wiki/La_trahison_des_images>`_ beschäftigt sich genau   damit.
   | Magritte hat eine Pfeife gemalt und darunter geschrieben: "Dies ist keine Pfeife".
   | **Alfrothul:** Weil es nur ein Bild von einer Pfeife ist.
   | **Brynja:** Wenn man es genau nimmt, Mimer, hat er auch nicht geschrieben:
   | "Dies ist keine Pfeife", sondern "Ceci n'est pas une pipe."
   | Deine Übersetzung war auch nur eine Repräsentation. 
   | **Loki:** Ist das hier dann auch kein Lehrmaterial?
   | **Alfrothul:** Das, was mein Schirm mir anzeigt, kann ich lesen und davon lernen.
   | Ich glaube, das ist doch Lehrmaterial.
   | **Brynja:** Ich glaube auch. Die Dateien sind die Repräsentation, die der Computer lesen kann,
   | aber sobald es auf dem Schirm ist, ist es Lehrmaterial.
   | **"Mad-Eye" Moody:** `Ständige Wachsamkeit! <https://harrypotter.fandom.com/de/wiki/Alastor_Moody>`_
   

Übung 0
-------
TODO

Grundlegender Umgang mit der OCaml REPL.g

   
Übung 01
--------
Computer benutzen eine binäre Repräsentation von Zahlen (das mit den Nullen und
Einsen). Benutze Emacs und den :download:`OCaml-Code
<../exercises/week-01/exercises_for_week-01.ml>` für das gegenwärtige Lehrmaterial um
die folgenden Aufgaben zu lösen `(eine Anleitung dazu gibt es hier) <emacs-und-ocaml.html>`_:

a. Welche Potenz von 2 ist die größte, die OCaml korrekt darstellen kann?
   In anderen Worten: Was ist die größte Zahl, ``x``, so dass OCaml :math:`2^x` korrekt repräsentiert?
   (Tipp: 4611686018427387904 ist eine Potenz von 2.) 

b. Und was, wenn wir nach dem kleinsten :math:`-(2^x)` suchen? (Achtung! Ihr könnt
   nicht einfach ``exp -2 n;;`` ausprobieren, da ihr bei geraden exponenten ``n``
   immer ein positives Ergebnis bekommt. Minus-mal-minus und so...)


Ein kurzer Abstecher zu binären Zahlen
--------------------------------------

Wenn wir im Alltag Zahlen benutzen, dann benutzen wir das Dezimalsystem. Wer ein
Bisschen Latein kann, der weiß, dass "dezi" 10 bedeutet. Guckt man sich dann unser
Zahlensystem an, bemerkt man, dass wir 10 unterschiedliche ziffern haben: ``0, 1, 2,
3, 4, 5, 6, 7, 8, 9``.

Im Binärsystem ist das ähnlich (nur mit Griechisch statt Latein). Das Präfix "bi-"
bedeutet was mit 2; und ganz richtig das Binärsystem hat zwei unterschiedliche
Zahlen: ``0, 1``. (Das ist praktisch für Computerchips, deren einzige zwei Zeichen
``Strom an`` und ``Strom aus`` sind. Deshalb benutzen Computer das Binärsystem.)

.. epigraph::

   | **Brynja:** Fällt euch was auf Leute?
   | **Sigrid:** Du meinst, dass das Binärsystem gar keine 2 benutzt,
   | obwohl es das Zweiersystem ist?
   | **Alfrothul:** Ich glaube, Brynja meint,
   | dass wir schon wieder von Repräsentationen reden.
   | **Brynja:** Genau. Wenn wir also 3 meinen, können wir ``3`` schreiben,
   | oder ``11`` im Binärsystem.
   | **Sigrid:** Stimmt. Oder ``III`` in römischen Zahlen.
   | **Alfrothul:** Ja, aber bitte nichts mehr über tote Sprachen heute.

* Wenn wir im Dezimalsystem zählen wollen, fangen wir mit einer Stelle an und zählen
  von der kleinsten Ziffer zur größten. So kommen wir bis 9.

* Wenn wir weiter zählen wollen, setzen wir eine 1 voran und zählen wieder die
  hinterste Stelle hoch. Wenn diese bei der größten Zahl, also 9, angekommen ist,
  zählen wir die Stelle davor eine hoch. So kommen wir bis 99.

* Wenn wir weiter zählen wollen, setzen wir eine 1 voran und... bemerken, dass wir
  uns irgendwie immer wiederholen. Wir vergrößern die Ziffern von rechts nach links,
  bis alle Ziffern 9 sind. Dann setzen wir alle Ziffern wieder auf 0 und schreiben
  eine 1 davor.

Mit diesem Verständnis ist das Zählen im Binärsystem auch nicht mehr kompliziert:

* Wenn wir im Binärsystem zählen wollen, fangen wir mit einer Stelle an und zählen
  von der kleinsten Ziffer zur größten. So kommen wir bis 1.

* Wenn wir weiter zählen wollen, setzen wir eine 1 voran und zählen wieder die
  hinterste Stelle hoch. Wenn diese bei der größten Zahl, also 1, angekommen ist,
  zählen wir die Stelle davor eine hoch. So kommen wir bis 11.

* Wenn wir weiter zählen wollen, setzen wir eine 1 voran und... bemerken, dass wir
  uns irgendwie immer wiederholen. Wir vergrößern die Ziffern von rechts nach links,
  bis alle Ziffern 1 sind. Dann setzen wir alle Ziffern wieder auf 0 und schreiben
  eine 1 davor.

Soviel zum zählen. Aber wie rechnen wir jetzt um?

Dafür brauchen wir Potenzen. (Am Computer schreiben wir :math:`n^x` als ``n^x``.)

* Im Dezimalsystem ist die kleinste positive Zahl eine 1. Das lässt sich auch
  schreiben als ``10^0``. 

* Die kleinste zweistellige Zahl ist 10, oder auch ``10^1``.

* Die kleinste dreistellige Zahl ist 100, oder auch ``10^2``.

* Die kleinste vierstellige Zahl ist 1000, oder auch ``10^3``.

* usw.

Wenn wir also ``1234`` schreiben, bedeutet das: ``4*10^0 + 3*10^1 + 2*10^2 +
1*10^3``, oder leserlicher: ``4*1 + 3*10 + 2*100 + 1*1000``.
  
Im Binärsystem geht das genauso, aber mit Potenzen von 2.

* Die kleinste positive Zahl ist eine 1, oder auch ``2^0``.

* Die kleinste zweistellige Zahl ist ``10``, oder auch ``2^1`` (dezimal: 2).

* Die kleinste dreistellige Zahl ist ``100``, oder auch ``2^2`` (dezimal: 4).
 
* Die kleinste vierstellige Zahl ist ``1000``, oder auch ``2^3`` (dezimal: 8).

* usw.

Wenn wir also ``1010`` schreiben, bedeutet das: ``0*2^0 + 1*2^1 + 0*2^2 + 1*2^3``,
oder leserlicher: ``0*1 + 1*2 + 0*4 + 1*8 = 10``.


Übung 1, Fortsetzung
--------------------

c. Wer aufgepasst hat, hat folgendes bemerkt:

   Die größtmögliche Zahl, ``max_int``, ist ``(2^x)-1``.

   Die kleinstmögliche Zahl, ``min_int``, ist ``-(2^x)``.

   Beide für die gleiche Zahl x. 

   Was bedeutet das im Zusammenhang mit dem Binärsystem? Hast du eine Idee, warum es genau
   eine negative Zahl mehr gibt als positive? (Tipp: Gibt es eine Zahl, die immer
   gleich bleibt, egal welches Vorzeichen sie hat?)


Berechnungen als Datenverarbeitung
----------------------------------

Ein Computer verarbeitet Daten. Wenn ein Computer mit Daten gefüttert wird, die eine
Input-Information darstellen, kann er:

* Output-Daten produzieren, die eine Output-Information darstellen,
* einen Fehlercode anzeigen (was auch Output-Information ist), oder
* unendlich im Kreis laufen, also keine Daten herausgeben.

Eine Stapelverarbeitung ist ein Prozess der Input-Daten nimmt, die eine
Input-Information repräsentieren, eine Berechnung mit diesen Daten ausführt, und
Output-Daten ausspuckt, die eine Output-Information repräsentieren:


.. ditaa::

                Input-   Verarbeiten      Output-
                Daten  ---------------->  Daten
                  |                         |
                  |                         |
   repräsentiert  |                         | repräsentiert
                  |                         |
                  v                         v
                Input-   -------=------> Output-
             Information                 Information

Außer Stapelverarbeitungen gibt es auch noch andere Verarbeitungen; z.B. die
reaktiven, die zufällige Buchstaben auf dem Bildschirm anzeigen, wenn die Katze mal
wieder über die Tastatur läuft. Aber Stapelverarbeitungen sind ein guter Startpunkt.

* Wenn die Output-Daten einer Stapelverarbeitung immer die richtige
  Output-Information darstellen, ist die Berechnung *korrekt*.

* Eine Stapelverarbeitung ist *komplett*, wenn die erwartete Output-Information immer
  von den Output-Daten repräsentiert wird. 



Übung 2
-------

a. Probier ein Bisschen mit Großen Zahlen und ``+`` herum.

   Ist der Operator ``(+)`` eine korrekte Repräsentation der mathematischen Operation
   +? (Das heißt: 
   
   Ist der Operator ``(+)`` eine komplette Repräsentation der mathematischen Operation
   +?

   
Lösung zu Übung 2
-----------------

TODO


Programme
---------
Ein Programm ist das Rezept, dem ein Computer folgt um Daten zu verarbeiten. Ein
Programm berechnet eine Funktion von Input-Daten zu Output-Daten. Ein Programm wird
von einem Programmierer geschrieben.

Ein guter Vergleich: Ein Kochrezept ist eine Notation, die vermittelt wie man etwas
kocht. Es beschreibt Daten (die Zutaten), Ressourcen und Werkzeuge (z.B. ein Topf und
ein Herd), und einen Algorithmus (die Methode die Daten zu verarbeiten, z.B. Eier
schlagen um ein Omlett zu machen (die Armen Eier...)). Um ein Gericht zuzubereiten
benutzt ein Koch die Küchenutensilien um die Zutaten entsprechend dem Algorithmus zu
verarbeiten. 


Programmiersprachen
-------------------

Eine Programmiersprache ist eine Sprache in der man Programme schreibt: eine Notation
um Berechnungen zu beschreiben. 
Es gibt viele Konzepte für Berechnungen (das heißt viele unterschiedliche Arten,
informationen darzustellen und Daten zu verarbeiten), und für jedes dieser Konzepte
gibt es viele Notationen (das heißt viele Programmiersprachen). 


Version
=======

Erstellt [2022-10-10]
