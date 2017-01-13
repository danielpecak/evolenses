program evolenses

    use functions
    use kind, only: dp
    
    real(dp), parameter :: n_air = 1
    real(dp), parameter :: n_glass = 1.33

    real(dp) :: vecX(1:10)
    real(dp) :: result

    vecX=0
    call secondMoment(vecX,result)
    print *, result


end program
