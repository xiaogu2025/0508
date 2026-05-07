; Auto-generated. Do not edit!


(cl:in-package plan_env_msgs-msg)


;//! \htmlinclude IdxList.msg.html

(cl:defclass <IdxList> (roslisp-msg-protocol:ros-message)
  ((ids
    :reader ids
    :initarg :ids
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass IdxList (<IdxList>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IdxList>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IdxList)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name plan_env_msgs-msg:<IdxList> is deprecated: use plan_env_msgs-msg:IdxList instead.")))

(cl:ensure-generic-function 'ids-val :lambda-list '(m))
(cl:defmethod ids-val ((m <IdxList>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:ids-val is deprecated.  Use plan_env_msgs-msg:ids instead.")
  (ids m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IdxList>) ostream)
  "Serializes a message object of type '<IdxList>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'ids))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    ))
   (cl:slot-value msg 'ids))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IdxList>) istream)
  "Deserializes a message object of type '<IdxList>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'ids) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'ids)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IdxList>)))
  "Returns string type for a message object of type '<IdxList>"
  "plan_env_msgs/IdxList")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IdxList)))
  "Returns string type for a message object of type 'IdxList"
  "plan_env_msgs/IdxList")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IdxList>)))
  "Returns md5sum for a message object of type '<IdxList>"
  "4f22efebf407aadba2ecc69df353d113")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IdxList)))
  "Returns md5sum for a message object of type 'IdxList"
  "4f22efebf407aadba2ecc69df353d113")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IdxList>)))
  "Returns full string definition for message of type '<IdxList>"
  (cl:format cl:nil "int32[] ids~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IdxList)))
  "Returns full string definition for message of type 'IdxList"
  (cl:format cl:nil "int32[] ids~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IdxList>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'ids) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IdxList>))
  "Converts a ROS message object to a list"
  (cl:list 'IdxList
    (cl:cons ':ids (ids msg))
))
