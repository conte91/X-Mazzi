proc random { floor ceilin } {
  return [expr {$floor+int(rand()*($ceilin-$floor))}]
}
