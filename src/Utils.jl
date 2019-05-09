module Utils

repeatf(n, f, x) = n > 1 ? f(repeatf(n-1, f, x)) : f(x)

function coarse(matrix)
    out   = matrix[1:2:end, 1:2:end]
    out .+= matrix[1:2:end, 2:2:end]
    out .+= matrix[2:2:end, 1:2:end]
    out .+= matrix[2:2:end, 2:2:end]
    out ./ 4
end


export
    coarse,
    repeatf

end # module
