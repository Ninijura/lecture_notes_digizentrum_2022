===================================================
Namen und Funktionen (der Rest der OCaml-Grammatik)
===================================================

In diesem Teil des Lehrmaterials lernen wir endlich das, was unsere Programme
interessant macht.



Namen und Typenumgebungen
=========================

OCaml gibt uns die Möglichkeit, Namen festzulegen. Diese Namen werden oftmals auch
als "Identifikatoren" oder "Variablen" bezeichnet und ihre Typen werden in der
Typenumgebung gespeichert:

::

   <type_environment> ::= . | ( <name> : <type>), <type_environment>

   <type>             ::= int | bool | char | string | <type> * ... * <type> | unit 

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

Natürlich sind Namen nicht sehr hilfreich, wenn man keine neuen definieren kann. In
OCaml haben wir die Möglichkeit, namen im Toplevel zu deklarieren und das Ergebnis
des Evaluierens eines Ausdruckes sowie den dazugehörigen Typen zu diesem Namen zu
binden:

::

   <toplevel-expression> ::= <expression>
                           | let <formal> = <definiens>

   <formal>              ::= <name>
   
   <definiens>           ::= <expression>


Das Binden einer Variablen erweitert OCamls Typenumgebung und Werteumgebung; nach dem
Binden können wir in folgenden Interaktionen mit der Toplevel-Loop auf die Variable
zugreifen. Wenn wir das tun, schlägt OCaml in seinen Umgebungen nach um den Typen und
den Wert zu finden. 

Nehmen wir einen frisch gestarteten OCaml-Prozess.

* zuerst bedeutet ``x`` gar nichts:

  ::

     # x;;
     Error: Unbound value x
     #

  daher findet OCaml auch nichts, wenn es in seiner ursprünglichen Typenumgebung
  (nennen wir sie ``Gt``) und Werteumgebung (``Gw``) nachschaut und druckt einen
  Fehler;

* also binden wir ``x``:

  ::

     # let x = 42;;
     val x : int = 42
     #

  Wer aufgepasst hat, kann sich die neuen Umgebungen herleiten. Die Typenumgebung ist
  nun ``(x : int), Gt`` und die Werteumgebung ist ``(x : 42), Gw``.

  
* Jetzt können wir ``x`` benutzen um den unter diesem Namen gespeicherten Wert zurück
  zu bekommen:

  ::

     # x;;
     - : int = 42
     #

  
Übung 26
========

Führe die obige Interaktion in OCaml durch.

Danach gib die folgenden Schritte in OCaml ein:

* ``let x = 100;;``

* ``let x = "abracadabra";;``

* ``let say = if 1 then "what" else "?"``

Schriebe für jeden Schritt auf, wie sich die Typenumgebung und die Werteumgebung
danach verändern.

Der letzte Schritt ruft einen Fehler hervor; finde heraus, ob die Variable ``say``
trotzdem definiert wurde. Warum glaubst du, ist das der Fall?


Mehrere globale Variablen auf einmal deklarieren
================================================

Wir haben in OCaml auch die Möglichkeit mehrere (verschiedene) Variablen in einer
einzigen Eingabe zu binden. Die Grammatik dafür ist folgende:

::

   <toplevel-expression> ::= <expression>
                        | let <formal> = <definiens> {and <formal> = <definiens>}*

wo ``{}*`` bedeutet: wiederhole das in den Klammern gedruckte eine beliebige Anzahl
Male (null Mal ist auch zulässig).

Zum Beispiel:

::

   # let x = 10 and y = 100;;
   val x : int = 10
   val y : int = 100
   #

Das macht es uns leicht, die Werte von ``x`` und ``y`` zu tauschen:

::

   # let x = y and y = x;;
   val x : int = 100
   val y : int = 10
   #

(Gedankenfutter: Wie würden wir die Werte umtauschen, wenn wir nicht mehrere
Variablen zugleich binden könnten? Probiere deine Theorie gerne in OCaml aus.)

Wenn wir aber versuchen in einer Interaktion die gleiche Variable zweimal zu
deklarieren, wirft uns OCaml einen Fehler an den Kopf:

::

   # let same = true and same = false;;
   Error: Variable same is bound several times in this matching
   #

Das ergibt auch Sinn. Die eine Bindung würde die andere schließlich überschatten und
da wir nicht auf halber Strecke durch diesen Befehl den ersten Wert benutzen können,
zwingt uns OCaml uns für einen Wert zu entscheiden.

