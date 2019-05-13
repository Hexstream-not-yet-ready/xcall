(cl:defpackage #:xcall_tests
  (:use #:cl #:parachute)
  (:import-from #:xcall #:xcall))

(cl:in-package #:xcall_tests)

(defmacro are (comp expected form &optional description &rest format-args)
  `(is ,comp ,expected (multiple-value-list ,form) ,description ,@format-args))

(defmacro test-structure (form expected-structure)
  `(is equal ',expected-structure
       (xcall::%analyze-xcall-structure 'alt (list ,form) nil)))

(define-test "main"
  (test-structure 'foo t))
