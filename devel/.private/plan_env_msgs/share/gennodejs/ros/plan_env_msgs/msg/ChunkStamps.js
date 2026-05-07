// Auto-generated. Do not edit!

// (in-package plan_env_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let IdxList = require('./IdxList.js');

//-----------------------------------------------------------

class ChunkStamps {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.from_drone_id = null;
      this.idx_lists = null;
      this.time = null;
    }
    else {
      if (initObj.hasOwnProperty('from_drone_id')) {
        this.from_drone_id = initObj.from_drone_id
      }
      else {
        this.from_drone_id = 0;
      }
      if (initObj.hasOwnProperty('idx_lists')) {
        this.idx_lists = initObj.idx_lists
      }
      else {
        this.idx_lists = [];
      }
      if (initObj.hasOwnProperty('time')) {
        this.time = initObj.time
      }
      else {
        this.time = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ChunkStamps
    // Serialize message field [from_drone_id]
    bufferOffset = _serializer.int32(obj.from_drone_id, buffer, bufferOffset);
    // Serialize message field [idx_lists]
    // Serialize the length for message field [idx_lists]
    bufferOffset = _serializer.uint32(obj.idx_lists.length, buffer, bufferOffset);
    obj.idx_lists.forEach((val) => {
      bufferOffset = IdxList.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [time]
    bufferOffset = _serializer.float64(obj.time, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ChunkStamps
    let len;
    let data = new ChunkStamps(null);
    // Deserialize message field [from_drone_id]
    data.from_drone_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [idx_lists]
    // Deserialize array length for message field [idx_lists]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.idx_lists = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.idx_lists[i] = IdxList.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [time]
    data.time = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.idx_lists.forEach((val) => {
      length += IdxList.getMessageSize(val);
    });
    return length + 16;
  }

  static datatype() {
    // Returns string type for a message object
    return 'plan_env_msgs/ChunkStamps';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '4649dd6de5a06d0faa920a6802067e3f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    int32 from_drone_id
    IdxList[] idx_lists
    float64 time
    ================================================================================
    MSG: plan_env_msgs/IdxList
    int32[] ids
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ChunkStamps(null);
    if (msg.from_drone_id !== undefined) {
      resolved.from_drone_id = msg.from_drone_id;
    }
    else {
      resolved.from_drone_id = 0
    }

    if (msg.idx_lists !== undefined) {
      resolved.idx_lists = new Array(msg.idx_lists.length);
      for (let i = 0; i < resolved.idx_lists.length; ++i) {
        resolved.idx_lists[i] = IdxList.Resolve(msg.idx_lists[i]);
      }
    }
    else {
      resolved.idx_lists = []
    }

    if (msg.time !== undefined) {
      resolved.time = msg.time;
    }
    else {
      resolved.time = 0.0
    }

    return resolved;
    }
};

module.exports = ChunkStamps;
