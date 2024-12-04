include("aoc.jl")

function process_input(input)
    return permutedims(hcat([parse.(Int, split(row)) for row in split(input, "\n")]...))
end

function process_part1(ids)
    sort!(ids; dims=1)
    return sum(abs.(ids[:, 1] .- ids[:, 2]))
end

function process_part2(ids)
    counts = [count(==(n), ids[:, 2]) for n in ids[:, 1]]
    return sum(ids[:, 1] .* counts)
end

cookie = ""
input = get_aoc_input(1, cookie)
ids = process_input(input)

result = process_part1(ids)
println("Part 1: ", result)

result = process_part2(ids)
println("Part 2: ", result)
