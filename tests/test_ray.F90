program test_ray

  use functions
  use kind, only: dp

  ! integer, parameter :: dp = selected_real_kind(REALPRECISION)

  type(ray) :: r
  call printRay(r)

end program
