module functions

    use kind, only: dp

    type optsurface
        real(dp) :: zaxis      ! polozenie punktu przeciecia powierzchni z osia optyczna
        real(dp) :: rad       ! promien krzywizny (R>0 -> ksztalt C, R<0 -> ksztalt D)
        real(dp) :: diam      ! srednica tuby
        real(dp) :: ncoeff    ! wspolczynnik zalamania przed powierzchnia
        real(dp) :: zsphr     ! polozenie srodka sfery definiujacej krzywizne
        real(dp) :: zrim      ! polozenie
    end type

    type ray
        real(dp) :: z       ! wspolrzedna wzdluz osi
        real(dp) :: x       ! odleglosc od osi
        real(dp) :: phi     ! kat
    end type

contains
  subroutine printRay(r)
    type(ray), intent(in) :: r
    print *, "Z coordinate:", r%z
    print *, "X coordinate:", r%x
    print *, "Angle value:", r%phi
  end subroutine

  subroutine secondMoment(vecX,result)
    real(dp), intent(in) :: vecX(:)
    real(dp), intent(out):: result
    real(dp) :: mu
    mu = sum(vecX)/size(vecX,1)
    result = sum((vecX(:)-mu)**2)
  end subroutine secondMoment

  subroutine propagate(r,dist)
    type(ray), intent(inout) :: r
    real(dp), intent(in)    :: dist     !odległość na jaką propaguje się promień
    r%x = r%x + r%phi*dist     !zmiana ogległości od osi optycznej, reszta bez zmian
  end subroutine

  subroutine refraction_kurwa(r,s0,s)
    type(ray), intent(inout) :: r
    type(optsurface), intent(in) :: s0
    type(optsurface), intent(in) :: s
    !załamanie w punkcie styku, czyli odległośc od osi optycznej bez zmian
    r%phi = r%x * (s0%ncoeff - s%ncoeff) / (s%rad*s%ncoeff) &
        & + r%phi*s0%ncoeff / s%ncoeff
  end subroutine

    subroutine optsurf_geom(s)
        type(optsurface), intent(inout) :: S
        real(dp) :: c
        if ( abs(S%rad) < (S%diam / 2) )  error stop "Lens is no good."
            S%zsphr = ( S%zaxis + S%rad )
            c = sqrt( S%rad**2 - S%diam**2 / 4 )
        if ( S%rad > 0 ) then
            S%zrim = S%zsphr - c
        else
            S%zrim = S%zsphr + c
        endif
    end subroutine



end module functions
