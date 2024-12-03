include("aoc.jl")

function process_part1(code)
    s = 0
    for m in eachmatch(r"mul\((\d+),(\d+)\)", code)
        s += parse(Int, m.captures[1]) * parse(Int, m.captures[2])
    end
    return s
end

function process_part2(code)
    return process_part1(replace(code, r"don't\(\)(.*?)do\(\)"s => ""))
end

cookie = ""
input = get_aoc_input(3, cookie)

result = process_part1(input)
println("Part 1: ", result)

result = process_part2(input)
println("Part 2: ", result)
