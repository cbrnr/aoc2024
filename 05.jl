include("aoc.jl")

function process_input(input)
    rules, updates = split(input, "\n\n")
    rules = [parse.(Int, rule) for rule in split.(split(rules, "\n"), "|")]
    updates = [parse.(Int, update) for update in split.(split(updates, "\n"), ",")]
    return rules, updates
end

function check_rule(rule, update)
    return findfirst(==(rule[1]), update) < findfirst(==(rule[2]), update)
end

function check_rules(update, rules)
    for rule in rules
        if all(i -> i in update, rule)
            !check_rule(rule, update) && return false
        end
    end
    return true
end

function fix_update(update, rules)
    while !check_rules(update, rules)
        for rule in rules
            if all(i -> i in update, rule) && !check_rule(rule, update)
                idx1 = findfirst(==(rule[1]), update)
                idx2 = findfirst(==(rule[2]), update)
                update[idx1], update[idx2] = update[idx2], update[idx1]
            end
        end
    end
end

function process_part1(rules, updates)
    correct = check_rules.(updates, Ref(rules))
    return sum((v -> v[length(v) ÷ 2 + 1]).(updates[correct]))
end

function process_part2(rules, updates)
    incorrect = .!check_rules.(updates, Ref(rules))
    fix_update.(updates[incorrect], Ref(rules))
    return sum((v -> v[length(v) ÷ 2 + 1]).(updates[incorrect]))
end

cookie = ""
input = get_aoc_input(5, cookie)

rules, updates = process_input(input)

result = process_part1(rules, updates)
println("Part 1: ", result)

result = process_part2(rules, updates)
println("Part 2: ", result)
