;; Auto-generated. Do not edit!


(when (boundp 'plan_env_msgs::IdxList)
  (if (not (find-package "PLAN_ENV_MSGS"))
    (make-package "PLAN_ENV_MSGS"))
  (shadow 'IdxList (find-package "PLAN_ENV_MSGS")))
(unless (find-package "PLAN_ENV_MSGS::IDXLIST")
  (make-package "PLAN_ENV_MSGS::IDXLIST"))

(in-package "ROS")
;;//! \htmlinclude IdxList.msg.html


(defclass plan_env_msgs::IdxList
  :super ros::object
  :slots (_ids ))

(defmethod plan_env_msgs::IdxList
  (:init
   (&key
    ((:ids __ids) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _ids __ids)
   self)
  (:ids
   (&optional __ids)
   (if __ids (setq _ids __ids)) _ids)
  (:serialization-length
   ()
   (+
    ;; int32[] _ids
    (* 4    (length _ids)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32[] _ids
     (write-long (length _ids) s)
     (dotimes (i (length _ids))
       (write-long (elt _ids i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32[] _ids
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ids (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _ids i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get plan_env_msgs::IdxList :md5sum-) "4f22efebf407aadba2ecc69df353d113")
(setf (get plan_env_msgs::IdxList :datatype-) "plan_env_msgs/IdxList")
(setf (get plan_env_msgs::IdxList :definition-)
      "int32[] ids
")



(provide :plan_env_msgs/IdxList "4f22efebf407aadba2ecc69df353d113")


