(defun nrsqrt (x delta)
  (loop :for y = 1.0 :then (/ (+ y (/ x y)) 2.0)
	:until (<= (abs (- x (* y y))) delta)
	:finally (return y)))
