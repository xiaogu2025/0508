; Auto-generated. Do not edit!


(cl:in-package plan_env_msgs-msg)


;//! \htmlinclude ChunkStamps.msg.html

(cl:defclass <ChunkStamps> (roslisp-msg-protocol:ros-message)
  ((from_drone_id
    :reader from_drone_id
    :initarg :from_drone_id
    :type cl:integer
    :initform 0)
   (idx_lists
    :reader idx_lists
    :initarg :idx_lists
    :type (cl:vector plan_env_msgs-msg:IdxList)
   :initform (cl:make-array 0 :element-type 'plan_env_msgs-msg:IdxList :initial-element (cl:make-instance 'plan_env_msgs-msg:IdxList)))
   (time
    :reader time
    :initarg :time
    :type cl:float
    :initform 0.0))
)

(cl:defclass ChunkStamps (<ChunkStamps>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ChunkStamps>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ChunkStamps)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name plan_env_msgs-msg:<ChunkStamps> is deprecated: use plan_env_msgs-msg:ChunkStamps instead.")))

(cl:ensure-generic-function 'from_drone_id-val :lambda-list '(m))
(cl:defmethod from_drone_id-val ((m <ChunkStamps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:from_drone_id-val is deprecated.  Use plan_env_msgs-msg:from_drone_id instead.")
  (from_drone_id m))

(cl:ensure-generic-function 'idx_lists-val :lambda-list '(m))
(cl:defmethod idx_lists-val ((m <ChunkStamps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:idx_lists-val is deprecated.  Use plan_env_msgs-msg:idx_lists instead.")
  (idx_lists m))

(cl:ensure-generic-function 'time-val :lambda-list '(m))
(cl:defmethod time-val ((m <ChunkStamps>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:time-val is deprecated.  Use plan_env_msgs-msg:time instead.")
  (time m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ChunkStamps>) ostream)
  "Serializes a message object of type '<ChunkStamps>"
  (cl:let* ((signed (cl:slot-value msg 'from_drone_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'idx_lists))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'idx_lists))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ChunkStamps>) istream)
  "Deserializes a message object of type '<ChunkStamps>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'from_drone_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'idx_lists) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'idx_lists)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'plan_env_msgs-msg:IdxList))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'time) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ChunkStamps>)))
  "Returns string type for a message object of type '<ChunkStamps>"
  "plan_env_msgs/ChunkStamps")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ChunkStamps)))
  "Returns string type for a message object of type 'ChunkStamps"
  "plan_env_msgs/ChunkStamps")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ChunkStamps>)))
  "Returns md5sum for a message object of type '<ChunkStamps>"
  "4649dd6de5a06d0faa920a6802067e3f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ChunkStamps)))
  "Returns md5sum for a message object of type 'ChunkStamps"
  "4649dd6de5a06d0faa920a6802067e3f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ChunkStamps>)))
  "Returns full string definition for message of type '<ChunkStamps>"
  (cl:format cl:nil "~%int32 from_drone_id~%IdxList[] idx_lists~%float64 time~%================================================================================~%MSG: plan_env_msgs/IdxList~%int32[] ids~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ChunkStamps)))
  "Returns full string definition for message of type 'ChunkStamps"
  (cl:format cl:nil "~%int32 from_drone_id~%IdxList[] idx_lists~%float64 time~%================================================================================~%MSG: plan_env_msgs/IdxList~%int32[] ids~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ChunkStamps>))
  (cl:+ 0
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'idx_lists) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ChunkStamps>))
  "Converts a ROS message object to a list"
  (cl:list 'ChunkStamps
    (cl:cons ':from_drone_id (from_drone_id msg))
    (cl:cons ':idx_lists (idx_lists msg))
    (cl:cons ':time (time msg))
))
