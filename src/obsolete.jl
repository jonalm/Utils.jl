using MAT

function extractmat(matfn::String, regex::Regex=r""; flat::Bool=false)
    out = matopen(matfn) do file
        hits = String[]
        for n in names(file)
            ismatch(regex, n) && push!(hits,n)
        end
        length(hits)==0 && throw("$regex not found")
        length(hits)>1 && throw("no unique field, specify by regex\nFound : $(join(hits,','))\n")
        return read(file, hits[1])
    end
    flatten(x) = flat ? reshape(x, prod(size(x))) : x
    return out |> flatten
end

function findsorted{T<:Any}(A::Vector{T}, v::T)
    I = (0, length(A)) # interval,
    while true
        L = I[2] - I[1] # interval length
        if L<=1
            return A[I[2]] == v ? I[2] : -1
        end
        half = I[1] + L >>> 1
        I = v<=A[half] ? (I[1], half) : (half, I[2])
    end
end
