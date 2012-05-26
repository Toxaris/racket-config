#lang s-exp framework/keybinding-lang

; from http://docs.racket-lang.org/drracket/Keyboard_Shortcuts.html
(define (rebind key command)
  (keybinding
   key
   (lambda (ed evt)
     (send (send ed get-keymap) call-function command ed evt #t))))

(rebind "(" "maybe-insert-[]-pair-maybe-fixup-[]")
(rebind "[" "maybe-insert-()-pair")
