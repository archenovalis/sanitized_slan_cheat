X4 7.14

install vscode extension xml red hat
manually install vscode extension x4codecomplete.vsix from https://github.com/Cgettys/X4CodeComplete/releases
^ THIS IS VERY AMAZE

npm i

setup your compile scripts in project.json


compile your mod's zip with:
npm run scriptname  (ie: npm run bank)


profit


maybe i'll do branches for each individual mod... maybe not... probably not


if your mod has filetypes other than .xml, then add "allowedextensions" to your mods root directory, add all the filetypes to it

also, notice the scheme in each of the xmls needs to be "../../md/md.xsd" for mds, use the aiscripts one for aiscripts, etc... codecomplete requires such. are there others? probably. add them like these (create folders for them in the true root folder)


compiling will search for and remove ../../.*/ 