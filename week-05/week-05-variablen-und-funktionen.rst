=======================================================
Variablen und Funktionen (der Rest der OCaml-Grammatik)
=======================================================

In diesem Teil des Lehrmaterials lernen wir endlich das, was unsere Programme
interessant macht.



Namen und Typenumgebungen
=========================

OCaml gibt uns die Möglichkeit, Namen festzulegen. Diese Namen werden oftmals auch
als "Identifikatoren" oder "Variablen" bezeichnet und ihre Typen werden in der
Typenumgebung gespeichert:

::

   <type_environment> ::= . | ( <name> : <type>), <type_environment>

   <type>             ::= int | bool | char | string | <type> * ... * <type>

   <expression>       ::= <integer>
                        | <boolean>
                        | <character>
                        | <string>
                        | if <expression> then <expression> else <expression>
                        | (<expression>, ..., <expression>)

   <integer>          ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ...

   <boolean>          ::= true | false

   <character>        ::= 'a' | 'b' | 'c'| ...

   <string>           ::= "" | "A" | "hello world" | "42" | ...

   <name>             ::= eine Folge von Zeichen, angefangen mit einem Kleinbuchstaben


Die Typenumgebung enthält eine Sammlung von Bindungen zwischen Namen und den
entsprechenden Typen. Es ist aufgebaut wie die sprichwörtliche Zwiebel: Innen ist ein
Keim und darum liegt eine Schicht nach der anderen:

* ``.`` repräsentiert eine leere Typenumgebung; und
* nehmen wir einen Namen ``x``, einen Typen ``t`` und eine Typenumgebung ``G``, dann
  repräsentiert ``(x : t), G`` die Erweiterung der Typenumgebung ``G`` um die Bindung
  von ``x`` zum Typen ``t``.

Also zum Beispiel:

* ``.`` ist die leere Typenumgebung, die keine Bindungen zwischen Namen und Typen
  enthält.
* ``(c : char), .`` erweitert die vorige Typenumgebung mit der Bindung des Namens
  ``c`` zum Typen ``char``. In dieser Typenumgebung hat also ``c`` den Typen
  ``char``.
* ``(b : bool), ((c : char), .)`` erweitert die vorige Typenumgebung um die Bindung
  des Namens ``b`` zum Typen ``bool``. Hier hat also der Name ``c`` den Typen
  ``char`` und der Name ``b`` den Typen ``bool``.
* ``(i : int), ((b: bool), ((c : char), .))`` erweitert die vorige Typenumgebung um
  die Bindung des Namens ``i`` zum Typen ``int``. Hier hat also der Name ``i`` den
  Typen ``int``, der Name ``b`` den Typen ``bool`` und der Name ``c`` den Typen
  ``char``.
* ``(b : string), ((i : int), ((b : bool), ((c : char), .)))`` erweitert die vorige
  Typenumgebung um die Bindung des Namens ``b`` zum Typen ``string``. Hier hat der
  Name ``b`` den Typen ``string``, der Name ``i`` den Typen ``int`` und der Name
  ``c`` de Typen ``char``.

Die Frage stellt sich nun, warum in der letzten Typenumgebung der Name ``b`` den
Typen ``string`` hat und nicht den Typen ``bool``. Das liegt daran, dass die
Typeumgebung von außen nach innen gelesen wird und die neueste Bindung diejenige ist,
die zählt. Die Bindung von ``(b : string)`` "überschattet" ("shadows") also die
ältere Bindung von ``(b : bool)``.

Der Infix-Konstruktor ``,`` ist rechts-assoziativ, weshalb wir die Klammern rechts
vom ``,`` auch weg lassen können:

* ``(b : bool), (c : char), .`` ist kurz für ``(b : bool), ((c : char), .)``,
* ``(i : int), (b : bool), (c : char), .`` ist kurz für ``(i : int), ((b : bool), ((c
  : char), .))``, usw.

Das Überschatten wird klarer, wenn wir uns die Typenregeln anschauen, die das
Nachschlagen (lookup) in der Typenumgebung beschreiben.

::
   
   LOOKUP_FOUND -------------------
                (x : t), G |- x : t

                           G |- x : t	
   LOOKUP_NOT_FOUND_YET ----------------------- wo x und x' verschieden sind.
                        (x' : t'), G |- x : t

In Worten:

* für einen beliebigen Namen ``x``, einen beliebigen Typen ``t`` und eine beliebige
  Typenumgebung ``G`` hat ``x`` den Typen ``t`` in der Typenumgebung ``(x : t), G``;
  und
* für eine beliebige Typenumgebung ``G``, einen beliebigen Namen ``x``, einen
  beliebigen Typen ``t``, einen beliebigen Namen ``x'``, der nicht der gleiche ist
  wie ``x`` und einen beliebigen Typen ``t'``: Wenn ``x`` in der Typenumgebung ``G``
  den Typen ``t`` hat, dann hat es denselben Typen ``t``, wenn ``G`` durch die
  Bindung ``x' : t'`` erweitert wird.

In anderen Worten:

* ``x`` hat immer den Typen ``t`` in einer Typenumgebung, die mit ``(x : t)``
  anfängt;
* ``x`` hat den Typen ``t`` in einer Typenumgebung, die mit ``(x' : t')`` anfängt und
  mit ``G`` fortsetzt, wannimmer ``x'`` und ``x`` unterschiedliche Namen sind und
  ``x`` in der Typenumgebung ``G`` den Typen ``t`` hat.

Wir benutzen diese Regeln um Namen in einer Typenumgebung nachzuschlagen. Also zum
Beispiel:

a. einen beliebigen Namen in der leeren Typenumgebung ``.`` nachzuschlagen ist
   undefiniert (und ruft einen Fehler hervor),
b. ``i`` in der Typenumgebung ``(i : int), (b : bool), (c : char), .`` nachzuschlagen
   ergibt ``int``, 
c. ``b`` in der Typenumgebung ``(i : int), (b : bool), (c : char), .`` nachzuschlagen
   ergibt ``bool``,
d. ``c`` in der Typenumgebung ``(i : int), (b : bool), (c : char), .`` nachzuschlagen
   ergibt ``char``,
e. ``x`` in der Typenumgebung ``(i : int), (b : bool), (c : char), .`` nachzuschlagen
   ist undefiniert und ruft einen Fehler hervor,
f. ``x`` in der Typenumgebung ``(x : int), (x : bool), (x : char), .`` nachzuschlagen
   ergibt ``int``.

Im letzten Fall überschattet die letzte Bindung von ``x`` die beiden vorigen
Bindungen.


Übung 25
========

