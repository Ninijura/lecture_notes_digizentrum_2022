==================================================
 Sprachen, Meta-Sprachen und Programm-Verarbeiter
==================================================

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

Wir haben auch `bereits gesehen <../week-01/week-01-einleitung_simulation_und_wirklichkeit.html#programme>`_,
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
`Simultandolmetscher <https://de.wikipedia.org/wiki/Simultandolmetschen>`_
der Informatik.

Um genauer zu sein: Ein Interpreter ist ein Programm, das ein anderes Programm
ausführt. Damit ist es außerdem ein Programm-Verarbeiter (program processor).


Übung 8
=======
Überlege dir kurz wie Aristoteles
`vier Ursachen <https://en.wikipedia.org/wiki/Four_causes>`_
für einen Interpreter aussehen. Also:

* wofür wird ein Interpreter benutzt?
* was für Daten verarbeitet ein Interpreter?
* was für Operationen (Berechnungen) führt der Interpreter mit diesen Daten durch?
* welche Methoden benutzt der Interpreter für diese Operationen?

Der Sinn dieser Aufgabe ist, dass du ein besseres Verständnis dafür bekommst, was ein
Interpreter ist.


I-Diagramme und gestapelte Interpreter
======================================

Ein Interpreter ist in einer Meta-Sprache geschrieben (also in einer
Implementationssprache). Wir können Interpreter als I-Diagramme darstellen.

