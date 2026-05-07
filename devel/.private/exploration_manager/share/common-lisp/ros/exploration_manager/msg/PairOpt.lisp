; Auto-generated. Do not edit!


(cl:in-package exploration_manager-msg)


;//! \htmlinclude PairOpt.msg.html

(cl:defclass <PairOpt> (roslisp-msg-protocol:ros-message)
  ((from_drone_id
    :reader from_drone_id
    :initarg :from_drone_id
    :type cl:integer
    :initform 0)
   (to_drone_id
    :reader to_drone_id
    :initarg :to_drone_id
    :type cl:integer
    :initform 0)
   (stamp
    :reader stamp
    :initarg :stamp
    :type cl:float
    :initform 0.0)
   (ego_ids
    :reader ego_ids
    :initarg :ego_ids
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0))
   (other_ids
    :reader other_ids
    :initarg :other_ids
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0))
   (ego_posit
    :reader ego_posit
    :initarg :ego_posit
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (other_posit
    :reader other_posit
    :initarg :other_posit
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point)))
)

(cl:defclass PairOpt (<PairOpt>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PairOpt>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PairOpt)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exploration_manager-msg:<PairOpt> is deprecated: use exploration_manager-msg:PairOpt instead.")))

(cl:ensure-generic-function 'from_drone_id-val :lambda-list '(m))
(cl:defmethod from_drone_id-val ((m <PairOpt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:from_drone_id-val is deprecated.  Use exploration_manager-msg:from_drone_id instead.")
  (from_drone_id m))

(cl:ensure-generic-function 'to_drone_id-val :lambda-list '(m))
(cl:defmethod to_drone_id-val ((m <PairOpt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:to_drone_id-val is deprecated.  Use exploration_manager-msg:to_drone_id instead.")
  (to_drone_id m))

(cl:ensure-generic-function 'stamp-val :lambda-list '(m))
(cl:defmethod stamp-val ((m <PairOpt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:stamp-val is deprecated.  Use exploration_manager-msg:stamp instead.")
  (stamp m))

(cl:ensure-generic-function 'ego_ids-val :lambda-list '(m))
(cl:defmethod ego_ids-val ((m <PairOpt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:ego_ids-val is deprecated.  Use exploration_manager-msg:ego_ids instead.")
  (ego_ids m))

(cl:ensure-generic-function 'other_ids-val :lambda-list '(m))
(cl:defmethod other_ids-val ((m <PairOpt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:other_ids-val is deprecated.  Use exploration_manager-msg:other_ids instead.")
  (other_ids m))

(cl:ensure-generic-function 'ego_posit-val :lambda-list '(m))
(cl:defmethod ego_posit-val ((m <PairOpt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:ego_posit-val is deprecated.  Use exploration_manager-msg:ego_posit instead.")
  (ego_posit m))

(cl:ensure-generic-function 'other_posit-val :lambda-list '(m))
(cl:defmethod other_posit-val ((m <PairOpt>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:other_posit-val is deprecated.  Use exploration_manager-msg:other_posit instead.")
  (other_posit m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PairOpt>) ostream)
  "Serializes a message object of type '<PairOpt>"
  (cl:let* ((signed (cl:slot-value msg 'from_drone_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'to_drone_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'stamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ego_ids))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    ))
   (cl:slot-value msg 'ego_ids))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'other_ids))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    ))
   (cl:slot-value msg 'other_ids))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'ego_posit) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'other_posit) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PairOpt>) istream)
  "Deserializes a message object of type '<PairOpt>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'from_drone_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'to_drone_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
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
  (cl:setf (cl:slot-value msg 'ego_ids) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ego_ids)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'other_ids) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'other_ids)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256)))))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'ego_posit) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'other_posit) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PairOpt>)))
  "Returns string type for a message object of type '<PairOpt>"
  "exploration_manager/PairOpt")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PairOpt)))
  "Returns string type for a message object of type 'PairOpt"
  "exploration_manager/PairOpt")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PairOpt>)))
  "Returns md5sum for a message object of type '<PairOpt>"
  "1a32be6071621dab5076a6dace7a9598")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PairOpt)))
  "Returns md5sum for a message object of type 'PairOpt"
  "1a32be6071621dab5076a6dace7a9598")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PairOpt>)))
  "Returns full string definition for message of type '<PairOpt>"
  (cl:format cl:nil "~%int32 from_drone_id~%int32 to_drone_id~%~%float64 stamp~%int8[] ego_ids~%int8[] other_ids~%~%# FAME~%geometry_msgs/Point ego_posit~%geometry_msgs/Point other_posit~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PairOpt)))
  "Returns full string definition for message of type 'PairOpt"
  (cl:format cl:nil "~%int32 from_drone_id~%int32 to_drone_id~%~%float64 stamp~%int8[] ego_ids~%int8[] other_ids~%~%# FAME~%geometry_msgs/Point ego_posit~%geometry_msgs/Point other_posit~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PairOpt>))
  (cl:+ 0
     4
     4
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ego_ids) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'other_ids) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'ego_posit))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'other_posit))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PairOpt>))
  "Converts a ROS message object to a list"
  (cl:list 'PairOpt
    (cl:cons ':from_drone_id (from_drone_id msg))
    (cl:cons ':to_drone_id (to_drone_id msg))
    (cl:cons ':stamp (stamp msg))
    (cl:cons ':ego_ids (ego_ids msg))
    (cl:cons ':other_ids (other_ids msg))
    (cl:cons ':ego_posit (ego_posit msg))
    (cl:cons ':other_posit (other_posit msg))
))
