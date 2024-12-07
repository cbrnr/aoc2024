include("aoc.jl")

function process_input(input)
    return permutedims(hcat(collect.(split(input, "\n"))...))
end

function get_next_pos(row, col, direction)
    if direction == '^'
        return row - 1, col
    elseif direction == '>'
        return row, col + 1
    elseif direction == 'v'
        return row + 1, col
    elseif direction == '<'
        return row, col - 1
    end
end

function process_part1(matrix)
    nrows, ncols = size(matrix)
    row, col = Tuple(CartesianIndices(matrix)[findfirst(==('^'), matrix)])
    visited = Set([(row, col)])
    direction = '^'
    turn = Dict('^' => '>', '>' => 'v', 'v' => '<', '<' => '^')
    while true
        next_pos = get_next_pos(row, col, direction)
        (!(1 <= next_pos[1] <= nrows) || !(1 <= next_pos[2] <= ncols)) && break
        if matrix[next_pos...] == '#'
            direction = turn[direction]
        else
            row, col = next_pos
            push!(visited, (row, col))
        end
    end
    return length(visited)
end

cookie = ""
input = get_aoc_input(6, cookie)

matrix = process_input(input)

result = process_part1(matrix)
println("Part 1: ", result)
