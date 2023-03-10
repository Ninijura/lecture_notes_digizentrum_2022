==========================
 Rekursion: Zwiebeldenken
==========================

Wir haben
`vorletzte Woche <../week-05/week-05-variablen-und-funktionen.html#zwischenspiel-uber-umgebungen-und-zwiebeln>`_
schon Gesehen wie Zwiebeln aufgebaut sind.

Wir haben Zwiebeln beschrieben mit einem Basisfall und einem Induktionsfall:

* **Basisfall:** ein Keim
* **Induktionsfall:** eine Schicht um eine andere Zwiebel herum

Wir sagen dann, dass eine Zwiebel *induktiv* aufgebaut ist: erst kommt ein Keim und
dann wird eine Schicht nach der anderen aufgetragen, bis wir eine dicke fette Zwiebel
haben.

Wenn wir die Zwiebel von außern nach innen auseinanderpulen, dann sagen wir, dass wir
sie *rekursiv* bearbeiten.


Peano-Zahlen
============

Die natürlichen Zahlen können wir auch induktiv beschreiben. 

* **Basisfall:** 0
* **Induktionsfall:** N n

wo n eine beliebige Zahl ist und N die Nachfolger-Funktion.

In Worten:

* Null ist die kleinste natürliche Zahl
* Eine natürliche Zahl plus 1 ist eine neue naturliche Zahl

Mit diesen zwei Regeln können wir alle natürlichen Zahlen beschreiben.

::

   0 = 0
   1 = N 0
   2 = N N 0
   3 = N N N 0
   4 = N N N N 0
   etc.

Diese Art Zahlen zu schreiben nennt sich `Peano
<https://en.wikipedia.org/wiki/Giuseppe_Peano>`_ Zahlen.


Wenn wir zurück zur Zwiebel wollen, können wir uns vorstellen, dass auf dem Keim eine
Null geschrieben ist. Auf jeder weiteren Schicht der Zwiebel steht +1.

Wenn wir nun wissen wollen, welche Zahl die Zwiebel repräsentiert, dann müssen wir
die Schichten eine nach der anderen abziehen. Wenn wir zum Keim kommen gucken wir
drauf und sehen dort eine Null. Nun gehen wir die Schichten wieder zurück und rechnen
0 + 1 + 1 + ... + 1, bis wir zurück zur äußeren Schicht kommen.

So funktionieren rekursive Funktionen.


Zwischenspiel über Endrekursion
===============================

**Sigrid:** Das kommt mir aber ganz schön uneffektiv vor. Warum zählen wir nicht
gleich die Schichten, wenn wir sie das erste Mal abziehen? Das macht doch gar keinen
Sinn.

**Brynja:** Ich glaube, das hat was damit zu tun, dass auf jeder der Schichten immer
nur + 1 steht und nicht welche Zahl wir plus eins rechnen müssen.

**Alfrothul:** Aber dann könnten wir doch einfach zählen wie viele wir am Ende plus
rechnen müssen.

**Brynja:** *(ratlos)* Hm... ich weiß auch nicht. Mimer, kannst du uns helfen?

**Mimer:** Ihr habt alle ein Bisschen Recht. Nehmen wir wieder die
Nachfolger-Funktion als Beispiel. Was braucht die als Input?

**Sigrid:** Eine andere Zahl. Also die Null vom Ende.

**Brynja:** Naja, aber wir müssen sie ja genau so oft benutzen wie wir Schichten
haben. Und für jede neue Schicht bekommt sie dann ein neues Input.

**Mimer:** Stimmt genau. Wie könnten wir das jetzt ändern, dass wir bis zur Null
runter zählen?

**Alfrothul:** Wir müssen uns bei jedem Aufruf der Nachfolger-Funktion merken, wie
viele Schichten wir schon hatten?

**Brynja:** Das geht nicht ganz auf, wir haben ja die Null in der Mitte noch nicht
gefunden. Aber wir könnten für jede Schicht eine neue Funktion schreiben:

::

   let nachfolger x = x + 1;;

   let zweiter_nachfolger x = (nachfolger x) + 1;;

   let dritter_nachfolger x = (zweiter_nachfolger x) + 1;;

   let vierter_nachfolger x = (dritter_nachfolger x) + 1;;

   let fünfter_nachfolger x = (vierter_nachfolger x) + 1;;

   (* etc. *)


**Alfrothul:** Stimmt, dann können wir für jede Schicht immer die nächste Funktion
aufrufen.

**Sigrid:** *(aufgeregt)* Oh ja! Und wenn wir bei der Null angekommen sind, müssen
wir nur noch die Null in die richtige Nachfogler-Funktion füttern. Das heißt, dass
wir für jede Schicht eine Nachfolger-Funktion weiter gehen.

**Brynja:** Dann sind wir wieder am Anfang. Erst Schälen wir die Zwiebel und dann
füttern wir die Null in die richtige Nachfolger-Funktion, die dann von Null hoch
zählt.

