;; Auto-generated. Do not edit!


(when (boundp 'exploration_manager::GridTour)
  (if (not (find-package "EXPLORATION_MANAGER"))
    (make-package "EXPLORATION_MANAGER"))
  (shadow 'GridTour (find-package "EXPLORATION_MANAGER")))
(unless (find-package "EXPLORATION_MANAGER::GRIDTOUR")
  (make-package "EXPLORATION_MANAGER::GRIDTOUR"))

(in-package "ROS")
;;//! \htmlinclude GridTour.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass exploration_manager::GridTour
  :super ros::object
  :slots (_stamp _drone_id _points ))

(defmethod exploration_manager::GridTour
  (:init
   (&key
    ((:stamp __stamp) 0.0)
    ((:drone_id __drone_id) 0)
    ((:points __points) ())
    )
   (send-super :init)
   (setq _stamp (float __stamp))
   (setq _drone_id (round __drone_id))
   (setq _points __points)
   self)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:drone_id
   (&optional __drone_id)
   (if __drone_id (setq _drone_id __drone_id)) _drone_id)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:serialization-length
   ()
   (+
    ;; float64 _stamp
    8
    ;; int32 _drone_id
    4
    ;; geometry_msgs/Point[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _stamp
       (sys::poke _stamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int32 _drone_id
       (write-long _drone_id s)
     ;; geometry_msgs/Point[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _stamp
     (setq _stamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int32 _drone_id
     (setq _drone_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get exploration_manager::GridTour :md5sum-) "b83e54ce12aaeecd7147b77f7a94a9eb")
(setf (get exploration_manager::GridTour :datatype-) "exploration_manager/GridTour")
(setf (get exploration_manager::GridTour :definition-)
      "float64 stamp
int32 drone_id

geometry_msgs/Point[] points
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :exploration_manager/GridTour "b83e54ce12aaeecd7147b77f7a94a9eb")


