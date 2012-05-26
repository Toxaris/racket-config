#lang s-exp framework/keybinding-lang

; DrRacket keybindings for german keyboard layout

; HELPERS

(define (call-function name flag)
  (lambda (ed evt)
    (send (send ed get-keymap) call-function name ed evt flag)))

; KEY BINDINGS

; m:[
; automatically choose between ( and [
(keybinding "m:["
  (call-function "maybe-insert-[]-pair-maybe-fixup-[]" #t))

; (
; automatically choose between ( and [
(keybinding "("
  (lambda (ed evt)
    (let* ([pos (send ed get-start-position)])
      (send ed begin-edit-sequence #f #f)
      (send ed insert "(" pos 'same #f)
      (when (eq? (send ed classify-position pos) 'parenthesis)
        (send ed delete pos (+ pos 1) #f)
        ((call-function "maybe-insert-[]-pair-maybe-fixup-[]" #t) ed evt))
      (send ed end-edit-sequence))))

; c:space
; start auto-completion
(keybinding "c:space"
  (lambda (ed evt)
    (send ed auto-complete)))
