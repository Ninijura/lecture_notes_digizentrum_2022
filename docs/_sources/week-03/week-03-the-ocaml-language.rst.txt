=========================================================================
OCaml: eine Sprache von algebraischen Ausdrücken mit Namen und Funktionen
=========================================================================

OCaml ist eine typisierte Sprache. Ihre syntaktischen Einheiten sind typisierte
Ausdrücke, und wenn man einen typisierten Ausdruck berechnet (evaluiert), ist das
Ergebnis ein Wert mit dem selben Typen wie der des Ausdrucks.

Das Ziel dieses Kapitels ist es, OCaml Ausdrücke und ihre Grammatik zu präsentieren
sowie die Grammatik von OCamls Typensystem.

(Für die Fachausdrücke werden wir die gängigen englischen Bezeichnungen verweden, da
dies die am häufigsten gebrauchte Ausdrücke sind.) 

::

   <type>       ::= ...

   <expression> ::= ...

Jeder Ausdruck (expression) hat einen Typen:

::

   G |- e : t

In Worten: in der Typenumgebung (type environment) ``G``, hat der Ausdruck
(expression) ``e`` den Typen ``t``.

Im Rest des Lehrmaterials für diese Woche werden wir ``G``, ``e`` und ``t`` weiter
definieren.


Toplevel-Loop
=============

Wir interagieren mit OCaml in der Toplevel-Loop, die wir schon in der ersten Woche
gesehen haben. Hier druckt der OCaml-Prozess ein ``#`` als Eingabeaufforderung und
wir können Ausdrücke schreiben. Wenn diese Ausdrücke grammatikalisch korrekt und
typenkorrekt sind, dann evaluiert der OCaml-Prozess den Ausdruck und druckt das
Ergebnis.

::
   <toplevel-expression> ::= <expression>


Kommentare
==========

Ein Kommentar ist eine beliebe Abfolge von Zeichen, die mit ``(*`` anfängt und mit
``*)`` abgeschlossen wird. Kommentare werden von OCaml bei der lexikalischen Analyse
(die analysiert ob ein Ausdruck korrekt ist) übersprungen.

Kommentare können außerdem verschachtelt sein (So wie Klammern in Texten. (Das heißt
das, wenn man im Kommentar einen anderen Kommentar anfängt, muss man beide beenden.
(So wie bei Klammern in Texten. (Ich kann schließlich nicht einfach 4 Klamemrn öffnen
und nur 2 wieder schließen...) (Emacs kann euch übrigens damit helfen, immer die
zugehörigen Start- oder Endklammern zu finden. Diese Hilfe könnt ihr aktivieren mit
``M-x show-paren-mode RET`` oder indem ihr in eurer .emacs-Datei (der Datei mit den
Einstellungen für Emacs) ``(show-paren-mode 1)`` hinzufügt.)))).


Integer
=======

Oder auf deutsch: Ganzzahlen.

In Woche-01 haben wir Integer benutzt und die Konstanten ``min_int`` und ``max_int``
gefunden.

Wir erweitern also unsere Grammatik um den Typen ``int``. 

::

   <type>       ::= int

   <expression> ::= <integer>

   <integer>    ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ... | -4611686018427387903 | 4611686018427387903 | -4611686018427387904

Dementpsrechend bekommen wir eine Typen-Regel wie folgt:

::

   INT ----------------- wo n ein Integer ist
          G |- n : int

Solche Regeln lesen wir wie folgt:

* Der Name der Regel ist (in diesem Beispiel) ``INT``.
* über dem Strich stehen die Voraussetzungen.
* unter dem Strich steht was unter den Voraussetzungen außerdem korrekt ist.

In diesem Fall: In einer beliebigen Typenumgebung ``G`` hat eine Ganzzahl ``n`` den
Typen ``int``.

Außerdem: wenn man einen Integer evaluiert, hat das ist das Ergebnis ebendieser
Integer vom Typen ``int``.

**Aufgabe:** Probiere selbst mit dem OCaml-Prozess und integern herum. Finde heraus,
wie Vorzeichen funktionieren.


Booleans (Ganzzahlen)
=====================

OCaml hat Booleans:

::
   <type>       ::= int | bool

   <expression> ::= <integer>
                  | <boolean> 

   <integer>    ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ...

   <boolean>    ::= true | false

Die entsprechenden Typenregeln sind:

::

   BOOL_TRUE--------------------
              G |- true : bool

   BOOL_FALSE-------------------
              G |- false : bool