(Gedankenfutter: Mit dieser Einschränkung, dass eine Variable nicht im selben Befehl
mehrmals gebunden werden kann, ist es wichtig in welcher Reihenfolge die Umgebungen
erweitert werden?)

Zwischenspiel über die Wichtigkeit der Reihenfolge (Lösung zum Gedankenfutter)
==============================================================================

**Sigrid:** Klar ist die Reihenfolge wichtig, sonst werden mit Pech irgendwelche
Variablen überschattet.

**Brynja:** Aber wir wissen ja, dass alle Variablen, die wir in einer solchen
Interaktion binden unterschiedlich sind, sie können sich also gar nicht gegenseitig
überschatten.

**Alfrothul:** Das heißt wir könnten mehrere verschiedene Umgebungen haben, die
trotzdem immer die gleichen Resultate haben?

**Brynja:** Ja, genau. Das heißt in diesem Fall ist die Reihenfolge egal.

**Sigrid:** Klingt ganz so wie die Äquivalenz von Funktionen, über die wir neulich
gesprochen haben. Da ist auch die Reihenfolge egal, solange das Ergebnis das gleiche
ist.

**Mimer:** Gut bemerkt!


Funktionen
==========

Natürlich hat OCaml auch Funktionen. Ohne funktionen könnten wir nicht viel programmieren:

::

   <type_environment> ::= . | ( <name> : <type>), <type_environment>

   <type>             ::= int | bool | char | string | <type> * ... * <type> | unit | <type> -> <type>

   <expression>       ::= <integer>
                        | <boolean>
                        | <character>
                        | <string>
                        | if <expression> then <expression> else <expression>
                        | (<expression>, ..., <expression>)
                        | <name>
                        | fun <name> -> <expression>
                        | <expression> <expression>

   <integer>          ::= 0 | -1 | 1 | -2 | 2 | -3 | 3 | ...

   <boolean>          ::= true | false

   <character>        ::= 'a' | 'b' | 'c'| ...

   <string>           ::= "" | "A" | "hello world" | "42" | ...

   <name>             ::= eine Folge von Zeichen, angefangen mit einem Kleinbuchstaben

  
Die entsprechenden Typenregeln sind die folgenden, wo ``G`` für
``<type-environment>`` steht, ``x1`` für ``<name>``, ``e0``, ``e1`` und ``e2`` für
``<expression>``, und ``t1`` und ``t2`` für ``<type>``:

::

       (x1 : t1), G |- e2 : t2
   FUN ----------------------------
       G |- fun x1 -> e2 : t1 -> t2
       
	   G |- e0 : t1 -> t2	G |- e1 : t1
   APP ---------------------------------
       G |- e0 e1 : t2

In Worten:

* in einer beliebigen Typenumgebung ``G`` hat der Ausdruck ``fun x1 -> e2`` den Typen
  ``t1 -> t2`` unter der Voraussetzung, dass ``e2`` den Typen ``t2`` hat in einer
  Umgebung wo ``x1`` den Tyepn ``t1`` hat; und

* in einer beliebigen Typenumgebung ``G`` in welcher der Ausdruck ``e0`` den Typen
  ``t1 -> t2`` und der Ausdruck ``e1`` den Typen ``t1`` hat, hat der Ausdruck ``e0
  e1`` den Typen ``t2``.


Außerdem:

* wenn wir ``fun x1 -> e2`` evaluieren ist das Ergebnis eine Funktion; und

* wenn wir ``e0 e1`` evaluieren, dann evaluieren wir zuerst ``e0`` und ``e1``:

  * wenn das Evaluieren eines der beiden Ausdrücke divergiert (unendlich läuft), dann
    divergiert auch das Evaluieren von ``e0 e1``;

  * wenn das Evaluieren eines der beiden Ausdrücke einen Fehler hervorruft, ruft das
    Evaluieren von ``e0 e1`` denselben Fehler hervor; und

  * wenn das Evaluieren von ``e0`` und ``e1`` die Werte w0 und w1 ergibt, dann wissen
    wir dank OCamls Typensystem, dass w0 eine Funktion ist; ``e0 e1`` zu evaluieren
    bedeutet dann die Funktion w0 auf den Wert w1 anzuwenden.

Genau wie bedingte Ausdrücke und Tupel sind Funktionen und Funktionsanwendung
polymorph (können also unterschiedliche Typen als Resultat haben).


Vokabular zu Funktionen
=======================

