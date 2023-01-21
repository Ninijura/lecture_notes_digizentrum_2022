=========================================================
Emacs benutzen um mit dem OCaml-Prozessor zu interagieren
=========================================================

0. Lade die .ml-Datei in einen entsprechenden Ordner herunter.

1. Öffne diese Datei (``C-x C-f``), bearbeite sie so viel oder wenig wie du möchtest
   und speicher sie (``C-x C-s``).

2. Start OCaml (``M-x run-ocaml``). Dies teilt dein Emacs-Fenster in zwei Hälften
   (``C-x o`` um zwischen den Emacs-Fenstern zu wechseln).

3. Im OCaml-Fenster schreib ``#use "die-entsprechende-datei.ml;;"``, wo
   ``die-entpsrechende-datei.ml`` der Name der Datei sein sollte, die du benutzen
   willst; drücke Enter.

   OCaml verarbeitet nun den Inhalt der Datei genau so, als wenn du alles Zeichen für
   Zeichen in den Prozess eingetippt hättest.

   Wenn in der Datei, die du lädst, Fehler sind, wird der OCaml-Prozessor beim ersten
   Fehler anhalten und eine Fehlermeldung samt Zeilennummer drucken. Gehe dann zurück
   in das andere Emacs Fenster (``C-x o``) und zur entsprechenden Zeile (``M-x
   goto-line`` enter, gefolgt von der Zeilennummer (und nochmal enter)). Korrigiere
   was zu korrigieren ist, speicher die Datei (``C-x C-s``), geh zurück zum
   OCaml-Fenster (``C-x o``), und lade die datei erneut (``M-p`` enter).

Voraussetzungen
---------------
* Du musst wissen, wie man den Ordner für diese Woche öffnet.
* Du musst wissen, wie man eine .ml-Datei in diesen Ordner lädt. 
* Du musst wissen, wie man eine Datei öffnet.
* Du musst wissen, wie man eine Datei bearbeitet.
* Du musst wissen, wie man eine Datei speichert. 
* Du musst wissen, wie man OCaml startet.
* Du musst wissen, wie man zwischen zwei Emacs Fenstern hin und her wechselt. 
            

Was schiefgehen kann
--------------------

* Problem: Die .ml-Datei ist in den falschen Ordner heruntergeladen.

  Lösung: entweder die Datei in den richtigen Ordner verschieben, oder herausfinden,
  wie man den Browser dazu bekommt, dass er einen den Download-Ordner selbst wählen
  lässt.

* Problem: der OCaml-Prozessor startet in einem anderen Ordner.

  Lösung #1: gib nach dem ``#use`` Kommando einen absoluten Pfad ein.

  Lösung #2: ändere den Ordner des OCaml-Prozessors mit  ``#cd "absoluter-pfad-zum-richtigen-ordner``;;.

* Problem: du hast einen Fehler behoben, aber OCaml zeigt ihn beim nächsten Laden
  wieder an.

  Erklärung: du hast vergessen nach der Korrektur zu speichern.


Perspektiven
------------

Dieser Modus Operandi ist minimal, aber einfach zu lernen und ausreichend um dich
durch diesen Kurs zu steuern.

Er ist begrenzt, da er annimmt, dass dein gesamtes Programm in einer einzigen Datei
ist. Wenn du ein Programm auf mehrere Dateien aufteilen willst, musst du diese
Dateien in der richtigen Reihenfolge laden, oder das ``#use`` Kommando in den Dateien
verwenden.







Version of "emacs_und_ocaml"
----------------------------

Erstellt [2022-10-14]
