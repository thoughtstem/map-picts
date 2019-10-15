#lang scribble/manual
@require[@for-label[map-picts
                    racket/base]]

@title{map-picts}
@author{thoughtstem}

@defmodule[map-picts]


@defproc[(map-pict [#:zoom zoom number?] [#:position center-pos (or/c lat-lon? marker?)] [markers-or-lists (or/c marker? (listof marker?))] ...) pict?]{

@codeblock{
(define lafayette
  (marker #(30.230188 -92.010391) 
          "Born"
          (color 255 0 0)))

(define riyadh
  (marker #(24.687246 46.752999) 
          "Raised"
          (color 255 0 0)))

(define atlantic1
  (marker
   #(44.930148 -21.643282)
   "Ocean"
   (color 0 0 255)))

(define atlantic2
  (marker
   #(44.930148 -1.643282)
   "Ocean"
   (color 0 0 255)))

(map-pict 300 300
          #:position
          atlantic1
          #:zoom 1
          lafayette
          riyadh
          (list
           lafayette
           atlantic2
           riyadh
           atlantic1
           lafayette))
}

}
