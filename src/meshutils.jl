
using GeometryTypes: Triangle

function colors_face2vertex_based(vertices, faces, colors)
    new_vertices = similar(vertices, 0)
    new_faces = similar(faces, 0)
    new_colors = similar(colors, 0)
    for (i, face) in enumerate(faces)
        for vertex in vertices[face]
            push!(new_vertices, vertex)
            push!(new_colors, colors[i])
        end
        push!(new_faces, Triangle(3i - 2:3i...))
    end
    return new_vertices, new_faces, new_colors
end
