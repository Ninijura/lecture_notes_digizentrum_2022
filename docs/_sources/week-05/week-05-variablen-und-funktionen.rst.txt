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
                        | <name>

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

Überzeuge dich von den obigen Beispielen indem du die jeweiligen Beweisbäume
aufzeichnest.


Teilweise Lösung für Übung 25
=============================

a. Nehmen wir den Namen ``x`` und versuchen wir, diesen Namen in der leeren
   Typenumgebung ``.`` nachzuschlagen. Die Wurzel des Baumes ist folglich:

   ::

      . |- x : ehm

   für einen bisher noch unbekannten Typen ``ehm``.

   Wir könenn weder die Regel ``LOOKUP_FOUND`` noch die Regel
   ``LOOKUP_NOT_FOUND_YET`` anwenden. Also können wir keinen Beweisbaum konstruieren
   und somit auch keinen Typen für ``x`` finden. Der Typ von ``x`` ist also
   undefiniert.

b. Versuchen wir ``i`` in der Typenumgebung ``(i : int), (b : bool), (c : char), .``
   nachzuschlagen. Die Wurzel des Baumes lautet:

   ::

      (i : int), (b : bool), (c : char), . |- i : ehm

   für einen bisher unbekannten Typen ``ehm``.

   Wir können (nur) die Regel ``LOOKUP_FOUND`` verwenden, wo ``x`` mit ``i`` ersetzt
   wird, ``t`` mit ``int``, und ``G`` mit ``(b : bool), (c : char), .``. Auf der
   rechten Seite des ``|-`` ersetzen wir wieder ``x`` mit ``i`` und ``t`` mit
   ``ehm``:

   ::

      LOOKUP_FOUND -------------------------------------------------
                    (i : int), (b : bool), (c : char), . |- i : ehm


   Da in diesem Beweisbaum ``t`` einmal mit ``int`` und einmal mit ``ehm`` ersetzt
   ist, haben wir nun herausgefunden, dass der bisher unbekannte Typ ``ehm`` in
   Wirklichkeit ``int`` sein muss. Der fertige Beweisbaum lautet also:

   ::

     LOOKUP_FOUND -------------------------------------------------
                    (i : int), (b : bool), (c : char), . |- i : int

   Die Existenz dieses Baumes Beweist, dass in der Typenumgebung ``(i : int), (b :
   bool), (c : char), .`` das Nachschlagen des Namens ``i`` den Typen ``int``
   ergibt. 

      
c. Versuchen wir ``b`` in der Typenumgebung ``(i : int), (b : bool), (c : char), .``
   nachzuschlagen. Die Wurzel des Baumes lautet:

   ::

      (i : int), (b : bool), (c : char), . |- b : ehm

   für einen bisher unbekannten Typen ``ehm``.

   Wir können hier (nur) die Regel ``LOOKUP_NOT_FOUND_YET`` anwenden, wo ``x'`` mit
   ``i`` ersetzt wird, ``t'`` mit ``int``, ``G`` mit ``(b : bool), (c : char), .``,
   ``x`` mit ``b`` und ``t`` mit ``ehm``:


   ::
      
                            (b : bool), (c : char), . |- b : ehm
       LOOKUP_NOT_FOUND_YET -----------------------------------------------
                            (i : int), (b : bool), (c : char), . |- b : ehm


   Nun können wir (nur) die Regel ``LOOKUP_FOUND`` anwenden, wo ``x`` mit ``b``
   ersetzt wird, ``t`` mit ``bool``, ``G`` mit ``(c : char), .``, ``x`` mit ``b`` und
   ``t`` mit ``ehm``.

   ::

              LOOKUP_FOUND ------------------------------------
                           (b : bool), (c : char), . |- b : ehm
      LOOKUP_NOT_FOUND_YET -----------------------------------------------
                           (i : int), (b : bool), (c : char), . |- b : ehm

   Da wir in der Anwendung von ``LOOKUP_FOUND`` ``t`` im einen Fall mit ``bool`` und
   im anderen Fall mit ``ehm`` ersetzt haben, wissen wir nun, dass der bisher
   unbekannte Typ ``ehm`` ``bool`` sein muss. 

   ::

              LOOKUP_FOUND ------------------------------------
                           (b : bool), (c : char), . |- b : bool
      LOOKUP_NOT_FOUND_YET -----------------------------------------------
                           (i : int), (b : bool), (c : char), . |- b : bool

   Die Existenz dieses Baumes Beweist, dass in der Typenumgebung ``(i : int), (b :
   bool), (c : char), .`` das Nachschlagen des Namens ``b`` den Typen ``bool``
   ergibt.

d.-f. Konstruiere diese Bäume selbst. 


Zwischenspiel über Umgebungen und Zwiebeln
==========================================

**Alfrothul:** Erklär mir bitte nochmal, warum jetzt eine Umgebung aufgebaut ist wie
eine Zwiebel...?

**Brynja:** Eigentlich ganz logisch. Eine Zwiebel können wir auch beschreiben wie
eine Umgebung:

::

   <zwiebel>  ::= ^ | (<zwiebel>)

   <umgebung> ::= . |(<name> : <typ>), <umgebung>

Eine leere Umgebung ist wie der Keim, ``^`` in der Mitte einer Zwiebel: es ist nichts weiter
innen drin. Und wenn wir eine Zwiebel haben, können wir eine neue Zwiebel
konstruieren indem wir noch eine Lage drum herum wachsen lassen. Ich habe mir hier
die Freiheit genommen, jede Schicht mit einem Paar Klammern zu zeigen; sieht ja auch
aus wie eine Zwiebel. Also wir haben eine Zwiebel, zum Beispiel ``(((^)))`` und
können dann eine neue machen: ``((((^))))``

Ebenso konstruieren wir eine neue Umgebung indem wir eine bereits vorhandene nehmen
und noch eine Bindung hinzufügen. Also wenn wir die Umgebung ``G`` haben, können wir
eine neue machen, indem wir die Bindung von ``x`` zum Typen ``t`` hinzufügen: ``(x :
t), G``.

**Alfrothul:** Ok...

**Brynja:** Jetzt stell dir vor, dass auf jede Schicht der Zwiebel ein Name gedruckt
ist.

**Alfrothul:** Ok?

**Brynja:** Jetzt gebe ich dir eine Zwiebel und frage dich, ob dein name auf eine der
Schichten gedruckt ist. Was musst du tun um diese Frage zu beantworten?

**Alfrothul:** Ich schätze, ich muss die Schichten von der Zwiebel eine nach der
anderen abpulen und drauf gucken.

**Brynja:** Genau. Und was, wenn du keine Schichten mehr hast, sondern nur den Keim?

**Alfrothul:** Dann weiß ich, dass mein Name auf keiner der Schichten gestanden hat.

**Brynja:** Eben. Wie in der leeren Umgebung.

**Sigrid (von der Seite):** Und was, wenn die Zwiebel unendlich ist?

**Alfrothul:** Unendlich? Das wüsste ich aber, wenn es so eine Zwiebel gibt.

**Brynja:** Das kann sie auch gar nicht sein, sie ist schließlich konstruiert
worden. Beziehungsweise, wenn wir von der Metapher absehen, dann ist sie
gewachsen. Von innen nach außen. Das heißt, irgendwann müssen wir zum Keim kommen.

**Sigrid:** Hm... und das gilt auch für Umgebungen, nehme ich an?

**Brynja:** Ja, genau. Jedes mal wenn wir einen neuen Namen binden, erweitern wir die
Umgebung um eine Schicht. Und weil wir wissen, dass wir kein unendliches Programm
geschrieben haben, wissen wir auch, dass die Umgebung nicht unendlich sein kann.

**Alfrothul:** Ich glaube, jetzt habe ich es kapiert. Aber wie machen wir das denn
überhaupt mit dem binden? Wir haben doch bisher nur gesehen, dass wir Namen schreiben
können, aber nicht wie wir Namen in OCaml binden können.

**Brynja:** Vielleicht können wir das ja gar nicht...? Vielleicht haben wir nur die
schon definierten Namen?

**Sigrid:** Schon definierte Namen?

**Brynja:** Ja. Erinnert ihr euch noch an Woche-01 wo wir über ``min_int`` und
``max_int`` gelernt haben?

**Sigrid und Alfrothul:** Ja...?

**Brynja:** Das müssen doch Namen sein. Die passen jedenfalls zu keinem anderen
Ausdruck, den wir bisher gelernt haben.

**Mimer:** Stimmt genau. Und diese vordefinierten Namen können uns noch etwas anderes
zeigen. Ihr habt ja schon Typenumgebungen gesehen, aber zu jedem Namen gehört ja auch
ein Wert. Es gibt also auch Wertumgebungen. Die funktionieren genau so wie die
Typenumgebungen, nur dass sie für jeden Namen einen Wert speichern statt eines
Typen.

**Brynja:** Das heißt irgendwo in OCaml ist eine Wertumgebung schon definiert, und
auf einer der Schichten steht: 

::

   (min_int : -4611686018427387904), (max_int : 4611686018427387903), G

wenn wir die restliche Werteumgebung ``G`` nennen.

**Mimer:** Gut erkannt. Wir würden in diesem Fall wohl eher ein ``=`` benutzen statt
eines ``:``, aber das Prinzip ist das gleiche.

**Alfrothul:** Also ``=`` für Werte und ``:`` für Typen?

**Mimer:** Genau.

**Sigrid:** Aber was ist denn jetzt mit der Frage von vorhin? Können wir neue Namen
definieren? Und wenn ja, wie?

**Mimer:** Einfach weiterlesen. Das kommt im nächsten Abschnitt.

.. epigraph::

   | Pile on many more layers
   | and I'll be joining you there.

   -- `Pink Floyd <https://en.wikipedia.org/wiki/Shine_On_You_Crazy_Diamond>`_



Globale Variablen deklarieren
=============================







   
Version of "variablen-und-funktionen"
=====================================
Erstellt [2023-01-29]

