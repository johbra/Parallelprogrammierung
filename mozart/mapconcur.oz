declare Map
fun {Map Xs F}
   case Xs
   of nil then nil
   [] X|Xr then thread {F X} end |{Map Xr F}
   end 
end

declare 
F X Y Z
{Browse thread {Map X F} end}

X = 1|2|Y
fun {F X} X*X end

Y = 3|Z
Z = nil