;; Auto-generated. Do not edit!


(when (boundp 'plan_env_msgs::ChunkData)
  (if (not (find-package "PLAN_ENV_MSGS"))
    (make-package "PLAN_ENV_MSGS"))
  (shadow 'ChunkData (find-package "PLAN_ENV_MSGS")))
(unless (find-package "PLAN_ENV_MSGS::CHUNKDATA")
  (make-package "PLAN_ENV_MSGS::CHUNKDATA"))

(in-package "ROS")
;;//! \htmlinclude ChunkData.msg.html


(defclass plan_env_msgs::ChunkData
  :super ros::object
  :slots (_from_drone_id _to_drone_id _chunk_drone_id _voxel_adrs _voxel_occ_ _idx _latest_idx _pos_x _pos_y _pos_z ))

(defmethod plan_env_msgs::ChunkData
  (:init
   (&key
    ((:from_drone_id __from_drone_id) 0)
    ((:to_drone_id __to_drone_id) 0)
    ((:chunk_drone_id __chunk_drone_id) 0)
    ((:voxel_adrs __voxel_adrs) (make-array 0 :initial-element 0 :element-type :integer))
    ((:voxel_occ_ __voxel_occ_) (make-array 0 :initial-element 0 :element-type :char))
    ((:idx __idx) 0)
    ((:latest_idx __latest_idx) 0)
    ((:pos_x __pos_x) 0.0)
    ((:pos_y __pos_y) 0.0)
    ((:pos_z __pos_z) 0.0)
    )
   (send-super :init)
   (setq _from_drone_id (round __from_drone_id))
   (setq _to_drone_id (round __to_drone_id))
   (setq _chunk_drone_id (round __chunk_drone_id))
   (setq _voxel_adrs __voxel_adrs)
   (setq _voxel_occ_ __voxel_occ_)
   (setq _idx (round __idx))
   (setq _latest_idx (round __latest_idx))
   (setq _pos_x (float __pos_x))
   (setq _pos_y (float __pos_y))
   (setq _pos_z (float __pos_z))
   self)
  (:from_drone_id
   (&optional __from_drone_id)
   (if __from_drone_id (setq _from_drone_id __from_drone_id)) _from_drone_id)
  (:to_drone_id
   (&optional __to_drone_id)
   (if __to_drone_id (setq _to_drone_id __to_drone_id)) _to_drone_id)
  (:chunk_drone_id
   (&optional __chunk_drone_id)
   (if __chunk_drone_id (setq _chunk_drone_id __chunk_drone_id)) _chunk_drone_id)
  (:voxel_adrs
   (&optional __voxel_adrs)
   (if __voxel_adrs (setq _voxel_adrs __voxel_adrs)) _voxel_adrs)
  (:voxel_occ_
   (&optional __voxel_occ_)
   (if __voxel_occ_ (setq _voxel_occ_ __voxel_occ_)) _voxel_occ_)
  (:idx
   (&optional __idx)
   (if __idx (setq _idx __idx)) _idx)
  (:latest_idx
   (&optional __latest_idx)
   (if __latest_idx (setq _latest_idx __latest_idx)) _latest_idx)
  (:pos_x
   (&optional __pos_x)
   (if __pos_x (setq _pos_x __pos_x)) _pos_x)
  (:pos_y
   (&optional __pos_y)
   (if __pos_y (setq _pos_y __pos_y)) _pos_y)
  (:pos_z
   (&optional __pos_z)
   (if __pos_z (setq _pos_z __pos_z)) _pos_z)
  (:serialization-length
   ()
   (+
    ;; int32 _from_drone_id
    4
    ;; int32 _to_drone_id
    4
    ;; int32 _chunk_drone_id
    4
    ;; uint32[] _voxel_adrs
    (* 4    (length _voxel_adrs)) 4
    ;; uint8[] _voxel_occ_
    (* 1    (length _voxel_occ_)) 4
    ;; uint32 _idx
    4
    ;; uint32 _latest_idx
    4
    ;; float64 _pos_x
    8
    ;; float64 _pos_y
    8
    ;; float64 _pos_z
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _from_drone_id
       (write-long _from_drone_id s)
     ;; int32 _to_drone_id
       (write-long _to_drone_id s)
     ;; int32 _chunk_drone_id
       (write-long _chunk_drone_id s)
     ;; uint32[] _voxel_adrs
     (write-long (length _voxel_adrs) s)
     (dotimes (i (length _voxel_adrs))
       (write-long (elt _voxel_adrs i) s)
       )
     ;; uint8[] _voxel_occ_
     (write-long (length _voxel_occ_) s)
     (princ _voxel_occ_ s)
     ;; uint32 _idx
       (write-long _idx s)
     ;; uint32 _latest_idx
       (write-long _latest_idx s)
     ;; float64 _pos_x
       (sys::poke _pos_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pos_y
       (sys::poke _pos_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pos_z
       (sys::poke _pos_z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _from_drone_id
     (setq _from_drone_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _to_drone_id
     (setq _to_drone_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _chunk_drone_id
     (setq _chunk_drone_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32[] _voxel_adrs
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _voxel_adrs (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _voxel_adrs i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;; uint8[] _voxel_occ_
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _voxel_occ_ (make-array n :element-type :char))
     (replace _voxel_occ_ buf :start2 ptr-) (incf ptr- n))
   ;; uint32 _idx
     (setq _idx (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _latest_idx
     (setq _latest_idx (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _pos_x
     (setq _pos_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pos_y
     (setq _pos_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pos_z
     (setq _pos_z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get plan_env_msgs::ChunkData :md5sum-) "fb59f4568c081139a74132003cbc6f30")
(setf (get plan_env_msgs::ChunkData :datatype-) "plan_env_msgs/ChunkData")
(setf (get plan_env_msgs::ChunkData :definition-)
      "int32 from_drone_id
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
")



(provide :plan_env_msgs/ChunkData "fb59f4568c081139a74132003cbc6f30")


