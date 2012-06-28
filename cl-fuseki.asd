
(asdf:defsystem :cl-fuseki
  :name "cl-fuseki"
  :author "Aad Versteden <madnificent@gmail.com>"
  :version "0.0.1"
  :maintainer "Aad Versteden <madnificent@gmail.com>"
  :licence "MIT"
  :description "Library with basic support for Fuski through its web interface."
  :serial t
  :depends-on (drakma cl-ppcre jsown)
  :components ((:file "packages")
               (:file "cl-fuseki")))
