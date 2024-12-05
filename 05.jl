include("aoc.jl")

function process_input(input)
    rules, updates = split(input, "\n\n")
    rules = [parse.(Int, rule) for rule in split.(split(rules, "\n"), "|")]
    updates = [parse.(Int, update) for update in split.(split(updates, "\n"), ",")]
    return rules, updates
end

function check_update(update, rules)
    for rule in rules
        if all(i -> i in update, rule)
            if findfirst(==(rule[1]), update) > findfirst(==(rule[2]), update)
                return false
            end
        end
    end
    return true
end

function process_part1(rules, updates)
    correct = check_update.(updates, Ref(rules))
    return sum((v -> v[length(v) ÷ 2 + 1]).(updates[correct]))
end

cookie = ""
input = get_aoc_input(5, cookie)

rules, updates = process_input(input)

result = process_part1(rules, updates)
println("Part 1: ", result)
