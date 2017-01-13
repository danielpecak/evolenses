program test_secondMoment

  use functions
  use kind, only: dp

  real(dp) :: vecX(1:10)
  real(dp) :: result

  print *, "Rozkład płaski, wynik: 0"
  vecX=1.d0
  call secondMoment(vecX,result)
  print *, result

end program
