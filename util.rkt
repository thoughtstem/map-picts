#lang racket

(provide (struct-out marker)
         color)

(require racket/draw)

(struct marker (position text color))

(define (color r g b)
  (make-object color% r g b))

