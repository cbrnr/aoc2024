using InvertedIndices

include("aoc.jl")

function process_input(input)
    return [parse.(Int, split(row)) for row in split(input, "\n")]
end

function is_valid(report; dampener=false)
    valid = all(-3 .<= diff(report) .< 0) || all(0 .< diff(report) .<= 3)
    valid && return true  # this is independent of the dampener
    
    # dampener == false
    !dampener && return valid

    # dampener == true
    for i in 1:length(report)
        is_valid(report[Not(i)]) && return true
    end
    return false
end

function process_part1(reports)
    return sum(is_valid.(reports))
end

function process_part2(reports)
    return sum(is_valid.(reports; dampener=true))
end

cookie = ""
input = get_aoc_input(2, cookie)

reports = process_input(input)

result = process_part1(reports)
println("Part 1: ", result)

result = process_part2(reports)
println("Part 2: ", result)
