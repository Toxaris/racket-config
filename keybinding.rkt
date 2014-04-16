#lang s-exp framework/keybinding-lang

; DrRacket keybindings for german keyboard layout

; HELPERS

(define-syntax-rule (call-function name flag)
  (lambda (ed evt)
    (send (send ed get-keymap) call-function name ed evt flag)))

; KEY BINDINGS

; [
; insert [ or [] depending on preferences
(keybinding "m:["
  (call-function "maybe-insert-[]-pair" #t))

; (
; automatically choose between ( and [
;   (if activated in preferences!)
(keybinding "("
  (lambda (ed evt)
    (if (preferences:get 'framework:fixup-open-parens)
        (let* ([pos (send ed get-start-position)])
          (send ed begin-edit-sequence #f #f)
          (send ed insert "(" pos 'same #f)
          (let ([convert (eq? (send ed classify-position pos) 'parenthesis)])
            (send ed delete pos (+ pos 1) #f)
            (send ed end-edit-sequence)
            (if convert
                ((call-function "maybe-insert-[]-pair-maybe-fixup-[]" #t) ed evt)
                (send ed insert "(" pos 'same #f))))
        ((call-function "maybe-insert-()-pair" #t) ed evt))))

; c:(
; insert ( or () depending on preferences
(keybinding "c:("
  (call-function "maybe-insert-()-pair" #t))

; c:space
; start auto-completion
(keybinding "c:space"
  (lambda (ed evt)
    (send ed auto-complete)))
