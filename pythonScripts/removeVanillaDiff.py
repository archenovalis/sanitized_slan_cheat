import re

##########################################################
#####   Removes vanilla wares and such from your mod #####
##########################################################
#
# place your debug.txt and this file in your extensions directory
#
# ensure your diff files done't have any bugs, this will remove all no matching nodes
#
# python removeVanillaDiff.py

error_pattern = r"\[=ERROR=\] \d+\.\d+ No matching node for path '(?P<path>.*?)' in patch file '(?P<file>.*?)'. Skipping node."

def remove_lines_from_file(input_file: str):
  user_choices = {}
  with open(input_file, 'r') as infile:
    lines = infile.readlines()
    skip_lines = False
    remove_until_tag = None

    for line in lines:
      match = re.search(error_pattern, line)
      outfile = None
      if match:
        path = match.group("path")
        file_path = match.group("file").replace('extensions\\', '', 1)
        if not file_path.endswith('.xml'):
            file_path += '.xml'
        if file_path not in user_choices:
          # Ask confirmation to process this file
          user_input = input(f"Do you want to process the file '{file_path}'? (y/n): ").strip().lower()
          while user_input not in ['y', 'n']:
            user_input = input("Invalid input. Please enter 'y' or 'n': ").strip().lower()
          user_choices[file_path] = user_input == 'y'
          print(f"'{user_choices[file_path]}'")
        if not user_choices[file_path]:
          continue
        
        try:
          outfile = open(file_path, 'r+', encoding='utf-8')
          xml_lines = outfile.readlines()
          outfile.seek(0)
          outfile.truncate(0)
        except FileNotFoundError:
          print(f"File not found: {file_path}. Skipping...")
          continue
        except UnicodeDecodeError:
          print(f"Failed to decode the file '{file_path}' due to encoding issues. Skipping...")
          continue
        
        skip_lines = False
        remove_until_tag = None

        for xml_line in xml_lines:
          if path in xml_line:
            if "<add" in xml_line:
              remove_until_tag = "</add>"
            elif "<remove" in xml_line:
              remove_until_tag = "/>"
            elif "<replace" in xml_line:
              remove_until_tag = "</replace>"
            skip_lines = True

          if remove_until_tag and remove_until_tag in xml_line:
            remove_until_tag = None
            skip_lines = False
            continue

          if not skip_lines:
            outfile.write(xml_line)
        outfile.close()

input_file = 'debug.txt'

remove_lines_from_file(input_file)
