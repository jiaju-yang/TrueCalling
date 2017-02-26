#lang planet neil/sicp
(define (make-mutex-n n)
  (let ((lock (make-mutex))
        (taken 0))
    (define (dispatch m)
      (cond ((eq? m 'acquire)
             (lock 'acquire)
             (if (< taken n)
                 (begin (set! taken (+ taken 1))
                        (lock 'release))
                 (begin (lock 'release)
                        (dispatch 'acquire))))
            ((eq? m 'release)
             (lock 'acquire)
             (set! taken (- taken 1))
             (lock 'release))))
    dispatch))