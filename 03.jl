include("aoc.jl")

function process_part1(code)
    println("Processing:\n\n", code)
    s = 0
    for m in eachmatch(r"mul\((\d+),(\d+)\)", code)
        s += parse(Int, m.captures[1]) * parse(Int, m.captures[2])
    end
    return s
end

function process_part2(code)
    s = 0
    for m in eachmatch(r"^(.*)don't\(\)|do\(\)(.*)don't\(\)|do\(\)(.*)$", code)
        s += process_part1(something(m.captures...))
    end
    return s
end

cookie = ""
input = get_aoc_input(3, cookie)

result = process_part1(input)
println("Part 1: ", result)

result = process_part2(input)
println("Part 2: ", result)
