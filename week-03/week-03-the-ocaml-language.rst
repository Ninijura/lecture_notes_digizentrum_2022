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

Die dazugehörige Typenregel lautet wie folgt:

::

   STRING-------------------wo s ein String ist*
          G |- s : string

(``*`` "String" ist hier in OCamls Verständnis von String gemeint. Das heißt ``hallo``
ist kein String, aber ``"hallo"`` ist einer.)

In Worten:

* in einer beliebigen Typenumgebung ``G`` hat ein String ``s`` den Typen ``string``.

Außerdem: einen String zu evaluieren gibt als Ergebnis ebendiesen String.

**Aufgabe:** Probier es selbst aus. Schreibe ein paar Strings in OCaml und schaue dir
das Ergebnis an.

Zwischenspiel über Strings
==========================

**Sigrid:** Lass mich raten -- wenn ein String das doppelte Anführungszeichen
enthalten soll, dann schreibt man einen Backslash davor:
::

   # "\"";;
   - : string = "\""
   #

**Alfrothul:** Sieht ganz so aus, ja. Und wahrscheinlich schreibt man einen Backslash
auch mit Backslash davor:

::

   # "\";;
   ";;
   - : string = "\";;\n"
   # "\\";;
   - : string = "\\"
   #

**Sigrid:** Stimmt, wenn du einfach nur einen Backslash schreibst, dann liest er die
Anführungszeichen am Schluss nicht als Anführungszeichen und die Semikolons nicht als
Ende des Ausdrucks, sondern wartet auf eine weitere Eingabe.

**Loke:** Und was ist dann ``"\\\\\\"``?

**Brynja:** Ganz logisch: ein String bestehend aus drei Backslashes.

**Sigrid:** Und gibt es auch einen leeren String?

::

   # "";;
   - : string = ""
   #

**Sigrid:** Tatsache!

**Alfrothul:** Wartet mal, was passiert eigentlich, wenn man nicht Buchstaben sondern
Zahlen schreibt? Dann ist es ja kein Wort mehr sondern eine Zahl zwischen zwei
Anführungszeichen...?

::

   # "42";;
   - : string = "42"
   #

**Sigrid:** Anscheinend trotzdem ein String... Müsste das nicht eher den Typen
``int`` haben, oder vielleicht sogar ``"int"``?

**Brynja:** Ich verstehe eure Verwirrung, aber den Typen ``"int"`` gibt es doch gar
nicht. ``"42"`` ist ein String aus zwei Zeichen, die halt zufälligerweise numerisch
sind. Genauso ist ``"d42"`` ein String. Was für ein Typ sollte denn das sonst nach
euch sein? ``charint``?

**Alfrothul:** Hm... stimmt. Dann ist wohl '2' auch kein ``'int'``, sondern ein
``char``, der aber halt zufälligerweise eine 2 ist.

**Sigrid:** Macht Sinn. Und den Typen ``'int'`` gibt es sowieso nicht. 


Conditional expressions (bedingte Ausdrücke)
============================================

Bisher waren alle Ausdrücke, die wir gesehen haben, nur einfache Werte. Conditionals
(oder if-Ausdrücke) sind die ersten Ausdrücke, die zu einem Wert reduziert werden
können, der nicht der Ausdruck selbst ist.

::

   <type>       ::= int | bool | char 

   <expression> ::= <integer>
                  | <boolean>
                  | <character>
                  | <string>
                  | if <expression> then <expression> else <expression>

   <integer>    ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ...

   <boolean>    ::= true | false

   <character>  ::= ein Zeichen in einfachen Anführungszeichen

   <string>     ::= eine Folge von Zeichen zwischen doppelten Anführugszeichen

Die zugehörige Typenregel lautet:

::

      G |- e1 : bool      G |- e2 : t      G |- e3 : t
   IF---------------------------------------------------
      G |- if e1 then e2 else e3 : t

In Worten:

* In einer beliebigen Typenumgebung ``G``, wenn
  
  * der Ausdruck ``e1`` (der Test) den Typen ``bool`` hat;
    
  * der Ausdruck ``e2`` (die Konsekvente) einen beliebigen Typen ``t`` hat; und
    
  * der Ausdruck ``e3`` (die Alternative) den gleichen Typen ``t`` hat,
    dann hat der Ausdruck ``if e1 then e2 else e3`` den Typen ``t``.

Außerdem:

* wenn wir ``if e1 then e2 else e3`` evaluieren, dann evaluieren wir zuerst den Test,
  ``e1``;
  
  * wenn das Evaulieren von ``e1`` divergiert (unendlich weiterläuft), dann
    divergiert auch das Evaluieren von ``if e1 then e2 else e3``;
    
  * wenn das Evaluieren von ``e1`` einen Fehler hervorruft, ruft das Evaluieren von
    ``if e1 then e2 else e3`` denselben Fehler hervor;
    
  * wenn das Evaluieren von ``e1`` einen Boolean als Ergebnis hat, dann
    
    * wenn dieser Boolean ``true`` ist, dann reduziert sich das Evaluieren von ``if
      e1 then e2 else e3`` auf ``e2``; und
      
    * wenn dieser Boolean ``false`` ist, dann reduziert sich das Evaluieren von ``if
      e1 then e2 else e3`` auf ``e3``.
      
