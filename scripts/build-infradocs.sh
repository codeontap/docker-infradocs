# Copy Indir to Blueprints 
cp -r /indir/ /srv/jekyll/_data/blueprints/ 

echo "Generating Blueprint Structure..."
# Find all of the blueprint files listed 
declare -a BLUEPRINTS=$(find /srv/jekyll/_data/blueprints -not -path '*/\.*' -type f -name "*blueprint.json")

# Generate an index.html file for each blueprint 
for blueprint in ${BLUEPRINTS}; do 

tenant=$(basename "${blueprint}" | awk -F"-" '{print $1}')
product=$(basename "${blueprint}" | awk -F"-" '{print $2}')
environment=$(basename "${blueprint}" | awk -F"-" '{print $3}')
segment=$(basename "${blueprint}" | awk -F"-" '{print $4}')

echo "Deployment Found - ${tenant}-${product}-${environment}-${segment}"

mkdir -p /srv/jekyll/_blueprints/${tenant}/${product}/${environment}/${segment}
mkdir -p /srv/jekyll/_data/blueprints/${tenant}/${product}/${environment}/${segment}/

cp "${blueprint}" "/srv/jekyll/_data/blueprints/${tenant}/${product}/${environment}/${segment}/blueprint.json"
cp "${blueprint}" "/srv/jekyll/_blueprints/${tenant}/${product}/${environment}/${segment}/blueprint.json" 
rm "${blueprint}"

cat << EOF > /srv/jekyll/_blueprints/${tenant}/${product}/${environment}/${segment}/index.html
---
title: Deployment
layout: diagram
tenant: ${tenant}
product: ${product}
environment: ${environment}
segment: ${segment}
---
{% include diagram.html model=site.data.blueprints.${tenant}.${product}.${environment}.${segment}.blueprint %}
EOF

done

# Allows for a debug jekyll export of the site 
if [[ "${OUTPUT}" == "jekyll" ]]; then 
    cp -r /srv/jekyll/. /outdir/

elif [ "${OUTPUT}" == "serve" ]; then
    [[ -d /srv/jekyll/_data/blueprints/.msw ]] && rm -rf /srv/jekyll/_data/blueprints/.msw
    [[ -d /srv/jekyll/_blueprints/.msw ]] && rm -rf /srv/jekyll/_blueprints/.msw
    jekyll serve --watch --quiet

else
    [[ -d /srv/jekyll/_data/blueprints/.msw ]] && rm -rf /srv/jekyll/_data/blueprints/.msw
    [[ -d /srv/jekyll/_blueprints/.msw ]] && rm -rf /srv/jekyll/_blueprints/.msw
    
    echo "Building Jekyll Site..."
    # Run the build
    jekyll build --verbose
    # Copy site to outdir
    cp -r /srv/jekyll/_site/. /outdir/
fi