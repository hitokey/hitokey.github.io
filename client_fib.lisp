;; file: client_fib.lisp
(ql:quickload :hunchentoot)


(defparameter *web* (make-instance 'hunchentoot:easy-acceptor
				       :port 4242))


(defun fib(n &optional (prev 1) (acc 0))
    (cond ((> n 50) "limite break, because we limit cost")
	  ((<= n 0) acc)
	  (t (fib (- n 1) acc (+ prev acc)) )))

(defun client-name(name)
  (if (null name) "Hello, Cliente"
      (format nil "Hello, ~a!" name)))

(hunchentoot:define-easy-handler (hello :uri "/fib") (number name)
  (setf (hunchentoot:content-type*) "text/html")
  (let ((v (fib (parse-integer number))) (c (client-name name)))
    (format nil "<html><body><h1>~a<\h1><p>Fib: ~a</p></body></html>" c v)) )


(hunchentoot:start *web*)

;; user: sbcl --load client_fib.lisp
