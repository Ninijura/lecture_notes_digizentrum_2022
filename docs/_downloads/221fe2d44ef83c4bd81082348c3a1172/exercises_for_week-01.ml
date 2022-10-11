let test_exp candidate =
   (candidate 0 1 = 0)
   && (candidate 1 0 = 1)
   && (candidate 2 8 = 256)
   && (candidate (-2) 5 = (-32))
;;



let exp n e =
  let rec visit e acc =
    if e = 0
    then acc
    else visit (e-1) (acc*n)
  in visit e 1;;

let execute_test_exp = test_exp exp;;
