module functions

    use iso_fortran_env
    integer, parameter, private :: dp = selected_real_kind(REALPRECISION)

    type optsurface
        !!!                   PARAMETRY ZADANE
        real(dp) :: xmid      ! polozenie punktu przeciecia powierzchni z osia optyczna
        real(dp) :: rad       ! promien krzywizny (R>0 -> ksztalt C, R<0 -> ksztalt D)
        real(dp) :: diam      ! srednica tuby
        real(dp) :: n1        ! wspolczynnik zalamania przed powierzchnia
        real(dp) :: n2        ! wspolczynnik zalamania za powierzchnia
        !!!                   PARAMETRY WYZNACZANE
        real(dp) :: xcurv     ! polozenie srodka sfery definiujacej krzywizne
        real(dp) :: xrim      ! polozenie
    end type

contains

  subroutine secondMoment(vecX,result)
    real(dp), intent(in) :: vecX(:)
    real(dp), intent(out):: result
    real(dp) :: mu
    mu = sum(vecX)
    result = sum(vecX(:)**2)-mu**2
  end subroutine secondMoment

  subroutine propagate(vec,dist)
    real(dp), intent(in)    :: dist     !odległość na jaką propaguje się promień
    real(dp), intent(inout) :: vec(1:2) !vec(1) - odległość od osi optycznej, vec(2) kąt z osią optyczną
    vec(1) = vec(1) + vec(2)*dist !zmiana ogległości od osi optycznej
    ! kąt się nie zmienia podczas propagacji
  end subroutine

  subroutine refraction_kurwa(vec,s)
    real(dp), intent(inout) :: vec(1:2) !vec(1) - odległość od osi optycznej, vec(2) kąt z osią optyczną
    type(optsurface), intent(in) :: s
    !załamanie w punkcie styku, czyli odległośc od osi optycznej bez zmian
    vec(2) = vec(1)*(optsurface%n1-optsurface%n2)/(optsurface%rad*optsurface%n2) + vec(2)*optsurface%n1/optsurface%n2
  end subroutine

end module functions
