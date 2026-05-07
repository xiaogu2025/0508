; Auto-generated. Do not edit!


(cl:in-package exploration_manager-msg)


;//! \htmlinclude PairOptResponse.msg.html

(cl:defclass <PairOptResponse> (roslisp-msg-protocol:ros-message)
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
   (status
    :reader status
    :initarg :status
    :type cl:integer
    :initform 0)
   (stamp
    :reader stamp
    :initarg :stamp
    :type cl:float
    :initform 0.0))
)

(cl:defclass PairOptResponse (<PairOptResponse>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PairOptResponse>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PairOptResponse)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exploration_manager-msg:<PairOptResponse> is deprecated: use exploration_manager-msg:PairOptResponse instead.")))

(cl:ensure-generic-function 'from_drone_id-val :lambda-list '(m))
(cl:defmethod from_drone_id-val ((m <PairOptResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:from_drone_id-val is deprecated.  Use exploration_manager-msg:from_drone_id instead.")
  (from_drone_id m))

(cl:ensure-generic-function 'to_drone_id-val :lambda-list '(m))
(cl:defmethod to_drone_id-val ((m <PairOptResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:to_drone_id-val is deprecated.  Use exploration_manager-msg:to_drone_id instead.")
  (to_drone_id m))

(cl:ensure-generic-function 'status-val :lambda-list '(m))
(cl:defmethod status-val ((m <PairOptResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:status-val is deprecated.  Use exploration_manager-msg:status instead.")
  (status m))

(cl:ensure-generic-function 'stamp-val :lambda-list '(m))
(cl:defmethod stamp-val ((m <PairOptResponse>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exploration_manager-msg:stamp-val is deprecated.  Use exploration_manager-msg:stamp instead.")
  (stamp m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PairOptResponse>) ostream)
  "Serializes a message object of type '<PairOptResponse>"
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
  (cl:let* ((signed (cl:slot-value msg 'status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
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
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PairOptResponse>) istream)
  "Deserializes a message object of type '<PairOptResponse>"
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
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'status) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PairOptResponse>)))
  "Returns string type for a message object of type '<PairOptResponse>"
  "exploration_manager/PairOptResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PairOptResponse)))
  "Returns string type for a message object of type 'PairOptResponse"
  "exploration_manager/PairOptResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PairOptResponse>)))
  "Returns md5sum for a message object of type '<PairOptResponse>"
  "17778d18292b1daf26721edbd91a3ac7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PairOptResponse)))
  "Returns md5sum for a message object of type 'PairOptResponse"
  "17778d18292b1daf26721edbd91a3ac7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PairOptResponse>)))
  "Returns full string definition for message of type '<PairOptResponse>"
  (cl:format cl:nil "~%# Success or failure due to inconsistent views~%int32 from_drone_id~%int32 to_drone_id~%int32 status ~%float64 stamp~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PairOptResponse)))
  "Returns full string definition for message of type 'PairOptResponse"
  (cl:format cl:nil "~%# Success or failure due to inconsistent views~%int32 from_drone_id~%int32 to_drone_id~%int32 status ~%float64 stamp~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PairOptResponse>))
  (cl:+ 0
     4
     4
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PairOptResponse>))
  "Converts a ROS message object to a list"
  (cl:list 'PairOptResponse
    (cl:cons ':from_drone_id (from_drone_id msg))
    (cl:cons ':to_drone_id (to_drone_id msg))
    (cl:cons ':status (status msg))
    (cl:cons ':stamp (stamp msg))
))
