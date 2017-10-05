phils := Philosophers new.

(phils philosophers at: 1) process resume

(phils philosophers at: 1) process terminate

phils philosophers do: [:phil | phil process resume]

phils philosophers do: [:phil | phil process terminate]