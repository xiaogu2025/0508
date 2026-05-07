;; Auto-generated. Do not edit!


(when (boundp 'exploration_manager::HGrid)
  (if (not (find-package "EXPLORATION_MANAGER"))
    (make-package "EXPLORATION_MANAGER"))
  (shadow 'HGrid (find-package "EXPLORATION_MANAGER")))
(unless (find-package "EXPLORATION_MANAGER::HGRID")
  (make-package "EXPLORATION_MANAGER::HGRID"))

(in-package "ROS")
;;//! \htmlinclude HGrid.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass exploration_manager::HGrid
  :super ros::object
  :slots (_stamp _points1 _points2 ))

(defmethod exploration_manager::HGrid
  (:init
   (&key
    ((:stamp __stamp) 0.0)
    ((:points1 __points1) ())
    ((:points2 __points2) ())
    )
   (send-super :init)
   (setq _stamp (float __stamp))
   (setq _points1 __points1)
   (setq _points2 __points2)
   self)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:points1
   (&rest __points1)
   (if (keywordp (car __points1))
       (send* _points1 __points1)
     (progn
       (if __points1 (setq _points1 (car __points1)))
       _points1)))
  (:points2
   (&rest __points2)
   (if (keywordp (car __points2))
       (send* _points2 __points2)
     (progn
       (if __points2 (setq _points2 (car __points2)))
       _points2)))
  (:serialization-length
   ()
   (+
    ;; float64 _stamp
    8
    ;; geometry_msgs/Point[] _points1
    (apply #'+ (send-all _points1 :serialization-length)) 4
    ;; geometry_msgs/Point[] _points2
    (apply #'+ (send-all _points2 :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _stamp
       (sys::poke _stamp (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; geometry_msgs/Point[] _points1
     (write-long (length _points1) s)
     (dolist (elem _points1)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Point[] _points2
     (write-long (length _points2) s)
     (dolist (elem _points2)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _stamp
     (setq _stamp (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; geometry_msgs/Point[] _points1
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points1 (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _points1)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; geometry_msgs/Point[] _points2
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points2 (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _points2)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get exploration_manager::HGrid :md5sum-) "3b4c53f50ed104410c54e07de27d9dc1")
(setf (get exploration_manager::HGrid :datatype-) "exploration_manager/HGrid")
(setf (get exploration_manager::HGrid :definition-)
      "
float64 stamp
geometry_msgs/Point[] points1
geometry_msgs/Point[] points2
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :exploration_manager/HGrid "3b4c53f50ed104410c54e07de27d9dc1")


