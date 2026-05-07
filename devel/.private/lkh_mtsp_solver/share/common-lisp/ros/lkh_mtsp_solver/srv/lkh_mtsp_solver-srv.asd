
(cl:in-package :asdf)

(defsystem "lkh_mtsp_solver-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "SolveMTSP" :depends-on ("_package_SolveMTSP"))
    (:file "_package_SolveMTSP" :depends-on ("_package"))
  ))