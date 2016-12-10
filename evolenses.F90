program evolenses

    use functions

    integer, parameter :: dp = selected_real_kind(REALPRECISION)

    type optsurface
        !!!                   PARAMETRY ZADANE
        real(dp) :: xmid      ! polozenie punktu przeciecia powierzchni z osia optyczna
        real(dp) :: rad       ! promien krzywizny (R>0 -> ksztalt C, R<0 -> ksztalt D)
        real(dp) :: diam      ! srednica tuby
        !!!                   PARAMETRY WYZNACZANE
        real(dp) :: xcurv     ! polozenie srodka sfery definiujacej krzywizne
        real(dp) :: xrim      ! polozenie
    end type


    real(dp), parameter :: n_air = 1
    real(dp), parameter :: n_glass = 1.33

    real(dp) :: vecX(1:10)
    real(dp) :: result

    vecX=0
    call secondMoment(vecX,result)
    print *, result

contains

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

    subroutine propagate(vec,dist)
      real(dp), intent(in)    :: dist     !odległość na jaką propaguje się promień
      real(dp), intent(inout) :: vec(1:2) !vec(1) - odległość od osi optycznej, vec(2) kąt z osią optyczną
      vec(1) = vec(1) + vec(2)*dist !zmiana ogległości od osi optycznej
      ! kąt się nie zmienia podczas propagacji
    end subroutine

    subroutine refraction_kurwa(vec,s)
      real(dp), intent(inout) :: vec(1:2) !vec(1) - odległość od osi optycznej, vec(2) kąt z osią optyczną
      type(optsurface), intent(in) :: s
      real(dp) :: n1,n2
      !załamanie w punkcie styku, czyli odległośc od osi optycznej bez zmian
      vec(2) = vec(1)*(n1n-n2)/(optsurface%rad*n2) + vec(2)*n1/n2
    end subroutine

end program
