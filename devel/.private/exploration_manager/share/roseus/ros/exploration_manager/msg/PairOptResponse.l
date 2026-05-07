;; Auto-generated. Do not edit!


(when (boundp 'exploration_manager::PairOptResponse)
  (if (not (find-package "EXPLORATION_MANAGER"))
    (make-package "EXPLORATION_MANAGER"))
  (shadow 'PairOptResponse (find-package "EXPLORATION_MANAGER")))
(unless (find-package "EXPLORATION_MANAGER::PAIROPTRESPONSE")
  (make-package "EXPLORATION_MANAGER::PAIROPTRESPONSE"))

(in-package "ROS")
;;//! \htmlinclude PairOptResponse.msg.html


(defclass exploration_manager::PairOptResponse
  :super ros::object
  :slots (_from_drone_id _to_drone_id _status _stamp ))

(defmethod exploration_manager::PairOptResponse
  (:init
   (&key
    ((:from_drone_id __from_drone_id) 0)
    ((:to_drone_id __to_drone_id) 0)
    ((:status __status) 0)
    ((:stamp __stamp) 0.0)
    )
   (send-super :init)
   (setq _from_drone_id (round __from_drone_id))
   (setq _to_drone_id (round __to_drone_id))
   (setq _status (round __status))
   (setq _stamp (float __stamp))
   self)
  (:from_drone_id
   (&optional __from_drone_id)
   (if __from_drone_id (setq _from_drone_id __from_drone_id)) _from_drone_id)
  (:to_drone_id
   (&optional __to_drone_id)
   (if __to_drone_id (setq _to_drone_id __to_drone_id)) _to_drone_id)
  (:status
   (&optional __status)
   (if __status (setq _status __status)) _status)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:serialization-length
   ()
   (+
    ;; int32 _from_drone_id
    4
    ;; int32 _to_drone_id
    4
    ;; int32 _status
    4
    ;; float64 _stamp
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _from_drone_id
       (write-long _from_drone_id s)
     ;; int32 _to_drone_id
       (write-long _to_drone_id s)
     ;; int32 _status
       (write-long _status s)
     ;; float64 _stamp
       (sys::poke _stamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _from_drone_id
     (setq _from_drone_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _to_drone_id
     (setq _to_drone_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _status
     (setq _status (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _stamp
     (setq _stamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get exploration_manager::PairOptResponse :md5sum-) "17778d18292b1daf26721edbd91a3ac7")
(setf (get exploration_manager::PairOptResponse :datatype-) "exploration_manager/PairOptResponse")
(setf (get exploration_manager::PairOptResponse :definition-)
      "
# Success or failure due to inconsistent views
int32 from_drone_id
int32 to_drone_id
int32 status 
float64 stamp
")



(provide :exploration_manager/PairOptResponse "17778d18292b1daf26721edbd91a3ac7")


