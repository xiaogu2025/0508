// Auto-generated. Do not edit!

// (in-package plan_env_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class ChunkData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.from_drone_id = null;
      this.to_drone_id = null;
      this.chunk_drone_id = null;
      this.voxel_adrs = null;
      this.voxel_occ_ = null;
      this.idx = null;
      this.latest_idx = null;
      this.pos_x = null;
      this.pos_y = null;
      this.pos_z = null;
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
      if (initObj.hasOwnProperty('chunk_drone_id')) {
        this.chunk_drone_id = initObj.chunk_drone_id
      }
      else {
        this.chunk_drone_id = 0;
      }
      if (initObj.hasOwnProperty('voxel_adrs')) {
        this.voxel_adrs = initObj.voxel_adrs
      }
      else {
        this.voxel_adrs = [];
      }
      if (initObj.hasOwnProperty('voxel_occ_')) {
        this.voxel_occ_ = initObj.voxel_occ_
      }
      else {
        this.voxel_occ_ = [];
      }
      if (initObj.hasOwnProperty('idx')) {
        this.idx = initObj.idx
      }
      else {
        this.idx = 0;
      }
      if (initObj.hasOwnProperty('latest_idx')) {
        this.latest_idx = initObj.latest_idx
      }
      else {
        this.latest_idx = 0;
      }
      if (initObj.hasOwnProperty('pos_x')) {
        this.pos_x = initObj.pos_x
      }
      else {
        this.pos_x = 0.0;
      }
      if (initObj.hasOwnProperty('pos_y')) {
        this.pos_y = initObj.pos_y
      }
      else {
        this.pos_y = 0.0;
      }
      if (initObj.hasOwnProperty('pos_z')) {
        this.pos_z = initObj.pos_z
      }
      else {
        this.pos_z = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ChunkData
    // Serialize message field [from_drone_id]
    bufferOffset = _serializer.int32(obj.from_drone_id, buffer, bufferOffset);
    // Serialize message field [to_drone_id]
    bufferOffset = _serializer.int32(obj.to_drone_id, buffer, bufferOffset);
    // Serialize message field [chunk_drone_id]
    bufferOffset = _serializer.int32(obj.chunk_drone_id, buffer, bufferOffset);
    // Serialize message field [voxel_adrs]
    bufferOffset = _arraySerializer.uint32(obj.voxel_adrs, buffer, bufferOffset, null);
    // Serialize message field [voxel_occ_]
    bufferOffset = _arraySerializer.uint8(obj.voxel_occ_, buffer, bufferOffset, null);
    // Serialize message field [idx]
    bufferOffset = _serializer.uint32(obj.idx, buffer, bufferOffset);
    // Serialize message field [latest_idx]
    bufferOffset = _serializer.uint32(obj.latest_idx, buffer, bufferOffset);
    // Serialize message field [pos_x]
    bufferOffset = _serializer.float64(obj.pos_x, buffer, bufferOffset);
    // Serialize message field [pos_y]
    bufferOffset = _serializer.float64(obj.pos_y, buffer, bufferOffset);
    // Serialize message field [pos_z]
    bufferOffset = _serializer.float64(obj.pos_z, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ChunkData
    let len;
    let data = new ChunkData(null);
    // Deserialize message field [from_drone_id]
    data.from_drone_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [to_drone_id]
    data.to_drone_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [chunk_drone_id]
    data.chunk_drone_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [voxel_adrs]
    data.voxel_adrs = _arrayDeserializer.uint32(buffer, bufferOffset, null)
    // Deserialize message field [voxel_occ_]
    data.voxel_occ_ = _arrayDeserializer.uint8(buffer, bufferOffset, null)
    // Deserialize message field [idx]
    data.idx = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [latest_idx]
    data.latest_idx = _deserializer.uint32(buffer, bufferOffset);
    // Deserialize message field [pos_x]
    data.pos_x = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [pos_y]
    data.pos_y = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [pos_z]
    data.pos_z = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += 4 * object.voxel_adrs.length;
    length += object.voxel_occ_.length;
    return length + 52;
  }

  static datatype() {
    // Returns string type for a message object
    return 'plan_env_msgs/ChunkData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'fb59f4568c081139a74132003cbc6f30';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 from_drone_id
    int32 to_drone_id
    int32 chunk_drone_id
    
    uint32[] voxel_adrs
    uint8[] voxel_occ_
    uint32 idx
    
    # Simulate swarm communication
    uint32 latest_idx
    float64 pos_x
    float64 pos_y
    float64 pos_z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ChunkData(null);
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

    if (msg.chunk_drone_id !== undefined) {
      resolved.chunk_drone_id = msg.chunk_drone_id;
    }
    else {
      resolved.chunk_drone_id = 0
    }

    if (msg.voxel_adrs !== undefined) {
      resolved.voxel_adrs = msg.voxel_adrs;
    }
    else {
      resolved.voxel_adrs = []
    }

    if (msg.voxel_occ_ !== undefined) {
      resolved.voxel_occ_ = msg.voxel_occ_;
    }
    else {
      resolved.voxel_occ_ = []
    }

    if (msg.idx !== undefined) {
      resolved.idx = msg.idx;
    }
    else {
      resolved.idx = 0
    }

    if (msg.latest_idx !== undefined) {
      resolved.latest_idx = msg.latest_idx;
    }
    else {
      resolved.latest_idx = 0
    }

    if (msg.pos_x !== undefined) {
      resolved.pos_x = msg.pos_x;
    }
    else {
      resolved.pos_x = 0.0
    }

    if (msg.pos_y !== undefined) {
      resolved.pos_y = msg.pos_y;
    }
    else {
      resolved.pos_y = 0.0
    }

    if (msg.pos_z !== undefined) {
      resolved.pos_z = msg.pos_z;
    }
    else {
      resolved.pos_z = 0.0
    }

    return resolved;
    }
};

module.exports = ChunkData;
