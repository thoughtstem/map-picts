#lang racket

(provide map-pict sleep-time)

(require pict
         map-widget/private/map-impl
         map-widget/private/map-tiles
         racket/draw
         "./util.rkt"
         )

(define sleep-time (make-parameter 1))

(define (map-pict width height
                  #:zoom [zoom 9]
                  #:position [position #f]
                  . markers-and-tracks)
  (set! position
    (if (marker? position)
      (marker-position position)
      position))


  (define renderer (new map-impl%
                        [width width] [height height]
                        [zoom zoom] [position position]))

  (define markers (filter-not list? markers-and-tracks))
  (define tracks (filter list? markers-and-tracks))


  (for ([m markers])
    (send renderer add-marker
          (marker-position m)
          (marker-text m)
          1
          (marker-color m)))

  
  (for ([t tracks])
    (define l (map marker-position t))
    (send renderer add-track
          l
          #f))

  (displayln (get-download-backlog))
  
  (dc (lambda (dc x y)
        (send renderer draw dc x y))
      width height)

  (sleep (sleep-time))

  (let loop () 
    (when (> (get-download-backlog) 0)
      (displayln (~a "Map tiles to fetch: " (get-download-backlog))) 
      (sleep 1)
      (loop)))

  (dc (lambda (dc x y)
        (send renderer draw dc x y))
      width height))