Bedingte Ausdrücke sind polymorphisch; das bedeutet, dass sie einen beliebigen Typen
haben können. Die einzige Bedingung hierbei ist, dass sowohl der konsequente als auch
der alternative Ausdruck den gleichen Typen haben. Dieser Typ ist dann der Typ des
gesamten bedingten Ausdruckes. 


Ein Beispiel dazu, wie ein bedingter Ausdruck vom Typen ``int`` aussehen könnte:

::

   # if true then 1 else 2;;
   - : int = 1
   # if false then 1 else 2;;
   - : int = 2
   #

Die dementsprechenden Beweisbäume (proof trees) sehen wie folgt aus:

::

      BOOL_TRUE ----------------    INT ------------    INT ------------
             G |- true : bool        G |- 1 : int        G |- 2 : int
  IF ------------------------------------------------------------------
     G |- if true then 1 else 2 : int  


   BOOL_FALSE -----------------    INT ------------    INT ------------
              G |- false : bool        G |- 1 : int        G |- 2 : int
  IF --------------------------------------------------------------------
     G |- if false then 1 else 2 : int

**Aufgabe:** Guck dir den Beweis an und versuche ihn nachzuvollziehen. Bedenke dabei,
dass über dem Strich immer die Voraussetzung steht und unter dem Strich was mit der
(links davon) angeführten Regel demnach außerdem gilt.



Ein Beispiel mit einem Bedingten Ausdruck, dessen Typ ``string`` ist:

::

   # if true then "hello" else "world";;
   - : string = "hello"
   # if false then "hello" else "world";;
   - : string = "world"
   #

**Aufgabe:** Zeichne die Beweisbäume zu diesen beiden Ausdrücken.

(Tipp: Orientiere dich gerne am obigen Beispiel mit ``int``.)



Verschachtelte Ausdrücke
========================

Sehen wir uns das an, was wir bisher von der OCaml Grammatik gelernt haben, dann
bemerken wir, dass bedingte Ausdrücke selber wieder Ausdrücke enthalten.

::

   <expression> = if <expression> then <expression> else <expression> | ...

Das bedeutet in der praxis, dass wir diese Ausdrücke auch verschachteln können. Zum
Beispiel:

:: 

  # if (if true then true else false) then 2 else 3;;
  - : int = 2
  # if (if false then true else false) then 'a' else 'b';;
  - : char = 'b'
  # if true then (if false then "false" else "true") else "nö";;
  - : string = "true"
  #

Wenn ein bedingter Ausdruck einen anderen bedingten Ausdruck als Test hat, dann muss
der Ausdruck, der als Test dient, den Typen ``bool`` haben, egal welchen Typen der
äußere Ausdruck hat.


Übung 14
========

Spiele mit

* einem bedingten Ausdruck, der einen anderen bedingten Ausdruck als Alternative
  hat.

* einem bedingten Ausdruck, der drei weitere bedingte Ausdrücke enthält: einen als
  Test, einen als Konsequenten und einen als Alternative.

In jedem diser Fälle denke vorher darüber nach, was du als Ergebnis erwartetst und
überprüfe deine Hypothese dann mit OCaml.

Außerdem zeichne den Beweisbaum für jeden deiner Ausdrücke.


Typenfehler
===========

Im vorigen Kapitel haben wir uns damit beschäftigt, dass ein Ausdruck syntaktisch
(also lexikalisch und grammatikalisch) korrekt sein muss, damit er korrekt ist.

In diesem Kapitel setzen wir den Fokus daruaf, dass ein Ausdruck typenkorrekt sein
muss um korrekt zu sein.

Damit ein bedingter Ausdruck syntaktisch korrekt ist, müssen seine drei Teilausdrücke
(der Test, der Konsequent und die Alternative) syntaktisch korrekt sein. Damit ein
bedingter Ausdruck typenkorrekt ist, muss sein Test den Typen ``bool`` haben und
der Konsequent und die Alternative müssen vom gleichen beliebigen Typen sein.


Übung 15
========

Probiere aus, was passiert wenn du einen bewusst nicht typenkorrekten
bedingten Ausdruck an OCaml verfütterst.

Was, wenn du gleich mehrere Typenfehler einbaust?


Typenfehler, fortgesetzt
========================

Leider sind Fehlermeldungen nicht immer so hilfreich. Oftmals sind sie sogar eher
verwirrend:

::

   # if A then why not B else your guess is as good as mine;;
   Error: Syntax error
   #

Mit dieser Fehlermeldung können wir gar nichts anfangen. Das ist der Grund dafür,
dass wir Gummienten brauchen. (Mehr zu Gummienten in einer späteren Woche.) 





Version of "the-ocaml-language"
===============================
Erstellt [2023-01-21]

Fertiggestellt [2024-01-22]
