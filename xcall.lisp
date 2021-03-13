(in-package #:xcall)

(xcall alt (values) (aref (print my-array) (alt 1 2 3)))
(values (aref (print my-array) 1)
        (aref (print my-array) 2)
        (aref (print my-array) 3))

(xcall alt (values) (operator (alt arg1 arg1-2) arg2))
(values (operator arg1 arg2) (operator arg1-2 arg2))

(xcall alt (values) (operator (alt arg1 arg1-2) (alt arg2 arg2-2)))
(values (operator arg1 arg2) (operator arg1 arg2-2) (operator arg1-2 arg2) (operator arg1-2 arg2-2))

(xcall alt (values) (operator (alt arg1 (alt arg2 arg2-2)) arg3))
(values (operator arg1 arg3) (operator arg2 arg3) (operator arg2-2 arg3))

(xcall alt (values) (alt arg1 arg2 arg3))
(values arg1 arg2 arg3)

(xcall alt (values) (alt arg1 (1+ (alt arg2 arg3))))
(values arg1 (1+ arg2) (1+ arg3))


(xcall alt (values) (foo bar))
(values (foo bar))
structure: t

(xcall alt (values) (foo (alt 1 2) (alt 3 4)))
(flet ((fun1 (arg1 arg2)
         (foo (ecase arg1
                (0 1)
                (1 2))
              (ecase arg2
                (0 3)
                (1 4)))))
  (values (fun1 0 0) (fun1 0 1) (fun1 1 0) (fun1 1 1)))
(values (foo 1 3) (foo 1 4) (foo 2 3) (foo 2 4))
structure: ((t t) (t t))


(xcall alt (values) (foo (alt 1 (alt 2 5)) (alt 3 4)))
(flet ((fun1 (arg1 arg2 arg3)
         (foo (ecase arg1
                (0 1)
                (1 (ecase arg2
                     (0 2)
                     (1 5))))
              (ecase arg3
                (0 3)
                (1 4)))))
  (values (fun1 0 nil 0) (fun1 0 nil 1) (fun1 1 0 0) (fun1 1 0 1) (fun1 1 1 0) (fun1 1 1 1)))
(values (foo 1 3) (foo 1 4) (foo 2 3) (foo 2 4) (foo 5 3) (foo 5 4))
structure: ((t (t t)) (t t))

(xcall alt (values) (foo (alt 1 (1+ (alt))) (alt 3 4)))
(flet ((fun1 (arg1)
         (foo 1
              (ecase arg1
                (0 3)
                (1 4)))))
  (values (fun1 0) (fun1 1)))
(values (foo 1 3) (foo 1 4))

(xcall alt (values) (foo (alt 1 (alt 2 5)) (alt)))
(values)

(xcall alt (values) (alt (alt (alt (alt 1)))))
(values 1)

(xcall alt (values) (alt (alt (alt (alt 1 2) 3) 4) 5))
(values 1 2 3 4 5)


(xcall alt (values) (xcall alt* (list) (foo (alt 1 2) (alt 3 4)
                                            (alt* 5 6) (alt* 7 8))))
(flet ((fun1 (arg1 arg2)
         (flet ((fun2 (arg3 arg4)
                  (foo (ecase arg1
                         (0 1)
                         (1 2))
                       (ecase arg2
                         (0 3)
                         (1 4))
                       (ecase arg3
                         (0 5)
                         (1 6))
                       (ecase arg4
                         (0 7)
                         (1 8)))))
           (list (fun2 0 0) (fun2 0 1) (fun2 1 0) (fun2 1 1)))))
  (values (list (fun1 0 0 0 0) (fun1 0 0 0 1) (fun1 0 0 1 0) (fun1 0 0 1 1))
          (list (fun1 0 1 0 0) (fun1 0 1 0 1) (fun1 0 1 1 0) (fun1 0 1 1 1))
          (list (fun1 1 0 0 0) (fun1 1 0 0 1) (fun1 1 0 1 0) (fun1 1 0 1 1))
          (list (fun1 1 1 0 0) (fun1 1 1 0 1) (fun1 1 1 1 0) (fun1 1 1 1 1))))
(values (list (foo 1 3 5 7) (foo 1 3 5 8) (foo 1 3 6 7) (foo 1 3 6 8))
        (list (foo 1 4 5 7) (foo 1 4 5 8) (foo 1 4 6 7) (foo 1 4 6 8))
        (list (foo 2 3 5 7) (foo 2 3 5 8) (foo 2 3 6 7) (foo 2 3 6 8))
        (list (foo 2 4 5 7) (foo 2 4 5 8) (foo 2 4 6 7) (foo 2 4 6 8)))
structure1: ((t t) (t t))
structure2: ((t t) (t t))

(xcall alt (bar)
  (xcall alt* (baz)
    (foo (alt 1 (alt* 2 3))
         (alt* 4 (alt 5 6)))))
(flet ((fun1 (arg1 arg2)
         (flet ((fun2 (arg3 arg4)
                  (foo (ecase arg1
                         (0 1)
                         (1 (ecase arg3
                              (0 2)
                              (1 3))))
                       (ecase arg4
                         (0 4)
                         (1 (ecase arg2
                              (0 5)
                              (1 6)))))))
           (baz (fun2 0 0) (fun2 0 1) (fun2 1 0) (fun2 1 1)))))
  (bar (fun1 0 0) (fun1 0 1) (fun1 1 0) (fun1 1 1)))
(bar (baz (foo 1 4)) (baz (foo 1 5)) (baz (foo 1 4)) (baz (foo 1 5)))
structure1: ((t t) (t t))
structure2: ((t t) (t t))
