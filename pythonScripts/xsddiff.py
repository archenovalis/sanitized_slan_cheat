import os
import re

def process_files():
  # Path to the current directory
  current_dir = os.getcwd()
  
  # List all .xsd files in the directory excluding 'diff.xsd'
  xsd_files = [f for f in os.listdir(current_dir) if f.endswith('.xsd') and f != 'diff.xsd']

  diff_file = os.path.join(current_dir, 'diff.xsd')
  with open(diff_file, 'r', encoding='utf-8') as file:
    diff = file.read()

  # Iterate through each file and extract group names
  for filename in xsd_files:
    group_names = []
    with open(filename, 'r', encoding='utf-8') as file:
      content = file.read()
      matches = re.findall(r'<xs:group name="(.*?)">', content)
      group_names.extend(matches)
  
    # Process diff.xsd
    newdiff = diff
  
    # Add include lines for each .xsd file
    newdiff = newdiff.replace(
      '<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified">',
      f'<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified">\n\n  <xs:include schemaLocation="{filename}" />'
    )
  
    # Replace instances of <xs:any> with <xs:choice>
    match = re.search(r'\n(\s*).*lax.*',newdiff)
    if match:
      if (group_names != []):
        spacing = match[1]
        choice_block = spacing+'<xs:choice>\n'
        for group in group_names:
          choice_block = choice_block+spacing+f'  <xs:group ref="{group}" />\n'
        choice_block = choice_block+spacing+'</xs:choice>'

        newdiff = re.sub(
          r'.*lax.*',
          choice_block, newdiff
        )
      else:
        newdiff = re.sub(
          r'(.*)lax(.*)',
          r'\1strict\2', newdiff
        )
      
      # Save the modified diff.xsd as diff.xsd with "diff" suffix
      output_file = os.path.join(current_dir, filename.replace('.xsd','')+'diff.xsd')
      with open(output_file, 'w', encoding='utf-8') as file:
        file.write(newdiff)
    else:
      print("Choice Pattern not found.")


# Run the script
process_files()
