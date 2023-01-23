======================
Algorithmisches Denken
======================

**Alfrothul:** Algorithmisch? Wie Algorithmus? Das habe ich schonmal gehört. Aber um
ganz ehrlich zu sein habe ich keine Ahnung, was ein Algorithmus kann.

**Sigrid:** Irgendwas mit Computern. Soviel weiß ich.

**Brynja:** Ich glaube es ist irgendwas mit systematischem Denken. Also denken wie
ein Computer.

**Alfrothul:** Klingt gut. Ich habe mal auf `Wikipedia <https://de.wikipedia.org/wiki/Algorithmus>`_
nachgeschaut. Da steht: "eine eindeutige Handlungsvorschrift zur Lösung eines
Problems oder einer Klasse von Problemen."

**Brynja:** Dann ist also die Bauanleitung von meinen IKEA-Möbeln auch ein
Algorithmus?

**Sigrid:** Wenn das stimmt, dann kann ich nicht algorithmisch denken. Ich baue immer
irgendwas falsch zusammen und muss dann die Anleitung nochmal durchgucken um meinen
Fehler zu finden.

**Mimer:** Die Fehlersuche ist aber auch ein wichtiger Teil des algorithmischen
Denkens. Du gehst die Schritte systematisch durch und überprüfst bei jedem Schritt,
ob du ihn richtig gemacht hast. Wenn du den Fehler gefunden hast, dann korrigierst du
ihn und machst hinterher mit dem ursprünglichen Algorithmus weiter.

**Brynja:** Ahh! Das ergibt Sinn. Danke Mimer.

**Sigrid:** Gut, ich glaube ich habe jetzt verstanden, was Algorithmen sind. Fällt
euch denn noch was ein, wo wir Algorithmen im Alltag benutzen?

**Alfrothul:** Ja! Wenn wir nach Wörtern in einem Wörterbuch oder Inhaltsverzeichnis
suchen. Wir wissen dass die Einträge alphabetisch sortiert sind und wenn wir ein Wort
angucken, können wir abschätzen, wieviel weiter vorne oder hinten das Wort sein muss,
was wir suchen.

**Brynja:** Stimmt, gut bemerkt Alfrothul! Ich habe auch noch einen. Wenn wir einem
Kochrezept folgen. Dann machen wir genau die Schritte, die das Rezept vorgibt.

**Sigrid:** Ach, zurück zu Woche 01?

**Brynja:** Stimmt, da hatten wir noch mehr solche Vergleiche. Fällt dir sonst noch
was ein Sigrid?

**Sigrid:** Hm... vielleicht... Wenn wir Karten spiele und ich sortiere die Karten
auf meiner Hand?

**Brynja:** Stimmt... Aber ist das algorithmisch? Ich meine: folgst du einer festen
Vorgehensweise?

**Sigrid:** Ja, ich nehme immer eine Karte, die nicht in die Reihenfolge passt und
sortiere sie ein wo sie besser passt.

**Alfrothul:** Für mich klingt das auf jeden Fall nach einem Algorithmus.


Suchen und Sortieren
====================

Wie unsere Freunde gerade schon bemerkt haben, benutzen wir im Alltag viel mehr
Algorithmen als uns klar ist. Heute wollen wir uns aber mit solchen beschäftigen, die
wir mit relativer leichtigkeit unserem Computer beibringen können.

(Eine Bermerkung an der Seite: Zu Algorithmen gehören immer auch Datenstrukturen. Da
der Umfang dieses Kurses begrenzt ist, werden wir also nicht alle Algorithmen aus
diesem Abschnitt auch implementieren können. Dennoch ist es wichtig die Übungen zu
machen um das Gehirn auf diese Denkweise zu trainieren.

Die Fähigkeit strukturiert zu denken ist, wie jede andere Fähigkeit, eine, die
praktische Übung erfordert. Wir lernen nicht zu tanzen indem wir Bücher über's Tanzen
lesen, sondern nur indem wir Musik an machen und uns dazu bewegen.)

Im folgenden werden wir einige gängige Algorithmen aus der Informatik in der realen
Welt ausprobieren.


Binäre Suche
============

Die binäre Suche ist der schnellste Algorithmus um einen Eintrag in einer sortierten
Liste zu finden. Und noch dazu ist er einer der einfachsten.

Bemerke jedoch, dass die Liste sortiert sein muss, damit die binäre Suche funktioniert!

Für das Beispiel eines Wörterbuches lautet der Algorithmus wie folgt:

::

   Lass n_s Seite 1 und n_e die Anzahl der Seite im Wörterbuch sein

   Lass W das Wort sein, was du suchst

   XX
   
     Schlage das Wörterbuch auf Seite (n_e - n_s)/2 auf
     (also in der Mitte des Bereiches in dem du suchst)

     Bestimme ob dein Wort im Bereich der Seite liegt.

         Wenn JA: Fertig. Du hast die richtige Seite gefunden
 
         Wenn NEIN: Bestimme ob dein Wort vor der aufgeschlagenen Seite ist.

             Wenn JA: das neue n_e ist nun die aufgeschlagene Seitenzahl.
                      Wiederhole die Schritte ab XX. 

             Wenn NEIN: das neue n_s ist nun die aufgeschlagene Seitenzahl.
                      Wiederhole die Schritte ab XX.


In Worten:

* in der binären Suche definieren wir erst den Bereich in dem wir suchen
  (das Wörterbuch zwischen der ersten und der letzten Seite).

* Dann schauen wir uns das Element (die Seite) genau in der Mitte des Suchbereiches
  an.

  * Ist es das Element, was wir suchen, sind wir fertig.

  * Ist es nicht das Element, was wir suchen, definieren wir einen neuen
    Suchbereich. Wir wissen, dass die Liste von Elementen (das Wörterbuch) sortiert
    ist und können daher bestimmt, ob wir vor der aktuellen Position (aufgeschlagenen
    Seite) gucken müssen, oder dahinter.

    Nun ist der neue Suchbereich die Hälfte vor oder hinter der aktuellen Position
    und in die andere Hälfte brauchen wir nie wieder einen Blick zu werfen.


Dieser Algorithmus halbiert mit jedem Durchgang die Größe des Bereiches, in dem noch
zu suchen ist. Mathematisch würden wir sagen, wenn der Suchbereich *n* Elemente hat,
braucht der Algorithmus :math:`log_2 n` Durchläufe um das richtige Element zu finden. 


Übung 16
========

a. Nimm ein Wörterbuch zur Hand und fürhe ein paar binäre Suchen durch. Wähle dazu
   beliebige Wörter, oder lass dir `ein Zufallswort generieren <https://capitalizemytitle.com/zufallswort-generator/>`_.

(Tipp: Einem Menschen fällt es nicht so leicht genau in der Mitte einer Liste
nachzuschauen wie einem Computer. Daher reicht es, wenn du jedes Mal ungefähr in der
Mitte aufschlägst.)

b. Was passiert, wenn das Wort nicht im Wörterbuch steht?

c. Überlege dir, wie du das Problem, das du in Aufgabe b. identifiziert hast im
   Algorithmus lösen oder verbessern könntest.

d. Der deutsche Wortschatz wird auf bis zu 500.000 Wörter `geschätzt <https://www.statistik-bw.de/Service/Veroeff/Monatshefte/20100911>`_. 
   Wie viele Durchläufe bräuchte die Binäre Suche um ein bestimmtes Wort in einer
   Liste alle Wörter zu finden?


   
   



Version of "algorithmisches-denken"
===================================
Erstellt [2023-01-22]