* Der Ausdruck ``fun x -> e`` wir oftmals als *Lambda-Abstraktion* bezeichnet, und
  demnach lesen wir das Keyword ``fun`` oftmals einfach als "Lambda".

  * ``e`` bezeichnen wir als den *Funktionskörper* und beschreibt was die Funktion
    macht, wenn sie auf ein Input angewandt wird.

  * ``x`` nennen wir den *Formalparameter* für die Funktion und ist der Name unter dem das
    Input der Funktion dem Funktionskörper zugänglich ist.

* Den Ausdruck ``e0 e1`` nennen wir *Funktionsanwendung*.

  * ``e0`` ist die Funktion, die wir anwenden.

  * ``e1`` nennen wir den *tatsächlichen Parameter* oder das *Input* für die
    Funktion.


Wie Funktionen funktionieren
============================

Wenn eine Lambdaabstraktion wie zum Beispiel die Identitätsfunktion ``fun x -> x``
auf einen tatsächlichen Parameter angewandt wird, zum Beispiel ``42``, dann
evaluieren wir den Funktionskörper, also ``x``, in einer Werteumgebung, in der ``x``
für ``42`` steht:

::

   # (fun x -> x) 42;;
   - : int = 42

Dass der Ausdruck ``(fun x -> x) 42`` den Typen ``int`` hat zeigt der folgende
Beweisbaum, wo ``Gv`` für eine Werteumgebung steht:

::

   LOOKUP_FOUND ------------------------
             (x : int), Gv |- x : int
         FUN -----------------------------    INT --------------
             Gv |- fun x -> x : int -> int        Gv |- 42 : int
         APP ---------------------------------------------------
             Gv |- (fun x -> x) 42 : int

(Hinweis: Die Klammern hier sind wichtig um OCaml zu zeigen, dass der Funktionskörper
nur ``x`` ist und nicht ``x 42``. Probiere aus, was passiert wenn du den Ausdruck
ohne Klammern eingibst. Die Erklärung dazu ist, dass OCaml nun erwartet, dass das
Input ``x`` einen Funktionstypen hat und der Funktionskörper dieser Lambdaabstraktion
das Input auf ``42`` anwendet.)

Ein anderes Beispiel ist die Lambdaabstraktion ``fun b -> if b then "joa" else
"nö"``. Diese Lambdaabstraktion hat den Typen ``bool -> string``, denn ihr Input wird
als Test in einem bedingten Ausdruck verwendet, dessen Resultat ein String ist. Wenn
wir die Abstraktion auf ``true`` anwenden, dann evaluieren wir den Funktionskörper
(also ``if b then "joa" else "nö") in einer Umgebung wo ``b`` für ``true`` steht; wenn
wir die Abstraktion auf ``false`` anwenden, dann evaluieren wir den Funktionskörper
(also ``if b then "joa" else "nö") in einer Umgebung wo ``b`` für ``false`` steht:

::

   # fun b -> if b then "joa" else "nö";;
   - : bool -> string = <fun>
   # (fun b -> if b then "joa" else "nö") true;;
   - : string = "joa"
   # (fun b -> if b then "joa" else "nö") false;;
   - : string = "nö"
   #

Im Folgenden ein paar Beweisbäume darüber, wie diese Werte zustande kommen:

* Dass ``fun b -> if b then "joa" else "nö"`` den Typen ``bool -> string`` hat
  beweisen wir so:

  ::

     LOOKUP_FOUND --------------------------    STRING ----------------------------------    STRING ----------------------------------
                   (b : bool), Gv |- b : bool           (b : bool), Gv |- "joa" : string           (b : bool), Gv |- "nö" : string
          IF ---------------------------------------------------------------------------------------------------------------------
             (b : bool), Gv |- if b then "joa" else "nö" : string
         FUN --------------------------------------------------------------
             Gv |- fun b -> if b then "joa" else "nö" : bool -> string

* Dass ``(fun b -> if b then "joa" else "nö") true`` den Typen ``string`` hat
  beweisen wir so:

  ::

          ...siehe oben...
     FUN --------------------------------------------------------------    BOOL_TRUE -----------------
         Gv |- fun b -> if b then "joa" else "nö" : bool -> string              Gv |- true : bool
     APP ---------------------------------------------------------------------------------------------
         Gv |- (fun b -> if b then "joa" else "nö") true : string

* Dass ``(fun b -> if b then "joa" else "nö") false`` den Tyepn ``string`` hat
  beweisen wir so:

  ::

          ...siehe oben...
     FUN --------------------------------------------------------------    BOOL_FALSE -----------------
         Gv |- fun b -> if b then "joa" else "nö" : bool -> string              Gv |- false : bool
     APP ---------------------------------------------------------------------------------------------
         Gv |- (fun b -> if b then "joa" else "nö") false : string


