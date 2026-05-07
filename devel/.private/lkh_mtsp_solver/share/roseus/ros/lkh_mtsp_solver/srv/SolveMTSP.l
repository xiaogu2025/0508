;; Auto-generated. Do not edit!


(when (boundp 'lkh_mtsp_solver::SolveMTSP)
  (if (not (find-package "LKH_MTSP_SOLVER"))
    (make-package "LKH_MTSP_SOLVER"))
  (shadow 'SolveMTSP (find-package "LKH_MTSP_SOLVER")))
(unless (find-package "LKH_MTSP_SOLVER::SOLVEMTSP")
  (make-package "LKH_MTSP_SOLVER::SOLVEMTSP"))
(unless (find-package "LKH_MTSP_SOLVER::SOLVEMTSPREQUEST")
  (make-package "LKH_MTSP_SOLVER::SOLVEMTSPREQUEST"))
(unless (find-package "LKH_MTSP_SOLVER::SOLVEMTSPRESPONSE")
  (make-package "LKH_MTSP_SOLVER::SOLVEMTSPRESPONSE"))

(in-package "ROS")





(defclass lkh_mtsp_solver::SolveMTSPRequest
  :super ros::object
  :slots (_prob ))

(defmethod lkh_mtsp_solver::SolveMTSPRequest
  (:init
   (&key
    ((:prob __prob) 0)
    )
   (send-super :init)
   (setq _prob (round __prob))
   self)
  (:prob
   (&optional __prob)
   (if __prob (setq _prob __prob)) _prob)
  (:serialization-length
   ()
   (+
    ;; uint8 _prob
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _prob
       (write-byte _prob s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _prob
     (setq _prob (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass lkh_mtsp_solver::SolveMTSPResponse
  :super ros::object
  :slots (_empty ))

(defmethod lkh_mtsp_solver::SolveMTSPResponse
  (:init
   (&key
    ((:empty __empty) 0)
    )
   (send-super :init)
   (setq _empty (round __empty))
   self)
  (:empty
   (&optional __empty)
   (if __empty (setq _empty __empty)) _empty)
  (:serialization-length
   ()
   (+
    ;; uint8 _empty
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _empty
       (write-byte _empty s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _empty
     (setq _empty (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass lkh_mtsp_solver::SolveMTSP
  :super ros::object
  :slots ())

(setf (get lkh_mtsp_solver::SolveMTSP :md5sum-) "5b562e6076c8d155d3ad455cb6275b9e")
(setf (get lkh_mtsp_solver::SolveMTSP :datatype-) "lkh_mtsp_solver/SolveMTSP")
(setf (get lkh_mtsp_solver::SolveMTSP :request) lkh_mtsp_solver::SolveMTSPRequest)
(setf (get lkh_mtsp_solver::SolveMTSP :response) lkh_mtsp_solver::SolveMTSPResponse)

(defmethod lkh_mtsp_solver::SolveMTSPRequest
  (:response () (instance lkh_mtsp_solver::SolveMTSPResponse :init)))

(setf (get lkh_mtsp_solver::SolveMTSPRequest :md5sum-) "5b562e6076c8d155d3ad455cb6275b9e")
(setf (get lkh_mtsp_solver::SolveMTSPRequest :datatype-) "lkh_mtsp_solver/SolveMTSPRequest")
(setf (get lkh_mtsp_solver::SolveMTSPRequest :definition-)
      "uint8 prob
---
uint8 empty
")

(setf (get lkh_mtsp_solver::SolveMTSPResponse :md5sum-) "5b562e6076c8d155d3ad455cb6275b9e")
(setf (get lkh_mtsp_solver::SolveMTSPResponse :datatype-) "lkh_mtsp_solver/SolveMTSPResponse")
(setf (get lkh_mtsp_solver::SolveMTSPResponse :definition-)
      "uint8 prob
---
uint8 empty
")



(provide :lkh_mtsp_solver/SolveMTSP "5b562e6076c8d155d3ad455cb6275b9e")


