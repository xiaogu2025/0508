// Auto-generated. Do not edit!

// (in-package lkh_mtsp_solver.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class SolveMTSPRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.prob = null;
    }
    else {
      if (initObj.hasOwnProperty('prob')) {
        this.prob = initObj.prob
      }
      else {
        this.prob = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SolveMTSPRequest
    // Serialize message field [prob]
    bufferOffset = _serializer.uint8(obj.prob, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SolveMTSPRequest
    let len;
    let data = new SolveMTSPRequest(null);
    // Deserialize message field [prob]
    data.prob = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'lkh_mtsp_solver/SolveMTSPRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ca63bb73dd5f229cb918a86ba798421f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 prob
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SolveMTSPRequest(null);
    if (msg.prob !== undefined) {
      resolved.prob = msg.prob;
    }
    else {
      resolved.prob = 0
    }

    return resolved;
    }
};

class SolveMTSPResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.empty = null;
    }
    else {
      if (initObj.hasOwnProperty('empty')) {
        this.empty = initObj.empty
      }
      else {
        this.empty = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type SolveMTSPResponse
    // Serialize message field [empty]
    bufferOffset = _serializer.uint8(obj.empty, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type SolveMTSPResponse
    let len;
    let data = new SolveMTSPResponse(null);
    // Deserialize message field [empty]
    data.empty = _deserializer.uint8(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 1;
  }

  static datatype() {
    // Returns string type for a service object
    return 'lkh_mtsp_solver/SolveMTSPResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3f908f4c332be245b1a763195cf157ba';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    uint8 empty
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new SolveMTSPResponse(null);
    if (msg.empty !== undefined) {
      resolved.empty = msg.empty;
    }
    else {
      resolved.empty = 0
    }

    return resolved;
    }
};

module.exports = {
  Request: SolveMTSPRequest,
  Response: SolveMTSPResponse,
  md5sum() { return '5b562e6076c8d155d3ad455cb6275b9e'; },
  datatype() { return 'lkh_mtsp_solver/SolveMTSP'; }
};
