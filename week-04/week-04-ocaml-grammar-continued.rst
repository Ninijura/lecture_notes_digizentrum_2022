==================================================
Die Grammatik von OCaml (fortgesetzt von Woche 03)
==================================================

Wir rufen uns ins Gedächtnis, was wir in Woche 03 schon von OCamls Grammatik gelernt
haben:

::

   <type>       ::= int | bool | char | string

   <expression> ::= <integer>
                  | <boolean>
                  | <character>
                  | <string>
                  | if <expression> then <expression> else <expression>

   <integer>    ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ...

   <boolean>    ::= true | false

   <character>  ::= 'a' | 'b' | 'c'| ...

   <string>     ::= "" | "A" | "hello world" | "42" | ...


In Worten: Wir kennen 

* die Typen

  * ``int`` für Ganzzahlen,

  * ``bool`` für Booleans (Antworten auf ja/nein-Fragen),

  * ``char`` für Zeichen, und

  * ``string`` für Zeichenfolgen (Wörter, Sätze, etc.);

* die Ausdrücke

  * ``<integer>`` (ein Wert vom Typ ``int``),

  * ``<boolean>`` (ein Wert vom Typ ``bool``),

  * ``<character>`` (ein Wert vom Typ ``char``),

  * ``<string>`` (ein Wert vom Typ ``string``), und

  * ``if <expression> then <expression> else <expression>`` (ein bedingter Ausdruck
    mit einem Test, einer Konsequente  und einer Alternative).



Paare
=====

OCaml hat außerdem auch Paare:

::

   <type>       ::= int | bool | char | string | <type> * <type>

   <expression> ::= <integer>
                  | <boolean>
                  | <character>
                  | <string>
                  | if <expression> then <expression> else <expression>
                  | (<expression>, <expression>)

   <integer>    ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ...

   <boolean>    ::= true | false

   <character>  ::= 'a' | 'b' | 'c'| ...

   <string>     ::= "" | "A" | "hello world" | "42" | ...

Die entpsrechend Typenregel lautet wie folgt:

::

         G |- e1 : t1      G |- e2 : t2
   PAIR----------------------------------
         G |- (e1, e2) : t1 * t2

In Worten:

* In einer beiliebigen Typenumgebung ``G`` hat der Ausdruck ``(e1, e2)`` den Typen
  ``t1 * t2`` wenn in der selben Typenumgebung der Ausdruck ``e1`` den Typen ``t1``
  und der Ausdruck ``e2`` den Typden ``t2`` hat.

Außerdem:

* Wenn ``(e1, e2)`` evaluiert wird, dann evaluieren wir erst ``e1`` und dann ``e2``:

  * wenn das Evaluieren eines der beiden Ausdrücke divergiert (unendlich läuft), dann
    divergiert das Evaluieren von ``(e1, e2)`` ebenfalls.

  * wenn einer der beiden Ausdrück einen Fehler hervorruft, ruft der Ausdrück ``(e1,
    e2)`` den selben Fehler hervor.

  * wenn ``e1`` und ``e2`` zu den Werten w1 und w2 evaluiert werden, dann wird ``(e1,
    e2)`` zu dem Paar evaluiert, das w1 an erster und w2 an zweiter Stelle enthält.

Paare sind polymorph, weil sie unterschiedliche Typen haben können. Wenn die
Komponenten eines Paares die Typen ``t1`` und ``t2`` haben, dann hat das Paar den
Typen ``t1 * t2``, egal was ``t1`` und ``t2`` für Typen sind.

Als Beispiel die folgende Interaktion:

::

   # (1, 2);;
   - : int * int = (1, 2)
   # ("hello", "world");;
   - : string * string = ("hello", "world")
   #

Die entsprechenden Beweisbäume sehen wie folgt aus:

::

       INT ------------    INT ------------
           G |- 1 : int        G |- 2 : int
  PAIR ------------------------------------
       G |- (1, 2) : int * int
  
  
       STRING ---------------------    STRING ---------------------
              G |- "hello" : string           G |- "world" : string
  PAIR ------------------------------------------------------------
       G |- ("hello", "world") : string * string


