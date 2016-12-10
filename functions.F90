module functions

    use iso_fortran_env
    integer, parameter, private :: dp = selected_real_kind(REALPRECISION)

    type optsurface
        real(dp) :: xmid      ! polozenie punktu przeciecia powierzchni z osia optyczna
        real(dp) :: rad       ! promien krzywizny (R>0 -> ksztalt C, R<0 -> ksztalt D)
        real(dp) :: diam      ! srednica tuby
        real(dp) :: ncoeff    ! wspolczynnik zalamania przed powierzchnia
        real(dp) :: xcurv     ! polozenie srodka sfery definiujacej krzywizne
        real(dp) :: xrim      ! polozenie
    end type

    type ray
        real(dp) :: x       ! wspolrzedna wzdluz osi
        real(dp) :: z       ! odleglosc od osi
        real(dp) :: phi     ! kat
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

  subroutine refraction_kurwa(vec,s0,s)
    real(dp), intent(inout) :: vec(1:2) !vec(1) - odległość od osi optycznej, vec(2) kąt z osią optyczną
    type(optsurface), intent(in) :: s0
    type(optsurface), intent(in) :: s
    !załamanie w punkcie styku, czyli odległośc od osi optycznej bez zmian
    vec(2) = vec(1) * (s0%ncoeff - s%ncoeff) / (s%rad*s%ncoeff) &
        & + vec(2)*s0%ncoeff / s%ncoeff
  end subroutine

    subroutine optsurf_geom(s)
        type(optsurface), intent(inout) :: S
        real(dp) :: c
        if ( abs(S%rad) < (S%diam / 2) )  error stop "Lens is no good."
            S%xcurv = ( S%xmid + S%rad )
            c = sqrt( S%rad**2 - S%diam**2 / 4 )
        if ( S%rad > 0 ) then
            S%xrim = S%xcurv - c
        else
            S%xrim = S%xcurv + c
        endif
    end subroutine



end module functions
