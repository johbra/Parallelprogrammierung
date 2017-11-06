declare X0 X1 X2 X3 in 
thread 
   local Y0 Y1 Y2 Y3 in 
      {Browse [Y0 Y1 Y2 Y3]}  
      Y0 = X0+1
      Y1 = X1+Y0
      Y2 = X2+Y1
      Y3 = X3+Y2
      {Browse completed}
   end 
end 
{Browse [X0 X1 X2 X3]}
X0 = 0
X1 = 1
X2 = 2
X3 = 3
