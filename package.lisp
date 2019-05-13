(cl:defpackage #:xcall
  (:use #:cl)
  (:import-from #:trivial-jumptables
                #:ejumpcase)
  (:import-from #:trivial-macroexpand-all
                #:macroexpand-all)
  (:import-from #:bubble-operator-upwards
                #:cartesian-product)
  (:export #:xcall))
