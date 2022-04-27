
(cl:in-package :asdf)

(defsystem "aro_msgs-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
)
  :components ((:file "_package")
    (:file "GenerateFrontier" :depends-on ("_package_GenerateFrontier"))
    (:file "_package_GenerateFrontier" :depends-on ("_package"))
    (:file "PlanPath" :depends-on ("_package_PlanPath"))
    (:file "_package_PlanPath" :depends-on ("_package"))
  ))