**Sigrid:** Hm... stimmt. Mimer...?

**Mimer:** Ihr könntet der Funktion noch einen zusätzlichen Parameter geben, der
beschreibt wie viele Schichten ihr von der Zwiebel bisher abgeschält habt.

**Sigrid:** Okay, lasst mich mal ran! 

::

   let nter_nachfolger n x = x + n;;

**Sigrid:** So hier?

**Alfrothul:** Das ist ja nur ganz normale Addition.

**Brynja:** Aber wartet mal, das stimmt doch auch. Wir müssen schließlich am Ende nur
null plus die Anzahl der Schichten rechnen.

**Mimer:** Genau, der zusätzliche Parameter macht's möglich. Das nennen wir
Endrekursion, wo wir nur einmal bis zur Mitte der Zwiebel gehen und nicht wieder
zurück. Das wirkt einfacher, ist aber beim Programmieren komplizierter. Daher lasst
uns jetzt erstmal die einfache Rekursionanschauen, die ihr gerade so wunderbar
beschrieben habt.


Rekursive Funktionen in OCaml
=============================

Die Folge von Nachfolger-Funktionen, die wir gerade gesehen haben, ist der Vorläufer
von Rekursiven Funktionen. Jede Funktion ruft die Funktion vor ihr auf und legt eins
zum Resultat dazu.

Viel schlauer wäre es, wenn wir eine Funktion hätten, die wir einfach immer wieder
aufrufen könnten:

::

   let nter_nachfolger zwiebel =
     if zwiebel = keim
     then keim
     else 1 + (nter_nachfolger (zwiebel - äußere schicht));;

Oder, wenn wir statt einer Zwiebel eine Zahl haben:

::

   let nter_nachfolger x =
     if x = 0
     then 0
     else 1 + (nter_nachfolger (x - 1));;


Wenn wir das allerdings in OCaml eingeben, dann bekommen wir folgende Fehlermeldung:

::

   Error: Unbound value nter_nachfolger
   Hint: If this is a recursive definition,
   you should add the 'rec' keyword on line 1

OCaml ist hier sehr hilfreich und erkennt, dass wir eine rekursive Funktion
definieren wollen. Die Art wie wir das tun ist mit dem Keywort ``rec``:

::

   let rec nter_nachfolger x =
     if x = 0
     then 0
     else 1 + (nter_nachfolger (x - 1));;

Und tatsächlich, OCaml erlaubt uns die Funktion zu definieren.

Wenn wir nun richtig liegen mit unserer Theorie, bekommen wir jedes Mal wenn wir eine
natürliche Zahl in diese Funktion werfen auch genau diese Zahl als Resultat.

::

   # nter_nachfolger 1;;
   - : int = 1
   # nter_nachfolger 30;;
   - : int = 30
   #

Sieht ganz so aus. Achtung: Wir haben nur mit natürlichen (also nicht-negativen)
Zahlen gearbeitet. Da wir immer weiter runter zählen, bis wir zu 0 kommen, würde
OCaml beim Input einer negativen Zahl unendlich laufen. Probiere es gerne aus.

(Okay, OCaml läuft nicht ewig, sondern gibt uns eine Fehlermeldung zurück. Das liegt
daran, dass der Computer nicht unendlich viel Speicherplatz hat. Hätte OCaml
unendlich viel Platz, könnte es auch ewig laufen.)


Multiplikation als rekursive Funktion
=====================================

Eine Funktion, die bis zu ihrem Input zählt ist allerdings nicht gerade spannend.

Spannender wird es, wenn wir nicht mehr jedes Mal 1 dazu legen, sondern zum
Beispiel 2. Wenn wir das tun, bekommen wir eine Funktion, die ihr Input verdoppelt: 

::

   let rec verdoppel x =
     if x = 0
     then 0
     else 2 + (verdoppel (x - 1));;

In dieser Funktion pulen wir die Zahl auseinander und legen jedes Mal 2 dazu. Damit
verdoppeln wir am Ende das Input.

Bemerke: Wir können auch hier wieder Basisfall und Induktionsfall verwenden um die
Funktion zu verstehen. Bei natürlichen Zahlen, wie wir sie definiert haben, ist der
Basisfall 0 und der Induktionsfall gilt für jede Zahl, die größer als null ist.

In dieser Verdoppelungs-Funktion ist also:

**Basisfall:** 0 * 2 = 0

**Induktionsfall** n * 2 = 2 + (n-1) * 2


Übung 33
========

* Bearbeite den :download:`Ocaml-Code für diese Woche
  <../exercises/week-07/exercises_for_week-07.ml>` und füge einen Test für eine
  ``verdreifache``-Funktion hinzu. Schreibe danach die Funktion so wie die beiden
  obigen Funktionen.

* Beschreibe den Basisfall und den Induktionsfall für deine Funktion.




Version of "rekursion"
======================

[2023-02-11] Erstellt

[2023-02-22] Fertiggestellt
