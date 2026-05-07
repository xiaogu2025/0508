; Auto-generated. Do not edit!


(cl:in-package plan_env_msgs-msg)


;//! \htmlinclude ChunkData.msg.html

(cl:defclass <ChunkData> (roslisp-msg-protocol:ros-message)
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
   (chunk_drone_id
    :reader chunk_drone_id
    :initarg :chunk_drone_id
    :type cl:integer
    :initform 0)
   (voxel_adrs
    :reader voxel_adrs
    :initarg :voxel_adrs
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0))
   (voxel_occ_
    :reader voxel_occ_
    :initarg :voxel_occ_
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0))
   (idx
    :reader idx
    :initarg :idx
    :type cl:integer
    :initform 0)
   (latest_idx
    :reader latest_idx
    :initarg :latest_idx
    :type cl:integer
    :initform 0)
   (pos_x
    :reader pos_x
    :initarg :pos_x
    :type cl:float
    :initform 0.0)
   (pos_y
    :reader pos_y
    :initarg :pos_y
    :type cl:float
    :initform 0.0)
   (pos_z
    :reader pos_z
    :initarg :pos_z
    :type cl:float
    :initform 0.0))
)

(cl:defclass ChunkData (<ChunkData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ChunkData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ChunkData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name plan_env_msgs-msg:<ChunkData> is deprecated: use plan_env_msgs-msg:ChunkData instead.")))

(cl:ensure-generic-function 'from_drone_id-val :lambda-list '(m))
(cl:defmethod from_drone_id-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:from_drone_id-val is deprecated.  Use plan_env_msgs-msg:from_drone_id instead.")
  (from_drone_id m))

(cl:ensure-generic-function 'to_drone_id-val :lambda-list '(m))
(cl:defmethod to_drone_id-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:to_drone_id-val is deprecated.  Use plan_env_msgs-msg:to_drone_id instead.")
  (to_drone_id m))

(cl:ensure-generic-function 'chunk_drone_id-val :lambda-list '(m))
(cl:defmethod chunk_drone_id-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:chunk_drone_id-val is deprecated.  Use plan_env_msgs-msg:chunk_drone_id instead.")
  (chunk_drone_id m))

(cl:ensure-generic-function 'voxel_adrs-val :lambda-list '(m))
(cl:defmethod voxel_adrs-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:voxel_adrs-val is deprecated.  Use plan_env_msgs-msg:voxel_adrs instead.")
  (voxel_adrs m))

(cl:ensure-generic-function 'voxel_occ_-val :lambda-list '(m))
(cl:defmethod voxel_occ_-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:voxel_occ_-val is deprecated.  Use plan_env_msgs-msg:voxel_occ_ instead.")
  (voxel_occ_ m))

(cl:ensure-generic-function 'idx-val :lambda-list '(m))
(cl:defmethod idx-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:idx-val is deprecated.  Use plan_env_msgs-msg:idx instead.")
  (idx m))

(cl:ensure-generic-function 'latest_idx-val :lambda-list '(m))
(cl:defmethod latest_idx-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:latest_idx-val is deprecated.  Use plan_env_msgs-msg:latest_idx instead.")
  (latest_idx m))

(cl:ensure-generic-function 'pos_x-val :lambda-list '(m))
(cl:defmethod pos_x-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:pos_x-val is deprecated.  Use plan_env_msgs-msg:pos_x instead.")
  (pos_x m))

(cl:ensure-generic-function 'pos_y-val :lambda-list '(m))
(cl:defmethod pos_y-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:pos_y-val is deprecated.  Use plan_env_msgs-msg:pos_y instead.")
  (pos_y m))

(cl:ensure-generic-function 'pos_z-val :lambda-list '(m))
(cl:defmethod pos_z-val ((m <ChunkData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader plan_env_msgs-msg:pos_z-val is deprecated.  Use plan_env_msgs-msg:pos_z instead.")
  (pos_z m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ChunkData>) ostream)
  "Serializes a message object of type '<ChunkData>"
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
  (cl:let* ((signed (cl:slot-value msg 'chunk_drone_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'voxel_adrs))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) ele) ostream))
   (cl:slot-value msg 'voxel_adrs))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'voxel_occ_))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'voxel_occ_))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'idx)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'idx)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'idx)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'idx)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'latest_idx)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'latest_idx)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'latest_idx)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'latest_idx)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pos_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pos_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pos_z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ChunkData>) istream)
  "Deserializes a message object of type '<ChunkData>"
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
      (cl:setf (cl:slot-value msg 'chunk_drone_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'voxel_adrs) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'voxel_adrs)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:aref vals i)) (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'voxel_occ_) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'voxel_occ_)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'idx)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'idx)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'idx)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'idx)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'latest_idx)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'latest_idx)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'latest_idx)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'latest_idx)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_z) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ChunkData>)))
  "Returns string type for a message object of type '<ChunkData>"
  "plan_env_msgs/ChunkData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ChunkData)))
  "Returns string type for a message object of type 'ChunkData"
  "plan_env_msgs/ChunkData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ChunkData>)))
  "Returns md5sum for a message object of type '<ChunkData>"
  "fb59f4568c081139a74132003cbc6f30")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ChunkData)))
  "Returns md5sum for a message object of type 'ChunkData"
  "fb59f4568c081139a74132003cbc6f30")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ChunkData>)))
  "Returns full string definition for message of type '<ChunkData>"
  (cl:format cl:nil "int32 from_drone_id~%int32 to_drone_id~%int32 chunk_drone_id~%~%uint32[] voxel_adrs~%uint8[] voxel_occ_~%uint32 idx~%~%# Simulate swarm communication~%uint32 latest_idx~%float64 pos_x~%float64 pos_y~%float64 pos_z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ChunkData)))
  "Returns full string definition for message of type 'ChunkData"
  (cl:format cl:nil "int32 from_drone_id~%int32 to_drone_id~%int32 chunk_drone_id~%~%uint32[] voxel_adrs~%uint8[] voxel_occ_~%uint32 idx~%~%# Simulate swarm communication~%uint32 latest_idx~%float64 pos_x~%float64 pos_y~%float64 pos_z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ChunkData>))
  (cl:+ 0
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'voxel_adrs) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'voxel_occ_) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     4
     4
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ChunkData>))
  "Converts a ROS message object to a list"
  (cl:list 'ChunkData
    (cl:cons ':from_drone_id (from_drone_id msg))
    (cl:cons ':to_drone_id (to_drone_id msg))
    (cl:cons ':chunk_drone_id (chunk_drone_id msg))
    (cl:cons ':voxel_adrs (voxel_adrs msg))
    (cl:cons ':voxel_occ_ (voxel_occ_ msg))
    (cl:cons ':idx (idx msg))
    (cl:cons ':latest_idx (latest_idx msg))
    (cl:cons ':pos_x (pos_x msg))
    (cl:cons ':pos_y (pos_y msg))
    (cl:cons ':pos_z (pos_z msg))
))
