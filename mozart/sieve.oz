declare Sieve Generate

fun {Generate N Limit} 
   if N=<Limit then 
   N | {Generate N+1 Limit} 
else nil end 
end 

fun {Sieve Xs}
   case Xs
   of nil then nil
   [] X|Xr then Ys in
   thread Ys = {Filter Xr fun {$ Y} Y mod X \= 0 end} end
   X | {Sieve Ys}
   end
end

local Xs Ys in
   thread Xs =  {Generate 2 100000} end
   thread Ys = {Sieve Xs} end
   thread for Y in Ys do {Show Y} end end
end