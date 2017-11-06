declare Gen Xs Ys

fun {Gen L H}
   {Delay 200}
   if L>H then nil else L |{Gen L+1 H} end
end

Xs={Gen 1 10} 
Ys={Map Xs fun {$ X} X*X end}
{Browse Ys}