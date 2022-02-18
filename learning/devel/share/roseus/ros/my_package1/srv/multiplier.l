;; Auto-generated. Do not edit!


(when (boundp 'my_package1::multiplier)
  (if (not (find-package "MY_PACKAGE1"))
    (make-package "MY_PACKAGE1"))
  (shadow 'multiplier (find-package "MY_PACKAGE1")))
(unless (find-package "MY_PACKAGE1::MULTIPLIER")
  (make-package "MY_PACKAGE1::MULTIPLIER"))
(unless (find-package "MY_PACKAGE1::MULTIPLIERREQUEST")
  (make-package "MY_PACKAGE1::MULTIPLIERREQUEST"))
(unless (find-package "MY_PACKAGE1::MULTIPLIERRESPONSE")
  (make-package "MY_PACKAGE1::MULTIPLIERRESPONSE"))

(in-package "ROS")





(defclass my_package1::multiplierRequest
  :super ros::object
  :slots (_a _b ))

(defmethod my_package1::multiplierRequest
  (:init
   (&key
    ((:a __a) 0)
    ((:b __b) 0)
    )
   (send-super :init)
   (setq _a (round __a))
   (setq _b (round __b))
   self)
  (:a
   (&optional __a)
   (if __a (setq _a __a)) _a)
  (:b
   (&optional __b)
   (if __b (setq _b __b)) _b)
  (:serialization-length
   ()
   (+
    ;; int32 _a
    4
    ;; int32 _b
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _a
       (write-long _a s)
     ;; int32 _b
       (write-long _b s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _a
     (setq _a (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _b
     (setq _b (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass my_package1::multiplierResponse
  :super ros::object
  :slots (_result ))

(defmethod my_package1::multiplierResponse
  (:init
   (&key
    ((:result __result) 0)
    )
   (send-super :init)
   (setq _result (round __result))
   self)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; int32 _result
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _result
       (write-long _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _result
     (setq _result (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass my_package1::multiplier
  :super ros::object
  :slots ())

(setf (get my_package1::multiplier :md5sum-) "a7d7d7065d45755acef7d4dcf908162a")
(setf (get my_package1::multiplier :datatype-) "my_package1/multiplier")
(setf (get my_package1::multiplier :request) my_package1::multiplierRequest)
(setf (get my_package1::multiplier :response) my_package1::multiplierResponse)

(defmethod my_package1::multiplierRequest
  (:response () (instance my_package1::multiplierResponse :init)))

(setf (get my_package1::multiplierRequest :md5sum-) "a7d7d7065d45755acef7d4dcf908162a")
(setf (get my_package1::multiplierRequest :datatype-) "my_package1/multiplierRequest")
(setf (get my_package1::multiplierRequest :definition-)
      "int32 a
int32 b
---
int32 result
")

(setf (get my_package1::multiplierResponse :md5sum-) "a7d7d7065d45755acef7d4dcf908162a")
(setf (get my_package1::multiplierResponse :datatype-) "my_package1/multiplierResponse")
(setf (get my_package1::multiplierResponse :definition-)
      "int32 a
int32 b
---
int32 result
")



(provide :my_package1/multiplier "a7d7d7065d45755acef7d4dcf908162a")