Zwischenspiel
=============

**Sigrid:** Ich schätze, Paare können auch Elemente mit unterschiedlichen Typen
haben:

::

   # (1, "world");;
   - : int * string = (1, "world")
   # ("hello", 2);;
   - : string * int = ("hello", 2)
   #

**Alfrothul:** Dann können wir auch Paare von Paaren machen:

::

   # ((1, "world"), ("hello", 2));;
   - : (int * string) * (string * int) = ((1, "world"), ("hello", 2))
   #

**Brynja:** Wir können sogar bedingte Paare machen:

::

   # if true then (true, 22) else (false, 33);;
   - : bool * int = (true, 22)
   #

**Alfrothul:** Und wir können beweisen, dass dieser Ausdruck den Typen hat, den OCaml
behauptet, dass er hat.

**Sigrid:** Na dann los.

**Brynja:** Anfangen tun wir mit dem, was wir beweisen wollen. Nämlich dass der
Ausdruck ``if true then (true, 22) else (false, 33)`` den Typen ``bool * int`` hat:

::

   G |- if true then (true, 22) else (false, 33) : bool * int

**Alfrothul:** Der Ausdruck sieht mir sehr nach etwas aus, wo wir die ``IF`` Regel
benutzen können:

::

      G |- true : bool    G |- (true, 22) : bool * int    G |- (false, 33) : bool * int
   IF ---------------------------------------------------------------------------------
      G |- if true then (true, 22) else (false, 33) : bool * int

Und jetzt? Jetzt haben wir auf einmal die Typen von drei Ausdrücken zu beweisen...

**Sigrid:** Fangen wir doch einfach mit dem ersten (und einfachsten) an. Hier gibt es
nur eine Regel, die wir benutzen können, nämlich ``BOOL_TRUE``:

::

   BOOL_TRUE ----------------
          G |- true : bool    G |- (true, 22) : bool * int    G |- (false, 33) : bool * int
       IF ---------------------------------------------------------------------------------
          G |- if true then (true, 22) else (false, 33) : bool * int

Damit ist der erste Zweig abgeschlossen.

**Brynja:** Okay, also dann als nächstes der mittlere Zweig. Hier können wir wieder
nur eine Regel verwenden: ``PAIR``. Wir müssen aber unsere Ausdrücke einsetzen. Also
``G`` wird ersetzt mit ``G``, ``e1`` ist ``true`` und ``e2`` ist ``22``. Für die
Typen haben wir ``bool`` für ``t1`` und ``int`` für ``t2``:

::

                                    G |- true : bool    G |- 22 : int
   BOOL_TRUE ----------------  PAIR----------------------------------
          G |- true : bool          G |- (true, 22) : bool * int           G |- (false, 33) : bool * int
       IF ----------------------------------------------------------------------------------------------
          G |- if true then (true, 22) else (false, 33) : bool * int

**Alfrothul:** Oh Mann! Schon wieder zwei neue Zweige. Also den ersten zuerst. Der
geht wieder einfach mit ``BOOL_TRUE``. Der zweite geht genau so einfach mit
``INT``:

::

                                BOOL_TRUE ----------------    INT -------------
                                          G |- true : bool        G |- 22 : int
  BOOL_TRUE ----------------         PAIR -------------------------------------
            G |- true : bool              G |- (true, 22) : bool * int             G |- (false, 33) : bool * int
         IF ----------------------------------------------------------------------------------------------------
            G |- if true then (true, 22) else (false, 33) : bool * int


**Sigrid:** Super! Jetzt fehlt nur noch der letzte Zweig! Gibt es Freiwillige?



Übung 20
========

Beweise den letzten Zweig des Beweisbaumes.



Übung 21
========

Spiele ein wenig mit Paaren und ihren Typen:

a. Was ist der Typ von Paaren aus Integern und Booleans? Schreibe einen OCaml
   Ausdruck mit diesem Typen. 