In Worten:
* in einer beliebigen Typenumgebung ``G`` hat der Wert ``true`` den Typen
``bool``; und
* in einer beliebigen Typenumgebung ``G`` hat der Wert ``false`` den Typen
``bool``.

Außerdem: wenn man einen Boolean evaluiert, ist das Ergebnis ebendieser Boolean.

::

   # true;;
   - : bool = true
   # false;;
   - : bool = false
   #

Probiere das gerne selbst aus.

Ein Tipp:

* ``M-p`` und ``M-n`` (gelesen: "meta-p" und "meta-n") lassen uns durch die Historik
  der Eingaben in unserer Toplevel-Loop gehen und die Ausdrücke wiederverwenden.
* Die Meta-Taste ist unter Windows und Linux Alt und option unter Mac.

Characters (Zeichen)
====================
In OCaml gibt es auch einen Typ für Zeichen:

::
   
   <type>       ::= int | bool | char

   <expression> ::= <integer>
                  | <boolean>
                  | <character>

   <integer>    ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ...

   <boolean>    ::= true | false

   <character>  ::= ein Zeichen in einfachen Anführungszeichen

Die zugehörige Typenregel lautet:

::

  CHAR-------------------- wo c ein Zeichen ist*
        G |- c : char

(``*`` "Zeichen" ist hier in OCamls Verständnis von Zeichen gemeint. Das heißt ``c``
ist kein Zeichen, aber ``'c'`` ist ein Zeichen.)

In Worten:

* in einer beliebigen Typenumgebung ``G`` hat ein Zeichen ``'c'`` (in einfachen
  Anführungszeichen) den Typen ``char`` (für englisch character).

Außerdem: wenn man ein Zeichen evaluiert, ist das Ergebnis dieses Zeichen. 


Zwischenspiel
=============

**Sigrid:** Das heißt ein ``char`` in OCaml ist einfach ein Buchstabe zwischen zwei
``'``?

**Brynja:** Nicht nur ein Buchstabe, glaube ich, ein beliebiges Zeichen.

**Sigrid:** Das muss ich ausprobieren!

::

   # 'a';;
   - : char = 'a'
   # '(';;
   - : char = '('
   # '%';;
   - : char = '%'
   #

**Sigrid:** Ja, sieht ganz so aus.

**Loke:** Und was mit dem einfachen Anführungszeichen selbst?

**Alfrothul:** Oh-oh!

::

   # ''';;
   Error: Illegal empty character literal ''
   Hint: Did you mean ' ' or a type variable 'a?
   #

**Mimer:** OCaml nutzt den Backslash ``\`` um das einfache Anführungszeichen zu
schreiben.

**Brynja:** Also schreiben wir ``'\''`` für das einfache Anführungszeichen?

**Sigrid:** ``'\''``! Das muss ein Zeichen sein!

::

   # '\'';;
   - : char = '\''
   #

**Alfrothul:** Stimmt, ist ein Zeichen.

**Brynja:** Und damit OCaml nicht verwirrt wird, müssen wir den Backslash betimmt
auch mit Backslash davor schreiben:

::

   # '\\';;
   - : char = '\\'
   #

**Mimer:** Yup!


Strings (Zeichenfolgen)
=======================
OCaml hat auch Strings, die wir gewöhnlich für Wörter und Sätze benutzen:

::

   <type>       ::= int | bool | char

   <expression> ::= <integer>
                  | <boolean>
                  | <character>
                  | <string>

   <integer>    ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ...

   <boolean>    ::= true | false

   <character>  ::= ein Zeichen in einfachen Anführungszeichen

   <string>     ::= eine Folge von Zeichen zwischen doppelten Anführugszeichen

Die zugehörige Typenregel lautet wie folgt:

::

   STRING-------------------wo s ein string ist*
          G |- s : string

(``*`` "string" ist hier in OCamls Verständnis von string gemeint. Das heißt ``hallo``
ist kein string, aber ``"hallo"`` ist einer.)

In Worten:
* in einer beliebigen Typenumgebung ``G`` hat ein String ``s`` den Typen ``string``.

Außerdem:
* einen String zu evaluieren gibt als Ergebnis ebendiesen String.

**Aufgabe:** Probier es selbst aus. Schreibe ein paar Strings in OCaml und schaue dir
das Ergebnis an.





Version of "the-ocaml-language"
===============================
Erstellt [2023-01-21]

