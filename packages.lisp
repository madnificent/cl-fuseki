
(defpackage :cl-fuseki
  (:nicknames :fuseki)
  (:shadow :delete)
  (:use :cl :drakma :cl-ppcre :jsown)
  (:export :fuseki-server :fuseki-repository
           :name
           :query :long-query
           :update :long-update
           :ask
           :add-prefix :rm-prefix :get-prefix-alist :get-prefix
           :insert :delete
           :*log-queries-p* :with-query-logging :without-query-logging))

(defpackage :cl-fuseki-user
  (:nicknames :fuseki-user)
  (:shadowing-import-from :fuseki :delete)
  (:use :cl :cl-fuseki :jsown))
