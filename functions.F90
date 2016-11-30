module functions
use constants

contains
  subroutine secondMoment(vecX,result)
    real(dp), intent(in) :: vecX(:)
    real(dp), intent(out):: result
    real(dp) :: mu
    mu = sum(vecX)
    result = sum(vecX(:)**2)-mu**2
  end subroutine secondMoment

end module functions
