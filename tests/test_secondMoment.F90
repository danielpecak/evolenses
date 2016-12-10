program test_secondMoment

  use functions

  integer, parameter :: dp = selected_real_kind(REALPRECISION)

  real(dp) :: vecX(1:10)
  real(dp) :: result

  print *, "Rozkład płaski, wynik: 0"
  vecX=1.d0
  call secondMoment(vecX,result)
  print *, result

end program
