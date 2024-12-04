include("aoc.jl")

function process_input(input)
    return permutedims(hcat([collect(row) for row in split(input, "\n")]...))
end

function find_token(matrix, token)
    nrows, ncols = size(matrix)
    len = length(token)
    counter = 0
    for idx in eachindex(CartesianIndices(matrix))
        row, col = Tuple(idx)
        # right
        if col <= ncols - len + 1
            if String(matrix[row, col:col+len-1]) == token
                counter += 1
            end
        end

        # left
        if col >= len
            if String(matrix[row, col-len+1:col]) == reverse(token)
                counter += 1
            end
        end

        # down
        if row <= nrows - len + 1
            if String(matrix[row:row+len-1, col]) == token
                counter += 1
            end
        end

        # up
        if row >= len
            if String(matrix[row-len+1:row, col]) == reverse(token)
                counter += 1
            end
        end

        # right down
        if (col <= ncols - len + 1) && (row <= nrows - len + 1)
            if String([matrix[row+i, col+i] for i in 0:len-1]) == token
                counter += 1
            end
        end

        # right up
        if (col <= ncols - len + 1) && (row >= len)
            if String([matrix[row-i, col+i] for i in 0:len-1]) == token
                counter += 1
            end
        end

        # left down
        if (col >= len) && (row <= nrows - len + 1)
            if String([matrix[row+i, col-i] for i in 0:len-1]) == token
                counter += 1
            end
        end

        # left up
        if (col >= len) && (row >= len)
            if String([matrix[row-i, col-i] for i in 0:len-1]) == token
                counter += 1
            end
        end
    end
    return counter
end

function find_shape(matrix, token)
    nrows, ncols = size(matrix)
    Δ = length(token) ÷ 2
    counter = 0
    for idx in eachindex(CartesianIndices(matrix))
        row, col = Tuple(idx)
        if (Δ < row < nrows - Δ + 1) && (Δ < col < ncols - Δ + 1)
            diag1 = String([matrix[row+i, col+i] for i in -Δ:Δ])
            diag2 = String([matrix[row+i, col-i] for i in -Δ:Δ])
            if ((diag1 == token) || (diag1 == reverse(token)))
                if ((diag2 == token) || (diag2 == reverse(token)))
                    counter += 1
                end
            end
        end
    end
    return counter
end

function process_part1(puzzle)
    find_token(puzzle, "XMAS")
end

function process_part2(puzzle)
    find_shape(puzzle, "MAS")
end

cookie = ""
input = get_aoc_input(4, cookie)

puzzle = process_input(input)

result = process_part1(puzzle)
println("Part 1: ", result)

result = process_part2(puzzle)
println("Part 2: ", result)
