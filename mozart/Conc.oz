declare Conc
local
   proc {Conc1 Ps I O}
      case Ps of P|Pr then 
         M in 
         thread {P} M = I end
         {Conc1 Pr M O}
      [] nil then O = I
      end
   end
in
   proc {Conc Ps} 
      X in {Conc1 Ps unit X}
      {Wait X}
   end
end

local
   proc {Ping N}
      for I in 1 .. N do
         {Delay 500} {Browse ping}
      end
      {Browse 'ping terminate'}
   end
   proc {Pong N}
      for I in 1 .. N do
         {Delay 600} {Browse pong}
      end
      {Browse 'pong terminate'}
   end
in {Browse 'game started'}
   {Conc 
    [ proc {$} {Ping 10} end
      proc {$} {Pong 10} end  ]}
   {Browse 'game tarminated'}
end