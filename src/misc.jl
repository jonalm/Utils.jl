

repeatf(n, f, x) = n > 1 ? f(repeatf(n-1, f, x)) : f(x)

flatmat(mat) = reshape(mat, *(size(mat)...))

two(x) = one(x) + one(x)

function centermod(val, period)
    halfperiod = period / two(period)
    (val + halfperiod) % period - halfperiod
end
