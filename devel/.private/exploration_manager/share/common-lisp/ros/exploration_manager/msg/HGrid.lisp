; Auto-generated. Do not edit!


(cl:in-package exploration_manager-msg)


;//! \htmlinclude HGrid.msg.html

(cl:defclass <HGrid> (roslisp-msg-protocol:ros-message)
  ((stamp
    :reader stamp
    :initarg :stamp
    :type cl:float
    :initform 0.0)
   (points1
    :reader points1
    :initarg :points1
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (points2
    :reader points2
    :initarg :points2
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point))))
)

(cl:defclass HGrid (<HGrid>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HGrid>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HGrid)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exploration_manager-msg:<HGrid> is deprecated: use exploration_manager-msg:HGrid instead.")))

(cl:ensure-generic-function 'stamp-val :lambda-list '(m))
(cl:defmethod stamp-val ((m <HGrid>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:stamp-val is deprecated.  Use exploration_manager-msg:stamp instead.")
  (stamp m))

(cl:ensure-generic-function 'points1-val :lambda-list '(m))
(cl:defmethod points1-val ((m <HGrid>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:points1-val is deprecated.  Use exploration_manager-msg:points1 instead.")
  (points1 m))

(cl:ensure-generic-function 'points2-val :lambda-list '(m))
(cl:defmethod points2-val ((m <HGrid>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:points2-val is deprecated.  Use exploration_manager-msg:points2 instead.")
  (points2 m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HGrid>) ostream)
  "Serializes a message object of type '<HGrid>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'stamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points1))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points1))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points2))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points2))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HGrid>) istream)
  "Deserializes a message object of type '<HGrid>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'stamp) (roslisp-utils:decode-double-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points1) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points1)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points2) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points2)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HGrid>)))
  "Returns string type for a message object of type '<HGrid>"
  "exploration_manager/HGrid")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HGrid)))
  "Returns string type for a message object of type 'HGrid"
  "exploration_manager/HGrid")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HGrid>)))
  "Returns md5sum for a message object of type '<HGrid>"
  "3b4c53f50ed104410c54e07de27d9dc1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HGrid)))
  "Returns md5sum for a message object of type 'HGrid"
  "3b4c53f50ed104410c54e07de27d9dc1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HGrid>)))
  "Returns full string definition for message of type '<HGrid>"
  (cl:format cl:nil "~%float64 stamp~%geometry_msgs/Point[] points1~%geometry_msgs/Point[] points2~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HGrid)))
  "Returns full string definition for message of type 'HGrid"
  (cl:format cl:nil "~%float64 stamp~%geometry_msgs/Point[] points1~%geometry_msgs/Point[] points2~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HGrid>))
  (cl:+ 0
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points1) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points2) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HGrid>))
  "Converts a ROS message object to a list"
  (cl:list 'HGrid
    (cl:cons ':stamp (stamp msg))
    (cl:cons ':points1 (points1 msg))
    (cl:cons ':points2 (points2 msg))
))
