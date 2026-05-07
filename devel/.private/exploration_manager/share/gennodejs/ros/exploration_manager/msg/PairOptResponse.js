// Auto-generated. Do not edit!

// (in-package exploration_manager.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class PairOptResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.from_drone_id = null;
      this.to_drone_id = null;
      this.status = null;
      this.stamp = null;
    }
    else {
      if (initObj.hasOwnProperty('from_drone_id')) {
        this.from_drone_id = initObj.from_drone_id
      }
      else {
        this.from_drone_id = 0;
      }
      if (initObj.hasOwnProperty('to_drone_id')) {
        this.to_drone_id = initObj.to_drone_id
      }
      else {
        this.to_drone_id = 0;
      }
      if (initObj.hasOwnProperty('status')) {
        this.status = initObj.status
      }
      else {
        this.status = 0;
      }
      if (initObj.hasOwnProperty('stamp')) {
        this.stamp = initObj.stamp
      }
      else {
        this.stamp = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type PairOptResponse
    // Serialize message field [from_drone_id]
    bufferOffset = _serializer.int32(obj.from_drone_id, buffer, bufferOffset);
    // Serialize message field [to_drone_id]
    bufferOffset = _serializer.int32(obj.to_drone_id, buffer, bufferOffset);
    // Serialize message field [status]
    bufferOffset = _serializer.int32(obj.status, buffer, bufferOffset);
    // Serialize message field [stamp]
    bufferOffset = _serializer.float64(obj.stamp, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type PairOptResponse
    let len;
    let data = new PairOptResponse(null);
    // Deserialize message field [from_drone_id]
    data.from_drone_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [to_drone_id]
    data.to_drone_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [status]
    data.status = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [stamp]
    data.stamp = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 20;
  }

  static datatype() {
    // Returns string type for a message object
    return 'exploration_manager/PairOptResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '17778d18292b1daf26721edbd91a3ac7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    # Success or failure due to inconsistent views
    int32 from_drone_id
    int32 to_drone_id
    int32 status 
    float64 stamp
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new PairOptResponse(null);
    if (msg.from_drone_id !== undefined) {
      resolved.from_drone_id = msg.from_drone_id;
    }
    else {
      resolved.from_drone_id = 0
    }

    if (msg.to_drone_id !== undefined) {
      resolved.to_drone_id = msg.to_drone_id;
    }
    else {
      resolved.to_drone_id = 0
    }

    if (msg.status !== undefined) {
      resolved.status = msg.status;
    }
    else {
      resolved.status = 0
    }

    if (msg.stamp !== undefined) {
      resolved.stamp = msg.stamp;
    }
    else {
      resolved.stamp = 0.0
    }

    return resolved;
    }
};

module.exports = PairOptResponse;
