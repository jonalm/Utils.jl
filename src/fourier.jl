
function ft(x::Vector, dt=1.0)
    N = length(x)
    @assert  N%2 == 0 "input length needs to be divisible by two"
    Nhalf = N>>1
    k = (-Nhalf:Nhalf-1) / (dt*N)
    fftshift(fft(x)), k
end

function rft(x::Vector, dt=1.0)
    N = length(x)
    @assert  N%2 == 0 "input length needs to be divisible by two"
    k = (0:N>>1) / (dt*N)
    rfft(x), k
end

function translate(x::Vector, Δ, dt=1.0)
    N = length(x)
    @assert  N%2==0 "input length needs to be divisible by two"
    k = (0:N>>1) / (dt*N)
    irfft( exp.(- Δ * 2π * 1im .* k) .* rfft(x), N)
end

## interpolation
function interpft(sig::AbstractArray{<:Real,1},n::Integer)
    n_orig = div(length(sig),2)
    return irfft( vcat( rfft(sig), zeros( div(n,2) - n_orig ) ) , n )
end
