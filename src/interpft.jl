function interpft(sig::AbstractArray{<:Real,1},n::Integer)
    n_orig = div(length(sig),2)
    return irfft( vcat( rfft(sig), zeros( div(n,2) - n_orig ) ) , n )
end
