module constants

    use iso_fortran_env

    integer, parameter, private :: dp = selected_real_kind(REALPRECISION)

    real(dp), parameter :: n_air = 1
    real(dp), parameter :: n_glass = 1.33

end module
