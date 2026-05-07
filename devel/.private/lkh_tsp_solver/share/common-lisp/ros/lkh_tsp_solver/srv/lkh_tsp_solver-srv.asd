
(cl:in-package :asdf)

(defsystem "lkh_tsp_solver-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "SolveTSP" :depends-on ("_package_SolveTSP"))
    (:file "_package_SolveTSP" :depends-on ("_package"))
  ))