Vordefinierte Funktionen
========================

Genauso wie OCaml vordefinierte Werte von anderen Typen hat (z.B. ``max_int``), gibt
es auch vordefinierte Werte mit Funktionstypen. Hier sind ein paar Beispiele.

* ``not`` hat den Typen ``bool -> bool`` und gibt das Gegenteil seines Inputs als
  Output:

  ::

     # not;;
     - : bool -> bool = <fun>
     # not true;;
     - : bool = false
     # not false;;
     - : bool = true
     # not (not true);;
     - : bool = true
     # not (not false);;
     - : bool = false
     #

Viele vordefinierte Funktionen in OCaml sind in sogenannten Bibliotheken (libraries)
definiert. Wenn wir zum Beispiel eine Funktion aus der Bibliothek für Strings
benutzen möchten, erzählen wir OCaml erst, dass wir diese Bibliothek benutzen wollen
indem wir ``String`` schreiben, dann dass wir aus dieser Bibliothek zum Beispiel die
Funktion ``length`` bentuzen wollen indem wir es mit einem ``.`` dazwischen anhängen:

* ``String.length`` hat den Typen ``string -> int`` ist in der Bibliothek für
  Strings deklariert. Wenn wir ``String.length`` einen String als Input geben, ist
  das Ergebnis der Funktionsanwendung ein Integer, der angibt wie viele Zeichen
  dieser String hat:

  ::

     # String.length;;
     - : string -> int = <fun>
     # String.length "";;
     - : int = 0
     # String.length "a";;
     - : int = 1
     # String.length "ab";;
     - : int = 2
     # String.length "abc";;
     - : int = 3
     #


Kurzes Zwischenspiel über die Länge eines Backslash
===================================================

**Alfrothul:** Ich muss mal was überprüfen:

::

   # String.length "\"";;
   - : int = 1
   #

**Alfrothul:** Yup! Ein Zeichen, genau wie es sein soll. Der Backslash ist nur eine
Notation.

**Brynja:** Ich muss auch was ausprobieren:

::

   # String.length "\\\\\\";;
   - : int = 3
   #

**Brynja:** Stimmt. Drei Zeichen. Prima!


Funktionen, deren Resultate Funktionen sind
===========================================

Im Prinzip hält uns nichts davon ab, Funktionen zu schreiben, deren Resultate
ebenfalls Funktionen sind. Wir können dann so einer Funktion ein erstes Argument
geben und dem Resultat ein zweites:


::

   # fun x -> (fun y -> x);;
   - : 'a -> 'b -> 'a = <fun>
   # (fun x -> (fun y -> x)) 42;;
   - : '_weak1 -> int = <fun>
   # ((fun x -> (fun y -> x)) 42) "gib mir meine 42 zurück!";;
   - : int = 42
   #
   
(Kommentar: der Typ ``'_weak1`` ist einfach ein Platzhalter für einen beliebigen
Typen, ebenso wie die Typen ``'a`` und ``'b`` Platzhalter für beliebige Typen
sind. Warum OCaml im zweiten Ausdruck jedoch ``'weak_1`` schreibt geht über den
Umfang dieses Kurses hinaus.)

Einige von den Klammern sind unnötig. Funktionsanwendung ist links-assoziativ und
Lambdaabstraktionen sind rechts-assoziativ. Daher können das ganze auch so schreiben:

::

   # fun x -> fun y -> x;;
   - : 'a -> 'b -> 'a = <fun>
   # (fun x -> fun y -> x) 42;;
   - : '_weak2 -> int = <fun>
   # (fun x -> fun y -> x) 42 "gib mir meine 42 zurück!";;
   - : int = 42
   #

Wenn wir diese Lambdaabstraktion ``fun x -> fun y -> x`` beschreiben sollten, wäre
das wie folgt:

* das Ergebnis der Funktionsanwendung von ``fun x -> fun y -> x`` mit einem Wert
  ``e`` als tatsächlichen Parameter ist eine Funktion, die für ein beliebiges Input
  ``e2`` als Ergebnis ``e`` hat.

Oder, wenn wir das Ergebnis als Lambdaabstraktion darstellen sollten:

* Für einen beliebigen Ausdruck ``e`` ist das Ergebnis der Funktionsanwendung von
  ``(fun x -> fun y -> x) e`` die Lambdaabstraktion ``fun y -> e``.

