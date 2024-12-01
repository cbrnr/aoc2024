using HTTP

"""
    get_aoc_input(day, cookie; year=2024)

Download Advent of Code input data for the given `day` and `year`.

A valid `cookie` must be provided, for example by logging into the
[Advent of Code website](https://adventofcode.com/) with a browser and copying the
session cookie (accessible in the browser development tools).
"""
function get_aoc_input(day::Integer, cookie::AbstractString; year::Integer=2024)
    cookies = Dict("session"=>cookie)
    r = HTTP.get("https://adventofcode.com/$year/day/$day/input", cookies=cookies)
    strip(String(r.body))
end
