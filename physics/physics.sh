#!/bin/bash
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

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
mmd test/test-physics-js-mathjax-cdn.md
mmd test/test-physics-js-unpacked.md
mmd test/test-physics-js.md
mmd index.mmd

cd test/
cp test-physics-latex.mmd temp.md
mmd2pdf temp.md
mv temp.pdf test-physics-latex.pdf
find . -iname 'temp.*' -exec mv '{}' ~/.Trash/ \;