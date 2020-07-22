#!/bin/bash
yarn --cwd frontend/ install
yarn --cwd frontend/ build-prod
mkdir public/ember
cp -r frontend/dist/* public/ember/

# Replace ember source
sed -i 's/http:\/\/localhost:4200/\/ember/g' app/views/frontend/index.html.haml
vendorjs="$(grep -oP '(?<=<script src="\/assets\/)vendor-[a-z|\d]{32}.js' public/ember/index.html)"
vendorcss="$(grep -oP '(?<=href="\/assets\/)vendor-[a-z|\d]{32}.css' public/ember/index.html)"
frontendjs="$(grep -oP '(?<=<script src="\/assets\/)frontend-[a-z|\d]{32}.js' public/ember/index.html)"
frontendcss="$(grep -oP '(?<=href="\/assets\/)frontend-[a-z|\d]{32}.css' public/ember/index.html)"
sed -i "s/vendor.js/$vendorjs/g" app/views/frontend/index.html.haml
sed -i "s/vendor.css/$vendorcss/g" app/views/frontend/index.html.haml
sed -i "s/frontend.js/$frontendjs/g" app/views/frontend/index.html.haml
sed -i "s/frontend.css/$frontendcss/g" app/views/frontend/index.html.haml
