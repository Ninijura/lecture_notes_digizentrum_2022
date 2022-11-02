================================================
Sprachen, Meta-Sprachen und Programm-Verarbeiter
================================================

In diesem Kapitel geht es darum, wie die `Magie eines vorigen Kapitels <../week-01/einleitung_simulation_und_wirklichkeit.html>`_ funktioniert.

.. epigraph::
   | Jede hinreichend fortschrittliche Technologie
   | ist von Magie nicht zu unterscheiden.

   -- `Arthur C. Clarke <https://de.wikipedia.org/wiki/Arthur_C._Clarke>`_


Programmiersprachen, Programme und Daten
========================================

Wie bereits besrpochen,

* eine Pgrorammiersprache ist eine Notation um Berechnungen zu beschreiben;
* ein Programm ist etwas, was nach den Regeln dieser Notation geschrieben ist; es
  kann ausgeführt werden um eine Berechnung durchzuführen;
* eine Berechnung ist eine Verarbeitung von Daten; und
* Daten sind Repräsentationen von Informationen.

Eine natürliche Sprache (Dänisch zum Beispiel) ist eine Ansammlung von Buchstaben,
die zu Wörtern und dann zu Sätzen zusammengesetzt werden. Wörter bestehen aus
Buchstaben und Sätze bestehen aus Wörtern und Satzzeichen. Es gibt einen Konsens
darüber, was ein richtiges Wort ist (Rechtschreibung) und was ein richtiger Satz ist
(Grammatik). Rechtschreibung und Grammatik zusammen bilden die
`Syntax <https://de.wikipedia.org/wiki/Syntax>`_ der dänischen Sprache.

Wenn man ein Wort falsch schreibt, oder einen Satz falsch konstruiert, wird man
falsch oder gar nicht verstanden. Klare und verständliche Sätze übermitteln
Informationen. 

In Natürlichen Sprachen gibt es darüber hinaus noch die Möglichkeit mehrdeutig zu
sein; das Problem haben Programmiersprachen nicht.

Wir haben auch `bereits gesehen<../week-01/week-01-einleitung_simulation_und_wirklichkeit.html#programme>`_,
dass Kochrezepte in einer natürlichen Sprache geschrieben sind und Beispiele für
Programme sind.


Das Konzept von Meta-Sprachen
=============================

In Schulen hier in Deutschland lernen alle Schüler früher oder später
Englisch. Normalerweise wird Englisch mit einem Arbeitsbuch gelernt. Dieses
Arbeitsbuch ist (anfangs) wahrscheinlich auf Deutsch geschrieben und schwierige
Fragen beantwortet der Lehrer auch auf Deutsch. Für einen solchen Englisch-Schüler
ist deutsch die Meta-Sprache von Englisch; also die Sprache auf der man über eine
andere Sprache spricht.

Außer Englisch lernen die Schüler aber auch Deutsch in der Schule. Die deutschen
Arbeitsbücher sind auch auf Deutsch geschrieben und lehren Rechtschreibung und
Grammatik. Im Deutschunterricht ist also Deutsch die Meta-Sprache für Deutsch: Lehrer
und Schüler reden über Deutsch auf Deutsch.


Programme und die Sprachen, in denen sie geschrieben sind
=========================================================
Kurz gesagt: Ein Programm, das in beispielsweise OCaml geschrieben ist, nennen wir
ein "OCaml-Programm".



Interpreter
===========
Interpreter sind die
`Simultandolmetscher<https://de.wikipedia.org/wiki/Simultandolmetschen>`_
der Informatik.

Um genauer zu sein: Ein Interpreter ist ein Programm, das ein anderes Programm
ausführt. Damit ist es außerdem ein Programm-Verarbeiter (program processor).


Übung 8
=======

Überlege dir kurz wie Aristoteles
`vier Ursachen<https://en.wikipedia.org/wiki/Four_causes>`_
für einen Interpreter aussehen. Also:

* wofür wird ein Interpreter benutzt?
* was für Daten verarbeitet ein Interpreter?
* was für Operationen (Berechnungen) führt der Interpreter mit diesen Daten durch?
* welche Methoden benutzt der Interpreter für diese Operationen?

Der Sinn dieser Aufgabe ist, dass du ein besseres Verständnis dafür bekommst, was ein
Interpreter ist.

