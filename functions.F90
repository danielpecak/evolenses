module functions

    use iso_fortran_env
    integer, parameter, private :: dp = selected_real_kind(REALPRECISION)

contains

  subroutine secondMoment(vecX,result)
    real(dp), intent(in) :: vecX(:)
    real(dp), intent(out):: result
    real(dp) :: mu
    mu = sum(vecX)
    result = sum(vecX(:)**2)-mu**2
  end subroutine secondMoment

end module functions
