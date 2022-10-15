===============================
Den Computer mit Emacs erkunden
===============================

In diesem Kapitel geht es darum, den Editor Emacs benutzen zu lernen.


Wer ist denn dieser Emcas?
==========================
Emacs ist ein Textverarbeitungsprogramm und sehr hilfreich, wenn man viel schreiben
und geschriebenes korrigieren muss. Emacs ist außerdem erweiterbar und
programmierbar; wer die ersten Übungen gelöst hat, hat schon ein paar Erfahrungen
damit gesammelt, dass Emacs einen OCaml-Prozessor ausführen und Dateien lesen kann.


Zwischenspiel
=============

**Vigfus:** Warum sollen wir denn eigentlich Emacs lernen? Können wir nicht einfach
Word benutzen?

**Sigrid:** Jammer nicht rum, mach einfach.

**Alfrothul:** Nein, Sigrid, er hat schon Recht. Warum eigentlich?

**Sigrid:** Ihr habt doch schon gelesen, dass Emacs einen OCaml-Prozessor ausführen
kann. Reicht das nicht?

**Vigfus:** Nein, warum bearbeiten wir nicht die Dateien in Word und benutzen Emacs
nur zum ausführen?

**Sigrid:** Hm... achso. Stimmt, eigentlich eine gute Frage.

**Bryja:** Ich habe schonmal ein Bisschen mit Emacs rumprobiert und das Ergebnis:
mein Mausarm ist viel besser geworden.

**Vigfus:** Was hat das mit Emacs zu tun?

**Brynja:** In Emacs sind die Shortcuts so gelegt, dass man die Finger im Prinzip die
ganz Zeit auf der Tastatur liegen lassen kann. Man braucht nur die <Strg>-Taste
ziemlich viel. Das geht etwas auf den kleinen Finger.

**Alfrothul:** Ich habe mal was gehört, dass man <Strg> auf die Feststelltaste legen
kann. Dann ist es viel natürlicher.

**Brynja:** Gute Idee!

**Vigfus:** Ich bin zwar noch nicht überzeugt, aber ich werde es doch auf jeden Fall
mal ausprobieren. Klingt interessant.


Übung 7
=======

Verwende etwas Zeit (gerne eine Stunde) um durch das Emacs-Tutorial zu gehen (``C-h
t``).


Ein kleiner Spaziergang durch das Dateisystem
=============================================

Du hast also Emacs gestartet. Emacs ist ein Programm und wird immer in einem Ordner
im Dateisystem des Computers ausgeführt. In welchem? Um das herauszufinden, gib ein:

::

   C-x C-f


Die Antwort steht jetzt im sogenannten "minibuffer" an der unteren Kante des
Fensters. Und wahrscheinlich ist es nicht der Ordner, in dem du sein möchtest. Um das
zu ändern und in dein Benutzerverzeichnis zu gehen, gib ein:

::

   ~/. RET


Das heißt eine ``~`` (Tilde), gefolgt von einem ``/`` (Slash), gefolgt von einem
``.`` (Punkt), gefolgt von der <Enter>-Taste. Das Resultat davon ist die ganze
Herrlichkeit deines Heimatordners, alphabetisch sortiert noch dazu. Wenn du den
Buffer (das Emacs-Unterfenster) nach datum sortieren willst, drück ``s``; und noch
einmal ``s``, wenn du es wieder nach Namen sortiert haben möchtest (``s`` für
``s`` -ortieren, natürlich).

Der Modus, in dem der Buffer ist, heißt Dired; das ist kurz für "directory edit",
also Verzeichnis-Berarbeitung.

In diesem Buffer kannst du dich mit ``C-n`` nach unten und mit ``C-p`` Zeile um Zeile
nach unten bewegen. (Oder alternativ mit den Pfeiltasten, aber dann müsstest du deine
Finger von ihrer natürlichen Tastaturposition weg bewegen.)

Um einen neuen Ordner anzulegen, tippe ``+``, dann den Namen des neuen Ordners, dann
``RET`` (also die <Enter>-Taste). (Um mehr über die Tastenkombinationen für diesen
Modus herauszufinden, gib ``C-h B`` (achtung, großes B!)).

Lege nun im Ordner ``Kurse`` einen Ordner mit Namen ``Einführung-ins-Programmieren``
an:

::

   C-x C-f ~/Kurse/Einführung-ins-Programmieren/ RET


(Tipp: die Tabulator-Taste komplettiert automatisch Namen von vorhandenen Ordnern.)


Es ist eine Gute Idee, außerdem Unterordner für ``Woche-01``, ``Woche-02``,
etc. anzulegen.

Der Rest dieses Kapitels nimmt an, dass du im Ordner
``~/Kurse/Einführung-ins-Programmieren/Woche-01/`` bist.


Denkanstoß
==========

Wenn du im Hinterkopf behältst, dass ``..`` im Namen eines Ordners für den Ordner
direkt über dem aktuellen steht, welches sind die folgenden Ordner?

* ``~/Kurse/Einführung-ins-Programmieren/Woche-01``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/.``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/..``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../.``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../Woche-02``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../Woche-02/``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../Woche-02/.``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../Woche-02/..``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../Woche-01``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../Woche-02/../Woche-01``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../Woche-02/../Woche-01``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../..``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../../``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../../.``
* ``~/Kurse/Einführung-ins-Programmieren/Woche-01/../../..``

Tipp: benutze Emacs und gib für jeden dieser Namen ``C-x``, gefolgt von ``C-f``,
gefolg von dem jeweiligen Namen, gefolgt von ``RET`` ein.

.. epigraph::

   **Vigfus:** Hey! Ich frage mich, was passiert, wenn ich einfach nur ``C-x
   C-f .. RET`` eingebe.
   **Brynja:** Na probier's aus!

Über das bearbeiten von mehreren Fenster
========================================

Erinnerung:

* ``C-x 3`` teilt das aktive Fenster in zwei Fenster nebeneinander
* ``C-x 2`` teilt das aktive Fenster in zwei Fenster untereinander
* ``C-x 1`` schließt alle Fenster bis auf das aktive 
* ``C-x 0`` schließt das aktive Fenster (aber nicht die geöffnete Datei. Du kannst
  sie wiederfinden mit ``C-x C-b``)


Konklusion
==========

Du hast nun volle Kontrolle darüber, wo deine Dateien sind und in welchem Ordner dein
Emacs gerade läuft.

.. epigraph::

   **Sigrid:** Mann! Emacs hat ja echt alles.
   **Alfrothul:** Hast du schon ``M-x hanoi`` probiert?
   **Brynja:** Und ``M-x life``?
   **Loki:** Und ``M-x doctor``?


Version
=======

Erstellt [2022-10-15]
