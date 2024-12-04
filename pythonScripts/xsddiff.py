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
    complex_names = []
    element_names = []
    elementType_names = []
    with open(filename, 'r', encoding='utf-8') as file:
      content = file.read()
# correct code for md.xsd, seems right now
#      groupMatches = re.findall(r'<xs:group name="(.*?)"\s*>', content)
#      group_names.extend(groupMatches)
#      complexMatches = re.findall(r'<xs:complexType name="(.*?)"\s*>', content)
#      complex_names.extend(complexMatches)
#      if (group_names == [] and complex_names == []):
      elementTypeMatches = re.findall(r'<xs:element name="(.*?)".*type="(.*?)"', content)
      elementType_names.extend(elementTypeMatches)
#      if (elementType_names == []):
      elementMatches = re.findall(r'(?!.*type).*?<xs:element name="(.*?)"', content)
      element_names.extend(elementMatches)
  
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
      spacing = match[1]
      names = []
      choice_block = spacing+'<xs:choice minOccurs="1" maxOccurs="unbounded">\n'
      if (group_names != []):
        choice_block = spacing+'<xs:choice>\n'
        for group in group_names:
          choice_block = choice_block+spacing+f'  <xs:group ref="{group}" />\n'
      if (complex_names != []):
        for complex in complex_names:
          choice_block = choice_block+spacing+f'  <xs:element name="{complex}" />\n'
      if (elementType_names != []):
        for complex in elementType_names:
          if complex[0] not in names:
            choice_block = choice_block+spacing+f'  <xs:element name="{complex[0]}" type="{complex[1]}" />\n'
            names.append(complex[0])
      if (element_names != []):
        for complex in element_names:
          if complex not in names:
            choice_block = choice_block+spacing+f'  <xs:element name="{complex}" />\n'
            names.append(complex)

      choice_block = choice_block+spacing+'</xs:choice>'
      newdiff = re.sub(
        r'.*lax.*',
        choice_block, newdiff
      )
      
      # Save the modified diff.xsd as diff.xsd with "diff" suffix
      output_file = os.path.join(current_dir, filename.replace('.xsd','')+'diff.xsd')
      with open(output_file, 'w', encoding='utf-8') as file:
        file.write(newdiff)
    else:
      print("Choice Pattern not found.")


# Run the script
process_files()
