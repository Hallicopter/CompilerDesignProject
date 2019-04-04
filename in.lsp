(define foo (fun () 0))
(print-num foo)

(define x 1)
(define bar (fun (x y) (+ x y)))
(print-num (bar 2 3))
(print-num x)

(define bar (fun (x) (+ x 1)))

(define bar-z (fun () 2))

(print-num (bar (bar-z)))

(print-num 
  ((fun (x) (+ x 1)) 2))

(define x 1)

(print-num x)

(define y (+ 1 2 3))

(print-num y)

(print-bool (and #t (> 2 1)))

(print-bool (or (> 1 2) #f))

(print-bool (not (> 1 2)))

(print-num (if (< 1 2) (+ 1 2 3) (* 1 2 3 4 5)))

(print-num (if (= 9 (* 2 5))
               0
               (if #t 1 2)))

