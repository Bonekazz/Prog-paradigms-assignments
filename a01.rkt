#lang slideshow
;; Name: Hierro Fernandes
;; Date: 24/09/2023
;; Assignment: 01

(require (lib "fungraph.ss" "concabs"))
;; Put programming exercises here

;;Exercise 1.4
(define (candy-temperature temp elev)
  (- temp (quotient elev 500))
 )

;;Exercise 1.5
(define (perc x)
  (/ x 100))

(define (tax amount)
  (if (> amount 10000)
      (* (perc 20) (- amount 10000))
      "you will not be taxed"
   )
)

;;Exercise 1.9

(define (half-turn element)
  (quarter-turn-right (quarter-turn-right element))
 )

(define (quarter-turn-left element)
  (quarter-turn-right (quarter-turn-right (quarter-turn-right element)))
 )

(define (side-by-side first second)
  (quarter-turn-right (stack (quarter-turn-left second) (quarter-turn-left first)))
 )

;;extra
(define (pattern option)
  (case option
    [(1) (stack (side-by-side (quarter-turn-left rcross-bb) rcross-bb) (side-by-side (quarter-turn-left (quarter-turn-left rcross-bb)) (quarter-turn-right rcross-bb)))]
    [(2) (stack (side-by-side (quarter-turn-left rcross-bb) rcross-bb) (side-by-side (quarter-turn-left rcross-bb) rcross-bb))]
    [else "no pattern corresponding to this option"]
  )
)

;;Exercise 1.10
(define (pinwheel)
  (stack (side-by-side (quarter-turn-right test-bb) (quarter-turn-right (quarter-turn-right test-bb))) (side-by-side test-bb (quarter-turn-left test-bb)))
)


;; This file contains definitions of quilt-cover "basic block" images for use
;; with Concrete Abstractions: An Introduction to Computer Science Using Scheme
;; by Max Hailperin, Barbara Kaiser, and Karl Knight.
;;
;; The images defined are:
;;  From chapter 1: rcross-bb, corner-bb, test-bb, and nova-bb
;;  From chapter 2: bitw-bb

;; A simple test image, to illustrate transformations.
(define test-bb
  (filled-triangle 0 1 0 -1 1 -1))

;; This one only has two triangles, but makes an interesting pinwheel.
(define nova-bb
  (overlay (filled-triangle 0 1 0 0 -1/2 0)
           (filled-triangle 0 0 0 1/2 1 0)))

;; Basic block for "Blowing in the Wind" quilting pattern from
;; "Quick-and-Easy Strip Quilting" by Helen Whitson Rose, Dover
;; Publications, New York, 1989, p. 59.
(define bitw-bb
  (overlay (overlay (filled-triangle -1 1 0 1 -1/2 1/2)
                    (filled-triangle -1 -1 0 -1 -1 0))
           (overlay (filled-triangle 1 1 1 0 0 0)
                    (filled-triangle 0 0 1 0 1/2 -1/2))))

;; The final two basic blocks defined in this file, rcross-bb and corner-bb,
;; are defined in a way intended to be unreasonably hard to understand, because
;; defining them is one of the exercises in the text.  It would be easier
;; for you to come up with your own definitions from scratch than by puzzling
;; these definitons out.  The only point of having them is to let you use the
;; blocks without first doing the definitions.  You might as well stop reading
;; here, the below is not meant to be readable.

;; Basic block for "Repeating Crosses" quilting pattern from
;; "Quick-and-Easy Strip Quilting" by Helen Whitson Rose, Dover
;; Publications, New York, 1989, p. 60.
(define rcross-bb #f)

;; A much simpler basic block, with one corner black.
(define corner-bb #f)

(let ((omb
       (lambda x
	 (let l
	   ((x (cdr x))
	    (y (list-tail (cdr x) (quotient (length x) 2)))
	    (z #f)
	    (w (car x)))
	   (if (null? y)
	       z
	       (l (cddddr x) (cddddr y)
		  (let* ((v (lambda (v) (/ v w)))
			 (v (filled-triangle (v (car y)) (v (car x))
					     (v (cadr y)) (v (cadr x))
					     (v (caddr y)) (v (caddr x)))))
		    (if z (overlay z v) v)) w))))))
  (set! rcross-bb (omb 2 2 2 1 1 1 2 1 2 1 1 -1 2 -1 -2 1 
		       2 1 -1 -1 2 -2 2
		       -1 1 -1 2 2 1 2 1 1 -1 1 2 2 1 -1 -1 1 1))
  (set! corner-bb (omb -1 -1 -1 0 0 0 -1 -1 -1))
  )