* QS steht für die Quellsprache (der interpretierten Programme) and
* ZS steht für die Meta-Sprache (in der der Interpreter geschrieben ist:

.. ditaa::

   +----+
   | QS |
   |    |
   |    |
   |    |
   | MS |
   +----+


Kurz gesagt,

* ein Interpreter für QS-Programme ist ein "QS-Interpreter" (also ein Interpreter für
  QS-Programme, der selbst in MS geschrieben und somit ein MS-Programm ist),
* ein Interpreter für QS-Programme wird auch manchmal als "ein Interpreter für QS,
  implementiert in MS" bezeichnet, obwohl er eigentlich Programme verarbeitet, nicht
  die Sprache.

*Terminologie:*
* Wenn ein Interpreter für Byte Code oder Assembly (Sprachen, die sich
besser für Maschinen eignen als für Menschen) in der Hardware eingebaut ist, nennt er
sich Mikroprozessor,
* wenn er in Software geschrieben ist, nennt er sich eine Virtuelle Maschine.

(Gedankenfutter: Benutzt du auch manchmal eine Virtuelle Maschine? Vielleicht sogar
in diesem Kurs?)

Wir werden im Folgenden Mikroprozessoren (hier im Beispiel für Programme in der
Sprache x86) wie folgt darstellen:

.. ditaa::

   +-----+
   | x86 |
   |     |
   

und Programme (hier im Beispiel in x86 geschrieben) wie folgt:

.. ditaa::

   +-----+
   | x86 |
   | {d} |
   +--+--+


Die Ausfürhung dieses Programmes mit dem obigen Mikroprozessor zeigen wir so:

.. ditaa::

   +-----+
   | x86 |
   | {d} |
   +--+--+
   
   +-----+
   | x86 |
   |     |

   
Der x86-Mikroprozessor führt das x86-Programm aus. Bemerke dabei, dass sowohl die
Sprache des Mikroprozessors als auch die des Programms x86 ist. Wenn wir versuchen
würden, dem Mikroprozessor ein OCaml-Programm zu verfüttern, käme dabei nichts weiter
heraus als ein verwirrter Mikroprozessor und ein frustrierter Programmierer.

Wenn wir ein Programm ausführen wollen, was nicht in der Sprache unseres Prozessors
geschrieben ist, dann brauchen wir einen Übersetzer für das Programm. Wie praktisch,
dass wir gerade über Interpreter gelernt haben.

Wenn wir die folgenden drei Artefakte haben:

1. einen x86 Mikroprozessor:

.. ditaa::

   +-----+
   | x86 |
   |     |


2. einen Interpreter für OCaml-Programme, implementiert in x86: 

.. ditaa::

   +-----+
   |OCaml|
   |     |
   |     |
   |     |
   |     |
   | x86 |
   +-----+


3. ein OCaml-Programm:

.. ditaa::
   
   +-----+
   |OCaml|
   | {d} |
   +--+--+

Dann können wir die Ausfürhung des OCaml-Programms wie folgt darstellen:

.. ditaa::

   +-----+
   |OCaml|
   |{d}  |
   +--+--+

   +-----+
   |OCaml|
   |     |
   |     |
   |     |
   |     |
   | x86 |
   +-----+   

   +-----+
   | x86 |
   |     |

    
Der x86-Mikroprozessor führt den OCaml-Interpreter aus, der das OCaml-Programm
ausfürht.

Bemerke wieder:

* Der Mikroprozessor für x86-Programme führt ein x86-Programm aus (den Interpreter),
  und
* der OCaml-Interpreter führt ein OCaml-Programm aus. 


Übung 9
=======

Jetzt dürft ihr selbst abstrahieren. 

Stellt euch vor ihr habt:

* einen x86-Mikroprozessor
* einen x86-Interpreter, geschrieben in OCaml
* einen OCaml-Interpreter, der in x86 geschrieben ist
* einen Interpreter für PHP-Programme, der von einem OCaml-Interpreter ausgeführt
  werden kann
* einen Interpreter, geschrieben in PHP, der Scheme-Programme ausführt
* einen Interpreter für Rust, geschrieben in Lisp

Welche der folgenden Programme könnt ihr damit ausführen?

a. ein x86-Programm
b. eines, was in Scheme geschrieben ist
c. eine Webanwendung in PHP
d. einen Interpreter für Lisp, der in PHP geschrieben ist
e. ein Programm, dass zwei Zahlen zusammenlegen kann und in OCaml implementiert ist
f. ein Rust-Programm
g. ein Programm, das in Lisp geschrieben ist und von eins bis unendlich zählt

(Tipp: zeichne die Diagramme auf, das macht es leichter, sich die Kette von
Interpretern vorzustellen.)
(Tipp 2: falls du bei sehr vielen Fragen "nein" antwortest, denk daran: Interpreter
sind auch nur Programme.)


Ein letztes Wort über Virtuelle Maschinen
=========================================

Wenn eine Firma einen neuen Mikroprozessor in einer tollen neuen Sprache entwickelt
(nennen wir sie x86), ist es sehr teuer, den Mikroprozessor für jede Korrektur neu zu
bauen. Daher wird der Mikroprozessor erst einmal als Virtuelle Maschine
simuliert. Zum Beispiel:

.. ditaa::

   +-----+
   | y86 |
   |     |
   |     |
   |     |
   |     |
   |OCaml|
   +-----+


Compiler
========

Wenn Interpreter das maschinelle Pendant zu Simultandolmetschern sind, dann sind
Complier das maschinelle Pendant zu Textübersetzern.

Während der Interpreter die Befehle nimmt wie sie kommen und die Interpretation
direkt ausspuckt, ist das Input für einen Compiler ein Programme und der Compiler
spuckt (wenn er richtig geschrieben ist) ein äquivalentes Programm in einer anderen
Sprache aus. 

Kompakter gesagt: Ein Compiler ist *ein Programm zum Übersetzen anderer Programme*
von einer Sprache (Quellsprache) in eine andere (Zielsprache). Compiler erhalten die
Funktionalität der Programme, die sie übersetzen. Das heißt, das Quellprogramm und
das Zielprogramm führen die gleiche Funktion aus, nur die Sprache in der sie
implementiert sind ist unterschiedlich.

Übung 10
========

Schreibe die vier Ursachen eines Compilers auf.

(Tipp: wie in :ref:`Übung 8`.)


T-Diagramme
===========

Wir können Compiler als T-Diagramme darstellen, wo

* QS für die Quellsprache steht,
* ZS für die Zielsprache (der kompilierten Programme) steht und 
* IS für die Implementationssprache steht (also die Sprache, in der der Compiler
  geschrieben ist).

.. ditaa::

   +----------------+
   |                |
   | QS          ZS |
   |                |
   +----+      +----+
        |      |
        |      |
        |      |
        |  IS  |
        +------+


Kurz gesagt ein Compiler, der Programme von QS nach ZS übersetzt und selbst in IS
geschrieben ist, als "ein QS-Compiler" bezeichnet.

Compiler sind in der Informatik ihr eigenes Fachgebiet, ihr braucht euch also nicht
um mehr zu kümmern als wie man sie benutzt.

Zum Beispiel, nehmen wir an wir haben (1) einen x86 Mikroprozessor, (2) einen
OCaml-Compiler in x86 implementiert und (3) ein OCaml-Programm. Dann können wir das
Programm ausführen indem wir (a) den Compiler vom Mikroprozessor ausführen lassen und
das Programm in ein äquivalentes x86-Programm übersetzen und (b) dieses Programm dann
vom Mikroprozessor ausführen lassen.

* So sieht Schritt (a) aus:

.. ditaa::

  +-------+ +---------------+  +-------+
  |       | |               |  |       |
  | OCaml | | OCaml     x86 |  |  x86  |
  |  {d}  | |               |  |  {d}  |
  +---+---+ +----+     +----+  +---+---+
                 |     |
                 |     |
                 |     |
                 | x86 |
                 +-----+
                 
                 +-----+
                 | x86 |
                 |     |


* und so Schritt (b):

.. ditaa::

   +-----+
   |     |
   | x86 |
   |{d}  |
   +--+--+

   +-----+
   | x86 |
   |     |


Wenn der Compiler korrekt ist (und davon gehen wir in diesem Kurs grundsätzlich aus),
dann bekommt man das gleiche Resultat, wenn man das OCaml-Programm ausführt wie wenn
man das kompilierte x86-Programm ausführt.

Wenn zum Beispiel das OCaml-Programm einen Integer (eine positive Ganzzahl) als Input
nimmt und bestimmt ob diese Zahl eine Primzahl ist, dann nimmt auch das x86 Programm
einen Interger als Input und bestimmt, ob er eine Primzahl ist.

Wenn wir zum Beispiel also das folgende haben:

* ein PHP-Programm
* einen Compiler von PHP nach OCaml, implementiert in x86
* einen Compiler von OCaml nach x86, implementiert in x86 und
* einen x86 Mikroprozessor,

dann können wir das Programm ausführen wie folgt (für die Kompaktheit ist es erlaubt
den Prozessor mehrmals abzubilden; das symbolisiert, dass er mehrere Programme
ausführt): 

.. ditaa::

  +-----+ +---------------+ +---------------+  +-----+
  |     | |               | |               |  |     |
  | PHP | | PHP     OCaml | | OCaml     x86 |  | x86 |
  | {d} | |               | |               |  | {d} |
  +--+--+ +----+     +----+ +----+     +----+  +--+--+
               |     |           |     |      
               |     |           |     |       +-----+
               |     |           |     |       | x86 |
               | x86 |           | x86 |       |     |
               +-----+           +-----+       |     |
                                              
               +-----+           +-----+      
               | x86 |           | x86 |      
               |     |           |     |       

Hier wird das Input-PHP-Programm vom ersten Commpiler nach OCaml übersetzt und danach
das resultierende OCaml-Programm weiter nach x86. Das x86-Programm kann dann unser
Mikroprozessor ausführen. 


Übung 11
========

Du hast:

* einen x86-Mikroprozessor
* einen PHP-Compiler, der nach SML übersetzt, in x86 geschrieben
* eine Virtuelle Maschine für OCaml
* einen Compiler, der SML nach PHP übersetzt, implementiert in OCaml
* einen x86-Compiler, der auf OCaml-Prozessoren läuft und nach SML üersetzt
* einen Compiler, der von SML nach OCaml übersetzt und in x86 geschrieben ist
* einen SML-Compiler, der in OCaml geschrieben ist und dessen Outputs Rust-Programme
  sind

Welche der folgenden Programme kannst du damit ausführen?

a. ein x86-Programm
b. ein Rust-Programm
c. einen OCaml-Interpreter, der in Scheme geschrieben ist
d. einen PHP-Compiler, der in x86 implementiert ist und nach Rust übersetzt
e. einen SML-Interpreter, der in PHP geschrieben ist
f. eine SML-Programm, dass zwei Zahlen addiert
g. einen Tiger-Compiler, der in SML geschrieben ist und nach x86 kompiliert  



Übung 12
========

Wie auch bei Interpretern dürfen wir beim Arbeiten mit Compilern nicht vergessen,
dass Compiler auch nur Programme sind. Und wie wir schon gemerkt haben: *was für den
einen ein Programm ist, ist für das andere Programm ein Input.* Du kannst also auch
Interpreter und Compiler interpretieren und übersetzen.

Jetzt wird es also noch ein wenig schwieriger. Haltet "die Zunge gerade im Mund", wie
man auf Dänisch zu sagen pflegt.
  
Du hast:

* einen x86-Mikroprozessor
* einen PHP-Compiler nach x86 in OCaml
* einen OCaml-Compiler in Lisp, der nach PHP übersetzt
* eine Virtuelle-Maschine für SML
* einen SML-Compiler, dessen Output OCaml-Programme sind, in PHP geschrieben
* einen Compiler, der OCaml nach PHP übersetzt, in x86 geschrieben
* einen Interpreter für Tiger-Programme, der in Scheme geschrieben ist
* einen Programm-Prozessor, der ein Scheme-Programm als Input nimmt un ein
  äquivalentes SML-Programm als Output gibt; Implementationssprache SML
* einen Programm-Prozessor, der ein Lisp-Programm als Input nimmt und einen
  Go-Interpreter in x86 geschrieben als Output gibt
* einen Programm-Prozessor, der in Tiger geschrieben ist, ein Go-Programm als Input
  nimmt und einen Lisp-Compiler in Rust geschrieben als Output gibt 
* einen Programm-Prozessor, der ein Rust-Programm als Input nimmt und die Zahl 42 als
  Output gibt, geschrieben in x86

Welche der folgenden Programme kannst du damit ausführen.

a. einen PHP-Compiler nach x86 in OCaml
b. ein Programm, dass zwei Zahlen addiert, in Rust geschrieben
c. ein Programm, dass in bis unendlich zählt, geschrieben in PHP
d. ein x86-Programm
e. einen Scheme-Interpreter geschrieben in Tiger
f. ein SML-Programm
g. ein Go-Programm
h. ein Lisp-Programm
i. ein Lisp-Programm, wenn du auch ein Go-Programm hast
j. ein Go-Programm, wenn du auch ein Lisp-Programm hast
k. einen OCaml-Interpreter, der in OCaml geschrieben ist

(Tipp: Bei dieser Übung kann es von Vorteil sein, die Lösungen zu zeichnen.)


Kurzes Nachwort über den Sinn
=============================
Ja, es hat einen.

Das hier sind nicht nur verwirrende Übungen oder nutzloses Wissen
über die tieferen Zusammenhänge. Diese Übungen trainieren euch, komplexe Probleme
systematisch anzugehen und bereiten euch auf ähnliche Herausforderungen vor, die
nicht so leicht zu visualisieren sind. Es ist auch eine gute Vorbereitung für
algorithmisches Denken, was wir in einer späteren Woche lernen werden. 
  

Bootstrapping
=============

Vielleicht kennt ihr die Geschichte vom Baron Münchhausen, der sich an seinen eigenen
Stiefelriemen aus dem Sumpf gezogen hat. Genau daher kommt der Name Bootstrapping.

Stell dir vor, du hast eine neue Programmiersprache entwickelt und möchtest jetzt
einen Compiler dafür schreiben. Weil deine Sprache (nenne wir sie ML für "Marvellous
Language (fantastische Sprache)) so großartig ist, möchtest du natürlich deinen
Compiler gerne in ML schreiben.

Jetzt hast du einen Compiler für ML nach x86, geschrieben in ML. Nur doof, dass du
deinen Compiler nicht kompilieren kannst.

Für diesen Zweck schreibst du einen "schnell-und-dreckig"-Compiler in einer anderen
Sprache. Dann kompilierst du deinen Compiler mit dem
schnell-und-dreckig-Compiler. Das ist jetzt aber noch kein besonders effektiver Code,
also benutzt du diesen schnell-und-dreckig kompiliereten Compiler um deinen schönen
ML-Compiler noch einmal zu übersetzen. Das Resultat dieses Kompiliervorgangs ist ein
Compiler für ML nach x86 geschrieben in x86, der sich sozusagen selbst kompiliert
hat.

Bootstrapping ist nichts, was wir in diesem Kurs lernen werden, aber es sich
vorzustellen ist eine gute Übung für die Denkmuster. 


               
Version
=======

Erstellt [2022-10-15]

Aktuelle Version [2023-01-15]
