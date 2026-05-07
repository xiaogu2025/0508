; Auto-generated. Do not edit!


(cl:in-package lkh_tsp_solver-srv)


;//! \htmlinclude SolveTSP-request.msg.html

(cl:defclass <SolveTSP-request> (roslisp-msg-protocol:ros-message)
  ((prob
    :reader prob
    :initarg :prob
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SolveTSP-request (<SolveTSP-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SolveTSP-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SolveTSP-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lkh_tsp_solver-srv:<SolveTSP-request> is deprecated: use lkh_tsp_solver-srv:SolveTSP-request instead.")))

(cl:ensure-generic-function 'prob-val :lambda-list '(m))
(cl:defmethod prob-val ((m <SolveTSP-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lkh_tsp_solver-srv:prob-val is deprecated.  Use lkh_tsp_solver-srv:prob instead.")
  (prob m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SolveTSP-request>) ostream)
  "Serializes a message object of type '<SolveTSP-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'prob)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SolveTSP-request>) istream)
  "Deserializes a message object of type '<SolveTSP-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'prob)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SolveTSP-request>)))
  "Returns string type for a service object of type '<SolveTSP-request>"
  "lkh_tsp_solver/SolveTSPRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SolveTSP-request)))
  "Returns string type for a service object of type 'SolveTSP-request"
  "lkh_tsp_solver/SolveTSPRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SolveTSP-request>)))
  "Returns md5sum for a message object of type '<SolveTSP-request>"
  "5b562e6076c8d155d3ad455cb6275b9e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SolveTSP-request)))
  "Returns md5sum for a message object of type 'SolveTSP-request"
  "5b562e6076c8d155d3ad455cb6275b9e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SolveTSP-request>)))
  "Returns full string definition for message of type '<SolveTSP-request>"
  (cl:format cl:nil "uint8 prob~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SolveTSP-request)))
  "Returns full string definition for message of type 'SolveTSP-request"
  (cl:format cl:nil "uint8 prob~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SolveTSP-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SolveTSP-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SolveTSP-request
    (cl:cons ':prob (prob msg))
))
;//! \htmlinclude SolveTSP-response.msg.html

(cl:defclass <SolveTSP-response> (roslisp-msg-protocol:ros-message)
  ((empty
    :reader empty
    :initarg :empty
    :type cl:fixnum
    :initform 0))
)

(cl:defclass SolveTSP-response (<SolveTSP-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SolveTSP-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SolveTSP-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name lkh_tsp_solver-srv:<SolveTSP-response> is deprecated: use lkh_tsp_solver-srv:SolveTSP-response instead.")))

(cl:ensure-generic-function 'empty-val :lambda-list '(m))
(cl:defmethod empty-val ((m <SolveTSP-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader lkh_tsp_solver-srv:empty-val is deprecated.  Use lkh_tsp_solver-srv:empty instead.")
  (empty m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SolveTSP-response>) ostream)
  "Serializes a message object of type '<SolveTSP-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'empty)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SolveTSP-response>) istream)
  "Deserializes a message object of type '<SolveTSP-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'empty)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SolveTSP-response>)))
  "Returns string type for a service object of type '<SolveTSP-response>"
  "lkh_tsp_solver/SolveTSPResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SolveTSP-response)))
  "Returns string type for a service object of type 'SolveTSP-response"
  "lkh_tsp_solver/SolveTSPResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SolveTSP-response>)))
  "Returns md5sum for a message object of type '<SolveTSP-response>"
  "5b562e6076c8d155d3ad455cb6275b9e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SolveTSP-response)))
  "Returns md5sum for a message object of type 'SolveTSP-response"
  "5b562e6076c8d155d3ad455cb6275b9e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SolveTSP-response>)))
  "Returns full string definition for message of type '<SolveTSP-response>"
  (cl:format cl:nil "uint8 empty~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SolveTSP-response)))
  "Returns full string definition for message of type 'SolveTSP-response"
  (cl:format cl:nil "uint8 empty~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SolveTSP-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SolveTSP-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SolveTSP-response
    (cl:cons ':empty (empty msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SolveTSP)))
  'SolveTSP-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SolveTSP)))
  'SolveTSP-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SolveTSP)))
  "Returns string type for a service object of type '<SolveTSP>"
  "lkh_tsp_solver/SolveTSP")