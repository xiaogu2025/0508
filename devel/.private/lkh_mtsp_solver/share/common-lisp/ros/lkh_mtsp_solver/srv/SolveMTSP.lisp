; Auto-generated. Do not edit!


(cl:in-package lkh_mtsp_solver-srv)


;//! \htmlinclude SolveMTSP-request.msg.html

(cl:defclass <SolveMTSP-request> (roslisp-msg-protocol:ros-message)
  ((prob
    :reader prob
    :initarg :prob
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SolveMTSP-request (<SolveMTSP-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SolveMTSP-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SolveMTSP-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lkh_mtsp_solver-srv:<SolveMTSP-request> is deprecated: use lkh_mtsp_solver-srv:SolveMTSP-request instead.")))

(cl:ensure-generic-function 'prob-val :lambda-list '(m))
(cl:defmethod prob-val ((m <SolveMTSP-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lkh_mtsp_solver-srv:prob-val is deprecated.  Use lkh_mtsp_solver-srv:prob instead.")
  (prob m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SolveMTSP-request>) ostream)
  "Serializes a message object of type '<SolveMTSP-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'prob)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SolveMTSP-request>) istream)
  "Deserializes a message object of type '<SolveMTSP-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'prob)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SolveMTSP-request>)))
  "Returns string type for a service object of type '<SolveMTSP-request>"
  "lkh_mtsp_solver/SolveMTSPRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SolveMTSP-request)))
  "Returns string type for a service object of type 'SolveMTSP-request"
  "lkh_mtsp_solver/SolveMTSPRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SolveMTSP-request>)))
  "Returns md5sum for a message object of type '<SolveMTSP-request>"
  "5b562e6076c8d155d3ad455cb6275b9e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SolveMTSP-request)))
  "Returns md5sum for a message object of type 'SolveMTSP-request"
  "5b562e6076c8d155d3ad455cb6275b9e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SolveMTSP-request>)))
  "Returns full string definition for message of type '<SolveMTSP-request>"
  (cl:format cl:nil "uint8 prob~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SolveMTSP-request)))
  "Returns full string definition for message of type 'SolveMTSP-request"
  (cl:format cl:nil "uint8 prob~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SolveMTSP-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SolveMTSP-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SolveMTSP-request
    (cl:cons ':prob (prob msg))
))
;//! \htmlinclude SolveMTSP-response.msg.html

(cl:defclass <SolveMTSP-response> (roslisp-msg-protocol:ros-message)
  ((empty
    :reader empty
    :initarg :empty
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SolveMTSP-response (<SolveMTSP-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SolveMTSP-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SolveMTSP-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lkh_mtsp_solver-srv:<SolveMTSP-response> is deprecated: use lkh_mtsp_solver-srv:SolveMTSP-response instead.")))

(cl:ensure-generic-function 'empty-val :lambda-list '(m))
(cl:defmethod empty-val ((m <SolveMTSP-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lkh_mtsp_solver-srv:empty-val is deprecated.  Use lkh_mtsp_solver-srv:empty instead.")
  (empty m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SolveMTSP-response>) ostream)
  "Serializes a message object of type '<SolveMTSP-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'empty)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SolveMTSP-response>) istream)
  "Deserializes a message object of type '<SolveMTSP-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'empty)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SolveMTSP-response>)))
  "Returns string type for a service object of type '<SolveMTSP-response>"
  "lkh_mtsp_solver/SolveMTSPResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SolveMTSP-response)))
  "Returns string type for a service object of type 'SolveMTSP-response"
  "lkh_mtsp_solver/SolveMTSPResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SolveMTSP-response>)))
  "Returns md5sum for a message object of type '<SolveMTSP-response>"
  "5b562e6076c8d155d3ad455cb6275b9e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SolveMTSP-response)))
  "Returns md5sum for a message object of type 'SolveMTSP-response"
  "5b562e6076c8d155d3ad455cb6275b9e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SolveMTSP-response>)))
  "Returns full string definition for message of type '<SolveMTSP-response>"
  (cl:format cl:nil "uint8 empty~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SolveMTSP-response)))
  "Returns full string definition for message of type 'SolveMTSP-response"
  (cl:format cl:nil "uint8 empty~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SolveMTSP-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SolveMTSP-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SolveMTSP-response
    (cl:cons ':empty (empty msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SolveMTSP)))
  'SolveMTSP-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SolveMTSP)))
  'SolveMTSP-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SolveMTSP)))
  "Returns string type for a service object of type '<SolveMTSP>"
  "lkh_mtsp_solver/SolveMTSP")