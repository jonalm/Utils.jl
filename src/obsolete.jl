function coarse(matrix)
    out   = matrix[1:2:end, 1:2:end]
    out .+= matrix[1:2:end, 2:2:end]
    out .+= matrix[2:2:end, 1:2:end]
    out .+= matrix[2:2:end, 2:2:end]
    out ./ 4
end
