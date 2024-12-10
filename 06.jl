include("aoc.jl")

function process_input(input)
    return permutedims(hcat(collect.(split(input, "\n"))...))
end

struct Position
    row::Int
    col::Int
    dir::Char
end

function next_pos(p::Position)
    if p.dir == '^'
        return Position(p.row - 1, p.col, p.dir)
    elseif p.dir == '>'
        return Position(p.row, p.col + 1, p.dir)
    elseif p.dir == 'v'
        return Position(p.row + 1, p.col, p.dir)
    elseif p.dir == '<'
        return Position(p.row, p.col - 1, p.dir)
    end
end

function get_path(matrix)
    nrows, ncols = size(matrix)
    dir = '^'
    row, col = Tuple(CartesianIndices(matrix)[findfirst(==(dir), matrix)])
    turn = Dict('^' => '>', '>' => 'v', 'v' => '<', '<' => '^')
    pos = Position(row, col, dir)  # starting position
    path = [pos]
    while true
        next = next_pos(pos)  # potential next position
        (!(1 <= next.row <= nrows) || !(1 <= next.col <= ncols)) && break  # out of bounds
        next in path && return nothing  # loop
        if matrix[next.row, next.col] == '#'
            pos = Position(pos.row, pos.col, turn[pos.dir])  # just turn
            push!(path, pos)
        else
            pos = next  # move to next position
            push!(path, pos)
        end
    end
    return path
end

function process_part1(matrix)
    return length(unique((pos.row, pos.col) for pos in get_path(matrix)))
end

function process_part2(matrix)
    positions = unique((pos.row, pos.col) for pos in get_path(matrix))[2:end]
    counter = 0
    for position in positions
        m = copy(matrix)
        m[position...] = '#'
        if isnothing(get_path(m))
            counter += 1
        end
    end
    return counter
end

cookie = ""
input = get_aoc_input(6, cookie)

matrix = process_input(input)

result = process_part1(matrix)
println("Part 1: ", result)

result = process_part2(matrix)
println("Part 2: ", result)
