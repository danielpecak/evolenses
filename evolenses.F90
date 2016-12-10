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

end program