Was bei der Funktionsanwendung also faktisch passiert ist, dass alle Stellen, an
denen im Funktionskörper der formelle Parameter ``x`` verwendet wird nun der
tatsächliche Parameter ``e`` eingesetzt wird.

Ein anderes Beispiel wäre eine Funktion, die für ein beliebiges Input immer die
Idenitätsfunktion (also eine Funktion, die immer ihr Input unverändert als Output
gibt) zurück gibt:

::

   # fun x -> fun y -> y;;
   - : 'a -> 'b -> 'b = <fun>
   # (fun x -> fun y -> y) 1 2;;
   - : int = 2
   # (fun x -> fun y -> y) "druck mich!" "nö";;
   - : string = "nö"
   #


Beweisbäume für Interessierte
=============================

Für wen das mit den Funktionen noch nicht einleuchtend ist, sind hier ein paar
Beweisbäume:

::

           LOOKUP_FOUND ------------------------
                        (x : int), Gv |- x : int
   LOOKUP_NOT_FOUND_YET -----------------------------------
                        (y : int), (x : int), Gv |- x : int
                 FUN ----------------------------------------
                     (x : int), Gv |- fun y -> x : int -> int
                 FUN -----------------------------------------------    INT -------------
                     Gv |- fun x -> fun y -> x : int -> (int -> int)        Gv |- 1 : int
                 APP --------------------------------------------------------------------    INT -------------
                     Gv |- (fun x -> fun y -> x) 1 : int -> int                                  Gv |- 2 : int
                 APP -----------------------------------------------------------------------------------------
                     Gv |- ((fun x -> fun y -> x) 1) 2 : int

Und für die Funktion, die die Identitätsfunktion als Output gibt:

::

   LOOKUP_FOUND -----------------------------------
               (y : int), (x : int), Gv |- y : int
         FUN ----------------------------------------
             (x : int), Gv |- fun y -> y : int -> int
         FUN -----------------------------------------------    INT -------------
             Gv |- fun x -> fun y -> y : int -> (int -> int)        Gv |- 1 : int
         APP --------------------------------------------------------------------    INT -------------
             Gv |- (fun x -> fun y -> y) 1 : int -> int                                  Gv |- 2 : int
         APP -----------------------------------------------------------------------------------------
             Gv |- ((fun x -> fun y -> y) 1) 2 : int

   

Syntaktischer Zucker für Funktionen, die Funktionen zurück geben
================================================================

Im Alltag wäre es echt nervig, wenn wir für solche Lambdaabstraktionen immer
``fun -> fun y -> ...`` schreiben müssten. Daher gibt es eine Kurzform:

::

   # (fun x -> fun y -> x) 1 10;;
   - : int = 1
   # (fun x y -> x) 1 10;;
   - : int = 1
   # (fun x -> fun y -> y) 1 10;;
   - : int = 10
   # (fun x y -> y) 1 10;;
   - : int = 10
   #

Solche Abkürzungen, die praktische Erweiterungen zur Syntax sind, nennen wir syntaktischen
Zucker; danke für diesen Ausdruck, `Peter Landin <https://de.wikipedia.org/wiki/Peter_J._Landin>`_.


Vordefinierte Funktionen, deren Outputs Funktionen sind: Integer Addition
=========================================================================

In OCaml ist die normale Art Addition zu schreiben der Infix-Operator ``+``:

::

   # 2 + 40;;
   - : int = 42
   #

Dieses ``+`` ist aber in wirklichkeit nichts anderes als Syntaktischer Zucker für die
Funktion ``add`` in der Bibliothek ``Int``:

::

   # Int.add 2 40;;
   - : int = 42
   #

Wenn wir ``Int.add`` auf diese Art schreiben wollen, wie die Funktionen die wir
bisher gesehen haben, dann gibt es auch dafür syntaktischen Zucker:

::

   # (+) 1 10;;
   - : int = 11
   #

Der Typ von ``Int.add`` ist ein Funktionstyp, der wiederup einen Funktionstypen auf
der rechten Seite des Pfeils hat:

::
   
  # (+);;
  - : int -> int -> int = <fun>
  #

Wir können nun also auch damit herumspielen, dieser Funktion nur ein Input zu
geben. Wenn wir zum Beispiel ``(+) 1`` nehmen, bekommen wir als Resultat eine neue
Funktion, die einen Integer als Input nimmt (z.B. 10) und als Output diesen Integer
plus 1 gibt (z.B. 11):

