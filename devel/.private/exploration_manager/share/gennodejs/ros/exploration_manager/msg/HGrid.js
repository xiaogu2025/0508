// Auto-generated. Do not edit!

// (in-package exploration_manager.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class HGrid {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.stamp = null;
      this.points1 = null;
      this.points2 = null;
    }
    else {
      if (initObj.hasOwnProperty('stamp')) {
        this.stamp = initObj.stamp
      }
      else {
        this.stamp = 0.0;
      }
      if (initObj.hasOwnProperty('points1')) {
        this.points1 = initObj.points1
      }
      else {
        this.points1 = [];
      }
      if (initObj.hasOwnProperty('points2')) {
        this.points2 = initObj.points2
      }
      else {
        this.points2 = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type HGrid
    // Serialize message field [stamp]
    bufferOffset = _serializer.float64(obj.stamp, buffer, bufferOffset);
    // Serialize message field [points1]
    // Serialize the length for message field [points1]
    bufferOffset = _serializer.uint32(obj.points1.length, buffer, bufferOffset);
    obj.points1.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [points2]
    // Serialize the length for message field [points2]
    bufferOffset = _serializer.uint32(obj.points2.length, buffer, bufferOffset);
    obj.points2.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type HGrid
    let len;
    let data = new HGrid(null);
    // Deserialize message field [stamp]
    data.stamp = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [points1]
    // Deserialize array length for message field [points1]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points1 = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points1[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [points2]
    // Deserialize array length for message field [points2]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.points2 = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.points2[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 24 * object.points1.length;
    length += 24 * object.points2.length;
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'exploration_manager/HGrid';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3b4c53f50ed104410c54e07de27d9dc1';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    float64 stamp
    geometry_msgs/Point[] points1
    geometry_msgs/Point[] points2
    ================================================================================
    MSG: geometry_msgs/Point
    # This contains the position of a point in free space
    float64 x
    float64 y
    float64 z
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new HGrid(null);
    if (msg.stamp !== undefined) {
      resolved.stamp = msg.stamp;
    }
    else {
      resolved.stamp = 0.0
    }

    if (msg.points1 !== undefined) {
      resolved.points1 = new Array(msg.points1.length);
      for (let i = 0; i < resolved.points1.length; ++i) {
        resolved.points1[i] = geometry_msgs.msg.Point.Resolve(msg.points1[i]);
      }
    }
    else {
      resolved.points1 = []
    }

    if (msg.points2 !== undefined) {
      resolved.points2 = new Array(msg.points2.length);
      for (let i = 0; i < resolved.points2.length; ++i) {
        resolved.points2[i] = geometry_msgs.msg.Point.Resolve(msg.points2[i]);
      }
    }
    else {
      resolved.points2 = []
    }

    return resolved;
    }
};

module.exports = HGrid;
