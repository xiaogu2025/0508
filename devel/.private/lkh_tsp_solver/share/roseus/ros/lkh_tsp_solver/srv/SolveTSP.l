;; Auto-generated. Do not edit!


(when (boundp 'lkh_tsp_solver::SolveTSP)
  (if (not (find-package "LKH_TSP_SOLVER"))
    (make-package "LKH_TSP_SOLVER"))
  (shadow 'SolveTSP (find-package "LKH_TSP_SOLVER")))
(unless (find-package "LKH_TSP_SOLVER::SOLVETSP")
  (make-package "LKH_TSP_SOLVER::SOLVETSP"))
(unless (find-package "LKH_TSP_SOLVER::SOLVETSPREQUEST")
  (make-package "LKH_TSP_SOLVER::SOLVETSPREQUEST"))
(unless (find-package "LKH_TSP_SOLVER::SOLVETSPRESPONSE")
  (make-package "LKH_TSP_SOLVER::SOLVETSPRESPONSE"))

(in-package "ROS")





(defclass lkh_tsp_solver::SolveTSPRequest
  :super ros::object
  :slots (_prob ))

(defmethod lkh_tsp_solver::SolveTSPRequest
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

(defclass lkh_tsp_solver::SolveTSPResponse
  :super ros::object
  :slots (_empty ))

(defmethod lkh_tsp_solver::SolveTSPResponse
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

(defclass lkh_tsp_solver::SolveTSP
  :super ros::object
  :slots ())

(setf (get lkh_tsp_solver::SolveTSP :md5sum-) "5b562e6076c8d155d3ad455cb6275b9e")
(setf (get lkh_tsp_solver::SolveTSP :datatype-) "lkh_tsp_solver/SolveTSP")
(setf (get lkh_tsp_solver::SolveTSP :request) lkh_tsp_solver::SolveTSPRequest)
(setf (get lkh_tsp_solver::SolveTSP :response) lkh_tsp_solver::SolveTSPResponse)

(defmethod lkh_tsp_solver::SolveTSPRequest
  (:response () (instance lkh_tsp_solver::SolveTSPResponse :init)))

(setf (get lkh_tsp_solver::SolveTSPRequest :md5sum-) "5b562e6076c8d155d3ad455cb6275b9e")
(setf (get lkh_tsp_solver::SolveTSPRequest :datatype-) "lkh_tsp_solver/SolveTSPRequest")
(setf (get lkh_tsp_solver::SolveTSPRequest :definition-)
      "uint8 prob
---
uint8 empty
")

(setf (get lkh_tsp_solver::SolveTSPResponse :md5sum-) "5b562e6076c8d155d3ad455cb6275b9e")
(setf (get lkh_tsp_solver::SolveTSPResponse :datatype-) "lkh_tsp_solver/SolveTSPResponse")
(setf (get lkh_tsp_solver::SolveTSPResponse :definition-)
      "uint8 prob
---
uint8 empty
")



(provide :lkh_tsp_solver/SolveTSP "5b562e6076c8d155d3ad455cb6275b9e")


