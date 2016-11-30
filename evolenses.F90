program evolenses

  use functions
  use constants

  real(dp) :: vecX(1:10)
  real(dp) :: result

  vecX=0
  call secondMoment(vecX,result)
  print *, result

end program
