X4 7.14

install vscode extension xml red hat
manually install vscode extension x4codecomplete.vsix from https://github.com/Cgettys/X4CodeComplete/releases
^ THIS IS VERY AMAZE

npm i

setup your compile scripts in project.json


compile your mod's zip with:
npm run scriptname  (ie: npm run bank)


profit



if your mod has filetypes other than .xml, then add "allowedextensions" to your mods root directory, add all the filetypes to it. this way you can put whatever files you want throughout your mod, but the release is auto created with just the necessary files
