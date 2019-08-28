
export NeighborMap

struct NeighborMap{R, Dim, D}
    lookup::Dict{NTuple{Dim,Int}, Vector{R}}
    delta::D
end

NeighborMap(R::Type, Dim::Int, delta::D) where {D<:Real} =
    NeighborMap{R, Dim, D}(Dict{NTuple{Dim,Int}, Vector{R}}(), delta)

_pos2ind(nm::NeighborMap, pos) = Tuple(ceil(Int, p/nm.delta) for p in pos)
_neighbors(i::Int) = (i+k for k in (-1:1))

function Base.push!(nm::NeighborMap, (pos, ref))
    dictkey = _pos2ind(nm,pos)
    if haskey(nm.lookup, dictkey)
        push!(nm.lookup[dictkey], ref)
    else
        push!(nm.lookup, dictkey=>[ref])
    end
end

function Base.append!(nm::NeighborMap, iter)
    for x in iter
        push!(nm, x)
    end
end

Base.setindex!(nm::NeighborMap, pos, ref) = push!(nm, (pos, ref))

function Base.getindex(nm::NeighborMap, pos)
    nhood = Iterators.product((_neighbors(i) for i in _pos2ind(nm, pos))...)
    res = vcat((nm.lookup[k] for k in nhood if haskey(nm.lookup, k))...)
     # res is Vector{Any} if empty, convert to consisten output
    length(res) > 0 ? res : typeof(nm).parameters[1][]
    res
end