b. Was ist der Typ von Paaren aus Integers und Paaren von Integern und Booleans?
   Schreibe einen OCaml Ausdruck mit diesem Typen. 
c. Was ist der Typ von Paaren aus Integern und Paaren aus Integern und Paaren aus
   Integern und Booleans? Schreibe einen OCaml Ausdruck mit diesem Typen.

Zwischenspiel über Satzzeichen
==============================

**Mimer:** In Augenblicken wie diesem wünsche ich mir mehr Satzzeichen.

**`Victor Borge <https://www.youtube.com/watch?v=TIf3IfHCoiE>`_:** Vielleicht sogar
phonetische?


Übung 21, fortgesetzt mit mehr Satzzeichen
===========================================

a. Was ist der Typ von Paaren aus Integern und Booleans? Schreibe einen OCaml
   Ausdruck mit diesem Typen. 
b. Was ist der Typ von Paaren aus Integern und (Paaren von Integern und Booleans)?
   Schreibe einen OCaml Ausdruck mit diesem Typen. 
c. Was ist der Typ von Paaren aus Integern und (Paaren aus Integern und( Paaren aus
   Integern und Booleans))? Schreibe einen OCaml Ausdruck mit diesem Typen.   
d. Was ist der Typ von Paaren aus Booleans und Integern? Schreibe einen OCaml
   Ausdruck mit diesem Typen.
e. Was ist der Typ von Paaren aus (Paaren aus Booleans und Integern) und Integern?
   Schreibe einen OCaml Ausdruck mit diesem Typen. 
f. Was ist der Typ von Paaren aus (Paaren aus (Paaren aus Booleans und Integern) und
   Integern) und Integern? Schreibe einen OCaml Ausdruck mit diesem Typen.
g. Was ist der Typ von Paaren aus (Paaren aus Integern und Booleans) und (Paaren aus
   Booleans und Integern)? Schreibe einen OCaml
   Ausdruck mit diesem Typen. 


Tupel
=====

Paare sind nur ein Sonderfall von der generelleren Version: Tupel.

::

   <type>       ::= int | bool | char | string | <type> * ... * <type>

   <expression> ::= <integer>
                  | <boolean>
                  | <character>
                  | <string>
                  | if <expression> then <expression> else <expression>
                  | (<expression>, ..., <expression>)

   <integer>    ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ...

   <boolean>    ::= true | false

   <character>  ::= 'a' | 'b' | 'c'| ...

   <string>     ::= "" | "A" | "hello world" | "42" | ...

Die entsprechende Typenregel sieht wie folgt aus:

::

          G |- e1 : t1	...	G |- eN : tN
   TUPLE------------------------------------
          G |- (e1, ..., eN) : t1 * ... * tN

In Worten:

* in einer beliebigen Typenumgebung ``G`` hat der Ausdruck ``(e1, ..., eN)`` den
  Typen ``t1 * ... * tN`` wenn in der selben Typenumgebung der erste Ausdruck ``e1``
  den ersten Typen ``t1`` hat, der zweite ausdruck ``e2`` den zweiten Typen ``t2``
  hat, ..., und der Nte Ausdruck ``eN`` den Typen ``tN`` hat.

Außerdem,

* um den Ausdruck ``(e1, ..., eN)`` zu evaluieren werden erst die Ausdrück ``e1``,
  ..., und ``eN`` evaluiert:

  * wenn einer dieser Ausdrücke divergiert, dann divergiert auch das Evaluieren des
    Ausdruckes ``(e1, ..., eN)``.

  * wenn einer dieser Ausdrücke einen Fehler hervorruft, ruft auch das Evaluieren des
    Ausdruckes ``(e1, ..., eN)`` diesen Fehler hervor.

  * wenn die Ausdrücke ``e1``, ..., ``eN`` zu den Werte w1, ..., wN evaluiert werden,
    wird der Ausdruck ``(e1, ..., eN)`` zum Wert des Tupels evaluiert, welches die
    Werte w1, ..., wN enthält.

