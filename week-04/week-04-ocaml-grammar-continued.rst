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
    mit einem Test, einem Konsequenten und einer Alternative). 
