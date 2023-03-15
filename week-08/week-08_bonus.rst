Bonusübungen
============
Hier sind noch ein paar Bonus-Übungen für die mutigen und fleißigen. Hier wird nicht
viel erklärt, aber mit dem was ihr bisher gelernt habt, müsstet ihr das alles
hinbekommen. Benutzt auch gerne die Übungen der vergangenen Wochen als Spickzettel.

Wenn ihr fertig seid, findet ihr Lösungen :download:`hier
<../exercises/week-08/exercises_for_week-08.ml>`. Bedenkt dabei jedoch, dass dies
keine definitiven Lösungen sind, sondern nur eine Art es richtig zu machen. Wenn ihr
fleißig immer erst Tests schreibt und dann die Funktionen, solltet ihr in der Lage
sein, eure Ergebnisse selbst zu überprüfen.

Wenn ihr bei den Übungen stecken bleibt, kann es hilfreich sein, sich die
Testfunktionen in der Lösungsdatei anzuschauen.




Ganzzahlen
----------


Bonusübung 1
------------
Wir haben den Typen für natürliche Zahlen definiert. Definiere nun auf die gleiche
Art einen Typen für alle Ganzzahlen (positive und negative).

Tipp: Gibt es einen Mittelpunkt für alle Zahlen?

Noch ein Tipp: Du brauchst wahrscheinlich drei Konstruktoren.


Bonusübung 2
------------
Schreibe Vorgänger- und Nachfolger-Funktionen für deinen Ganzzahl-Typen. Versuche die
Zahlen möglichst klein zu halten.


Bonusübung 3
------------

Schreibe Funktionen, die zwischen deinem Ganzzahltypen und dem OCaml-nativen ``int``
hin und her konvertieren. 


Werkzeuge
---------

Ich habe euch eine :download:`Datei mit hilfreichen Werkzeugen
<../exercises/week-08/tools.ml>` angelegt. Hier findet ihr unter
anderem die Funktion ``normalise_g``. Diese Funktion bringt eine
Ganzzahl mit der beigefügten Definition auf Normalform. Das bedeutet,
dass sie dafür sorgt, dass in der Zahl entweder nur der Konstruktor
``P`` oder nur der Konstruktor ``S`` vor dem ``O`` steht.

Hier ein paar Beispiele:

::

   normalise_g (S O) -> S O
   normalise_g (P O) -> P O
   normalise_g (S (P O)) -> O
   normalise_g (P (S O)) -> O
   normalise_g (P (S (S (S (P (P (S (P (P (P O)))))))))) -> P (P O)

Das ist, weil sich ein ``P`` und ein ``S``gegenseitig aufheben; sie
sind schließlich die inversen Funktionen von einander: Vorgänger und
Nachfolger. 



Bonusübung 4
------------

Schreibe Funktionen für die Operationen Addition, Subtraktion und
Multiplikation über Ganzzahlen.

Tipp: Überlege dir erst, wie für jede der Operationen der Basisfall
und der Induktionsfall aussehen. Danach ist das schreiben der Funktion
nur noch Formalität.

Bonus Tipp: Benutze die Funktion ``normalise_g`` aus der
:download:`Werkzeuge-Datei <../exercises/week-08/tools.ml>` um sicher
zu gehen, dass deine Ergebnisse auch so aussehen, wie dein Test (und
du) es erwartet. 