Genau wie Paare sind auch Tupel polymorph indem ein Tupel das aus N Komponenten von den
Typen ``t1``, ..., ``tN`` besteht den Typen ``t1 * ... * tN`` haben wird, egal welche
Typen ``t1``, ..., ``tN`` sind.

Ein Beispiel ist diese Interaktion mit dem OCaml Prozess:

::

   # (1, 2, 3);;
   - : int * int * int = (1, 2, 3)
   # (1, 2, 3, 4);;
   - : int * int * int * int = (1, 2, 3, 4)
   # (1, 2, 3, 4, 5);;
   - : int * int * int * int * int = (1, 2, 3, 4, 5)
   #


Übung 22
========

a. Welchen Typ haben Trippel aus Integern, Booleans und Zeichen? Schreibe einen
   OCaml-Ausdruck mit diesem Typen.
b. Welchen Typen haben Quadrupel aus Integern, Booleans, Zeichen und Strings?
   Schreibe einen OCaml Ausdruck mit diesem Typen.
c. Schreibe ein Tupel aus Strings für die 12 Monate des Standard-Jahres. Welchen
   Typen hat es?
d. Schreibe ein Tupel aus Strings für die 15 Monate des norddeutschen Jahres (siehe
   Zwischenspiel unter dieser Übung). Welchen Typen hat es?
e. Was ist der Typ von Trippeln aus Integer-Paaren? Schreibe einen OCaml-Ausdruck mit
   diesem Typen.
f. Schreibe einen Typen für ein Tupel auf, das mindestens ein anderes Tupel enthält
   und schreibe einen OCaml-Ausdruck mit diesem Typen.

Zwischenspiel über den Jahreszyklus
===================================

**`Henrik Nodrbrandt <https://de.wikipedia.org/wiki/Henrik_Nordbrandt>`_
(sorgmütig):** Überall sonst in der Welt hat das Jahr 12 Monate.

**Brynja:** ...ja?

**Henrik Nodrbrandt:** Aber in Dänemark (und Norddeutschland) hat das Jahr 15
Monate.

**Brynja:** 15? Wie geht das denn auf?

**Henrik Nodrbrandt:** Naja, siehst
du: 1. November, 2. Dezember, 3. Januar, 4. Februar, 5. März, 6. April, 7. Mai, 8. Juni, 9. Juli, 10. August, 11. September, 12. Oktober;
und dann November, November und November.

**Brynja (tröstend):** Aber wenigstens hat der November nur 30 Tage.


Das leere Tupel (unit)
======================

OCaml hat zwar kein Tupel von Länge 1, aber es gibt eins von Länge 0.
Dieses Tupel hat seinen eigenen Typen: ``unit`` und nur einen möglichen Wert:
``()``.

::

   <type> ::= int | bool | char | string | <type> * ... * <type> | unit

::

   UNIT -----------------
        G |- () : unit

In Worten:

* in einer beliebigen Typenumgebung ``G`` hat der Ausdruck ``()`` immer den Typen
  ``unit``.

Außerdem:

* ``()`` zu evaluieren ergebt den Wert ``()``.

  
Übung 23
========

Welche Typen haben die folgenden Ausdrücke und können sie einfacher geschrieben
werden?

* (())
* ((()))
* ((), ())
* ((()), ())
* ((), (()))
* ((()), (()))
* (((()), (())))


Zwischenspiel - Klammern in OCaml
=================================

**Sigrid:** Also Klammern in OCaml benutzen wir entweder für Tupel...

**Alfrothul:** ...oder um verschachtelte Ausdrücke auseinander zu halten.

**Mimer:** Genau das!

**Brynja:** Und OCaml hat Tupel in allen Längen, bis auf eins von Länge 1.

**Mimer:** Auch das.


Übung 24
========

a. Was ist der Typ von Trippeln aus Unit-Werten? Schreibe einen Ausdruck mit diesem
   Typen in OCaml.
b. Gibt es andere Ausdrücke, die denselben Typen haben?







       

Version of "ocaml-grammar-continued"
====================================

Erstellt [2023-01-22]

