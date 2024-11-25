import re

# Function to modify lines matching the price pattern
def modify_line(line, prev_line, reduce_by):
    # Regex pattern to match the price line
    pattern = r'(\s*<price min=")(\d+)(" average=")(\d+)(" max=")(\d+)(" />)'

    # Check if the line matches the pattern
    if re.match(pattern, line):
        # Replace the line with modified values
        return re.sub(pattern, lambda m: reduce_price_spread(m, reduce_by, prev_line), line)
    return ''

def reduce_price_spread(match, reduce_by, prev_line):
    min_value = int(match.group(2))
    # Modify the price spread only if the min_value is not equal to 1
    if min_value != 1:
        average_value = int(match.group(4))
        max_value = int(match.group(6))

        reduced_min_diff = (min_value - average_value) // reduce_by
        reduced_max_diff = (max_value - average_value) // reduce_by

        # Rebuild the string with modified values
        new_min_value = average_value + reduced_min_diff
        new_max_value = average_value + reduced_max_diff

        prev_match = re.match(r'.*id="(.*)"', prev_line)
        new_prev_line = f'<replace sel="\\\\ware[id=\'{prev_match.group(1)}\']">'
        return f'{new_prev_line}\n{match.group(1)}{new_min_value}{match.group(3)}{average_value}{match.group(5)}{new_max_value}{match.group(7)}\n</replace>'
    return ''


# Function to read, modify, and write to the file
def process_file(input_file, output_file, reduce_by):
    with open(input_file, 'r') as file:
        lines = file.readlines()

    modified_lines = []
    prev_line = ""

    for line in lines:
        modified_line = modify_line(line, prev_line, reduce_by)
        modified_lines.append(modified_line)
        prev_line = line

    with open(output_file, 'w') as file:
        file.writelines(modified_lines)

    print(f"File processed and saved as {output_file}")

# Example usage
input_file = 'parsed_file.xml'
output_file = 'output.xml'
reduce_by = 8

process_file(input_file, output_file, reduce_by)
