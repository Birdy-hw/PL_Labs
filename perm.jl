using Combinatorics
function solve_alphametic(puzzle::String)
    # Split the puzzle into left and right sides
    left_side, right_side = split(puzzle, "=")
    words = split(replace(left_side, "+" => ""), " ")  # Separate words on the left
    # println(words)

    letters = unique(filter(x -> isletter(x), puzzle))
    println(letters)
    # Generate all possible digit assignments
    for perm in permutations(0:9, length(letters))
        letter_to_digit = Dict(letters[i] => perm[i] for i in 1:length(letters))

        # Check for leading zero constraint
        if any(letter_to_digit[word[1]] == 0 for word in [right_side; words] if length(word) > 1)
            continue
        end

        # Replace letters in words with digits and check the sum
        left_sum = sum(parse(Int, join(letter_to_digit[ch] for ch in word)) for word in words)
        right_value = parse(Int, join(letter_to_digit[ch] for ch in right_side))

        # Check if we have found the solution
        if left_sum == right_value
            return letter_to_digit
        end
    end

    return "No solution found"
end

# Test the function with "SEND + MORE = MONEY"
solve_alphametic("SEND + MORE = MONEY")
# println(solution)
