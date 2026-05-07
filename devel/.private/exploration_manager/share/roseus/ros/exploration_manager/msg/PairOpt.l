;; Auto-generated. Do not edit!


(when (boundp 'exploration_manager::PairOpt)
  (if (not (find-package "EXPLORATION_MANAGER"))
    (make-package "EXPLORATION_MANAGER"))
  (shadow 'PairOpt (find-package "EXPLORATION_MANAGER")))
(unless (find-package "EXPLORATION_MANAGER::PAIROPT")
  (make-package "EXPLORATION_MANAGER::PAIROPT"))

(in-package "ROS")
;;//! \htmlinclude PairOpt.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass exploration_manager::PairOpt
  :super ros::object
  :slots (_from_drone_id _to_drone_id _stamp _ego_ids _other_ids _ego_posit _other_posit ))

(defmethod exploration_manager::PairOpt
  (:init
   (&key
    ((:from_drone_id __from_drone_id) 0)
    ((:to_drone_id __to_drone_id) 0)
    ((:stamp __stamp) 0.0)
    ((:ego_ids __ego_ids) (make-array 0 :initial-element 0 :element-type :integer))
    ((:other_ids __other_ids) (make-array 0 :initial-element 0 :element-type :integer))
    ((:ego_posit __ego_posit) (instance geometry_msgs::Point :init))
    ((:other_posit __other_posit) (instance geometry_msgs::Point :init))
    )
   (send-super :init)
   (setq _from_drone_id (round __from_drone_id))
   (setq _to_drone_id (round __to_drone_id))
   (setq _stamp (float __stamp))
   (setq _ego_ids __ego_ids)
   (setq _other_ids __other_ids)
   (setq _ego_posit __ego_posit)
   (setq _other_posit __other_posit)
   self)
  (:from_drone_id
   (&optional __from_drone_id)
   (if __from_drone_id (setq _from_drone_id __from_drone_id)) _from_drone_id)
  (:to_drone_id
   (&optional __to_drone_id)
   (if __to_drone_id (setq _to_drone_id __to_drone_id)) _to_drone_id)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:ego_ids
   (&optional __ego_ids)
   (if __ego_ids (setq _ego_ids __ego_ids)) _ego_ids)
  (:other_ids
   (&optional __other_ids)
   (if __other_ids (setq _other_ids __other_ids)) _other_ids)
  (:ego_posit
   (&rest __ego_posit)
   (if (keywordp (car __ego_posit))
       (send* _ego_posit __ego_posit)
     (progn
       (if __ego_posit (setq _ego_posit (car __ego_posit)))
       _ego_posit)))
  (:other_posit
   (&rest __other_posit)
   (if (keywordp (car __other_posit))
       (send* _other_posit __other_posit)
     (progn
       (if __other_posit (setq _other_posit (car __other_posit)))
       _other_posit)))
  (:serialization-length
   ()
   (+
    ;; int32 _from_drone_id
    4
    ;; int32 _to_drone_id
    4
    ;; float64 _stamp
    8
    ;; int8[] _ego_ids
    (* 1    (length _ego_ids)) 4
    ;; int8[] _other_ids
    (* 1    (length _other_ids)) 4
    ;; geometry_msgs/Point _ego_posit
    (send _ego_posit :serialization-length)
    ;; geometry_msgs/Point _other_posit
    (send _other_posit :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _from_drone_id
       (write-long _from_drone_id s)
     ;; int32 _to_drone_id
       (write-long _to_drone_id s)
     ;; float64 _stamp
       (sys::poke _stamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int8[] _ego_ids
     (write-long (length _ego_ids) s)
     (dotimes (i (length _ego_ids))
       (write-byte (elt _ego_ids i) s)
       )
     ;; int8[] _other_ids
     (write-long (length _other_ids) s)
     (dotimes (i (length _other_ids))
       (write-byte (elt _other_ids i) s)
       )
     ;; geometry_msgs/Point _ego_posit
       (send _ego_posit :serialize s)
     ;; geometry_msgs/Point _other_posit
       (send _other_posit :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _from_drone_id
     (setq _from_drone_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _to_drone_id
     (setq _to_drone_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _stamp
     (setq _stamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int8[] _ego_ids
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _ego_ids (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _ego_ids i) (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> (elt _ego_ids i) 127) (setf (elt _ego_ids i) (- (elt _ego_ids i) 256)))
     ))
   ;; int8[] _other_ids
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _other_ids (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _other_ids i) (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> (elt _other_ids i) 127) (setf (elt _other_ids i) (- (elt _other_ids i) 256)))
     ))
   ;; geometry_msgs/Point _ego_posit
     (send _ego_posit :deserialize buf ptr-) (incf ptr- (send _ego_posit :serialization-length))
   ;; geometry_msgs/Point _other_posit
     (send _other_posit :deserialize buf ptr-) (incf ptr- (send _other_posit :serialization-length))
   ;;
   self)
  )

(setf (get exploration_manager::PairOpt :md5sum-) "1a32be6071621dab5076a6dace7a9598")
(setf (get exploration_manager::PairOpt :datatype-) "exploration_manager/PairOpt")
(setf (get exploration_manager::PairOpt :definition-)
      "
int32 from_drone_id
int32 to_drone_id

float64 stamp
int8[] ego_ids
int8[] other_ids

# FAME
geometry_msgs/Point ego_posit
geometry_msgs/Point other_posit

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :exploration_manager/PairOpt "1a32be6071621dab5076a6dace7a9598")


