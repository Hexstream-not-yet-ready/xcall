(asdf:defsystem #:xcall

  :author "Jean-Philippe Paradis <hexstream@hexstreamsoft.com>"

  ;; See the UNLICENSE file for details.
  :license "Public Domain"

  :description "Maps a template over the cartesian product of trees of alternative forms provided within."

  :depends-on ("trivial-jumptables"
               "trivial-macroexpand-all"
               "bubble-operator-upwards")

  :version "0.1"
  :serial cl:t
  :components ((:file "package")
               (:file "analyze")
	       (:file "main"))

  :in-order-to ((asdf:test-op (asdf:test-op #:xcall_tests))))
