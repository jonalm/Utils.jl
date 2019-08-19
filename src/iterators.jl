macro return_nothing_if_noting(ex)
    quote
        result = $(esc(ex))
        result === nothing && return nothing
        result
    end
end

abstract type IterWrapper end
Base.length(iw::IterWrapper) = length(iw.iter)

struct Neighbors{S} <: IterWrapper
    iter::S
end

function Base.iterate(n::Neighbors{S}) where {S}
    inner_val_1, inner_state_1 = @return_nothing_if_noting iterate(n.iter)
    inner_val_2, inner_state_2 = @return_nothing_if_noting iterate(n.iter,inner_state_1)
    return (inner_val_1, inner_val_2), (first_val=inner_val_1, previous_val=inner_val_2, iterstate=inner_state_2)
end

function Base.iterate(n::Neighbors{S}, state) where {S}
    state === nothing && return nothing
    tmp = iterate(n.iter, state.iterstate)
    tmp === nothing && return (state.previous_val, state.first_val), nothing
    inner_val, inner_state = tmp
    return (state.previous_val, inner_val), (first_val=state.first_val, previous_val=inner_val, iterstate=inner_state)
end

struct Tail{S,T} <: IterWrapper
  iter::S
  n::T
end

function Base.iterate(t::Tail{S,T}) where {S, T}
  inner_val, inner_state = @return_nothing_if_noting iterate(t.iter)
  tail_state = CircularBuffer{eltype(t.iter)}(t.n)
  push!(tail_state, inner_val)
  return tail_state, (inner_state, tail_state)
end

function Base.iterate(t::Tail{S,T}, (inner_state, tail_state)) where {S,T}
  inner_val, inner_state =  @return_nothing_if_noting iterate(t.iter, inner_state)
  push!(tail_state, inner_val)
  return tail_state, (inner_state, tail_state)
end
