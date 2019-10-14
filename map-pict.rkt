#lang racket

(provide map-pict sleep-time)

(require pict
         map-widget/private/map-impl
         racket/draw
         "./util.rkt"
         )

(define sleep-time (make-parameter 1))

(define (map-pict width height
                  #:zoom [zoom 9]
                  #:position [position #f]
                  . markers)
  (define renderer (new map-impl%
                        [width width] [height height]
                        [zoom zoom] [position position]))


  (for ([m markers])
    (send renderer add-marker
          (marker-position m)
          (marker-text m)
          1
          (marker-color m)))
  

  
  (dc (lambda (dc x y)
        (send renderer draw dc x y))
      width height)

  (sleep (sleep-time))

  (dc (lambda (dc x y)
        (send renderer draw dc x y))
      width height))
