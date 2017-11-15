declare X0 X1 Y1 in 
thread 
   local Y0 Y2 Y3 in 
      {Browse [Y0 Y1 Y2 Y3]}  
      Y0 = Y1
      Y1 = Y2
      Y2 = Y0
      {Browse completed}
   end 
end 
{Browse [X0 X1 X2 X3]}
