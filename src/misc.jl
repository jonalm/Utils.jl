export two, three, four, double, triple, quadruple, half, third, quarter, flatmat

@inline two(x)       = one(x) + one(x)
@inline three(x)     = one(x) + one(x) + one(x)
@inline four(x)      = one(x) + one(x) + one(x)

@inline double(x)    = two(x) * x
@inline triple(x)    = three(x) * x
@inline quadruple(x) = four(x) * x

@inline half(x)      = x / two(x)
@inline third(x)     = x / three(x)
@inline quarter(x)   = x / four(x)

flatmat(mat) = reshape(mat, *(size(mat)...))

repeatf(n, f, x) = n > 1 ? f(repeatf(n-1, f, x)) : f(x)

function centermod(val, period)
    halfperiod = period / two(period)
    (val + halfperiod) % period - halfperiod
end