::

   # (+) 1;;
   - : int -> int = <fun>
   # ((+) 1) 10;;
   - : int = 11
   #


Funktionen als Variablen
========================

Wir können nun auch die Konstrukte, die wir diese Woche gelernt haben zusammensetzen:
Wir können Funktionen als globale Variablen speichern. Nehmen wir das Beispiel von
der Funktion, die immer 1 zu ihrem Input hinzufügt:

::

   # let nachfolger = (+) 1;;
   val nachfolger : int -> int = <fun>
   # nachfolger;;
   - : int -> int = <fun>
   #

Wenn wir also diese Funktion nun anwenden wollen, können wir sie über ihren neu
definierten Namen aufrufen:

::

   # nachfolger 10;;
   - : int = 11
   # nachfolger 41;;
   - : int = 42
   #

Übung 27
========

Die Funktion ``Int.sub``, oder ``(-)`` ist die Subtraktionsfunktion für Integer in
OCaml.

* Definiere eine Vorgänger-Funktion, die von ihrem Input immer 1 abzieht.

* Definiere eine Funktion ``minus_10``, die von ihrem Input 10 abzieht.


Noch mehr vordefinierte Funktionen, die Funktionen als Output geben
===================================================================

* Multiplikation (``Int.mul``):

  ::

     # 2 * 3;;
     - : int = 6
     #

* Quotient (Division ohne Komma oder Rest):

  ::

     # (/);;
     - : int -> int -> int = <fun>
     # 16 / 2;;
     - : int = 8
     # 3 / 2;;
     - : int = 1
     # 1 / 0;;
     Exception: Division_by_zero.
     #

* Modulo (der Rest bei einer Integer-Division): 

  ::

     # (mod);;
     - : int -> int -> int = <fun>
     # Int.rem 10 3;;
     - : int = 1
     # 12 mod 5;;
     - : int = 2
     #

* Vergleich von zwei Werten: 

  ::

     # (<);;
     - : 'a -> 'a -> bool = <fun>
     # 'a'<'b';;
     - : bool = true
     # 1 < 0;;
     - : bool = false
     # (>);;
     - : 'a -> 'a -> bool = <fun>
     # 3 > 1;;
     - : bool = true
     # 4 > 29;;
     - : bool = false
     #


* Boolsche Konjunktion (und):

  ::
     
     # (&&);;
     - : bool -> bool -> bool = <fun>
     # false && true;;
     - : bool = false
     # true && true;;
     - : bool = true
     # true && false;;
     - : bool = false
     # false && false;;
     - : bool = false
     #

* Boolsche Disjunktion (oder):

  ::

     # (||);;
     - : bool -> bool -> bool = <fun>
     # true || true;;
     - : bool = true
     # true || false;;
     - : bool = true
     #

* String-Konkatenation (Zusammensetzung):

  ::
     
     # (^);;
     - : string -> string -> string = <fun>
     # "hello" ^ " world";;
     - : string = "hello world"
     #

* Minimum von zwei Werten:

  ::

     # min;;
     - : 'a -> 'a -> 'a = <fun>
     # min 2 4;;
     - : int = 2
     # min 9 230;;
     - : int = 9
     #

* Maximum von zwei Werten:

  ::

     # max;;
     - : 'a -> 'a -> 'a = <fun>
     # max 3 5;;
     - : int = 5
     # max 42 11;;
     - : int = 42
     #

* Eine Funktion, die ein bestimmtes Zeichen aus einem String isoliert:

  ::

     # String.get;;
     - : string -> int -> char = <fun>
     # String.get "hello world" 4;;
     - : char = 'o'
     # String.get "0123456" 6;;
     - : char = '6'
     # String.get "1234567" 5;;
     - : char = '6'
     #

  Achtung bei dieser Funktion. Bei den meisten Programmiersprachen fangen wir das
  Zählen bei Null an; so auch in OCaml. 
     
     


Übung 28
========

Probiere die Funktionen aus dem vorigen Abschnitt an unterschiedlichen Inputs aus bis
du sie verstanden hast.

Definiere auch gerne neue Funktionen, indem du den Funktionen aus dem vorigen
Abschnitt nur ein Input gibst. Mach dir vorher klar, was du von der neuen Funktion
erwartest und probiere sie an unterschiedlichen Inputs aus um sicher zu gehen, dass
du richtig gelegen hast. 


   
  
   


   
Version of "variablen-und-funktionen"
=====================================
Erstellt [2023-01-29]

