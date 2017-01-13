program evolenses

    use functions
    use iso_fortran_env

    integer, parameter :: dp = real64


    real(dp), parameter :: n_air = 1
    real(dp), parameter :: n_glass = 1.33

    real(dp) :: vecX(1:10)
    real(dp) :: result

    vecX=0
    call secondMoment(vecX,result)
    print *, result


end program
