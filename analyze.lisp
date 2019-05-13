(in-package #:xcall)

(defun %visit-branch (env alternative)
  (declare (ignore env))
  `(symbol-macrolet ()
     ,alternative))

(defun %expand-alt (xcall-invocation-id parent-alt-invocation-id env alternatives)
  (declare (ignore xcall-invocation-id parent-alt-invocation-id))
  `(progn ,@(mapcar (lambda (alternative)
                      (%visit-branch env alternative))
                    alternatives)))

(defun %wrap-alt-macrolet (xcall-invocation-id parent-alt-invocation-id alt form)
  `(macrolet ((,alt (&environment env &body alternatives)
                (%expand-alt ',xcall-invocation-id ',parent-alt-invocation-id env alternatives)))
     ,form))

(defvar *xcall-counter* 0)

(defun %walk-xcall-structure (function alt form env)
  (declare (ignore function))
  (let ((xcall-invocation-id (gensym (format nil "~A-~A"
                                             (string '#:xcall-invocation)
                                             (incf *xcall-counter*)))))
    (macroexpand-all (%wrap-alt-macrolet xcall-invocation-id nil alt form) env)))

(defun %analyze-xcall-structure (alt form env)
  (%walk-xcall-structure (lambda (parent index)
                           (print parent)
                           (print index))
                         alt form env))
