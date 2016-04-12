#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

# uglify & beautify
sed -i '' s/'\	'// test/macro.js
uglifyjs test/macro.js -b -o test/macro.js
cat License.js test/macro.js > temp.js
mv temp.js test/macro.js

sed -i '' s/'\	'// unpacked/physics.js
uglifyjs unpacked/physics.js -b -o unpacked/physics.js
cat License.js unpacked/physics.js > temp.js
mv temp.js unpacked/physics.js

uglifyjs unpacked/physics.js -m -c -o physics.js
cat License.js physics.js > temp.js
mv temp.js physics.js
sed -i '' s/"unpacked\/"// physics.js

# MultiMarkdown

mmd test/macro.md
mmd index.md

cp index.md temp.md
mmd2pdf temp.md
mv temp.pdf index.pdf
find . -iname 'temp.*' -exec mv '{}' ~/.Trash/ \;