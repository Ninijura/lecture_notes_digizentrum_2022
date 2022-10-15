
let test_exp candidate =
   (candidate 0 1 = 0)
   && (candidate 1 0 = 1)
   && (candidate 2 8 = 256)
   && (candidate (-2) 5 = (-32))
;;

exception Exponent_unter_null of int;;

let (^) x y = 
  let rec visit y' acc =
	if y' = 0 
	   then acc
	else visit (y'-1) (acc*x)
  in if y < 0 
	 then raise (Exponent_unter_null y)
	 else visit y 1;;

let execute_test_exp = test_exp (^);;
