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

mkdir -p /srv/jekyll/blueprints/${tenant}/${product}/${environment}/${segment}
mkdir -p /srv/jekyll/_data/blueprints/${tenant}/${product}/${environment}/${segment}/

cp "${blueprint}" "/srv/jekyll/_data/blueprints/${tenant}/${product}/${environment}/${segment}/blueprint.json"
cp "${blueprint}" "/srv/jekyll/blueprints/${tenant}/${product}/${environment}/${segment}/blueprint.json" 
rm "${blueprint}"

cat << EOF > /srv/jekyll/blueprints/${tenant}/${product}/${environment}/${segment}/index.html
---
title: Deployment
layout: diagram
---
{% include diagram.html model=site.data.blueprints.${tenant}.${product}.${environment}.${segment}.blueprint %}
EOF

jq -r --arg tenant "${tenant}" --arg product "${product}" --arg environment "${environment}"  --arg segment "${segment}" \
'.Tenants[0].Id = ($tenant) | .Tenants[0].Products[0].Id = ($product) | .Tenants[0].Products[0].Environments[0].Id = ($environment) | .Tenants[0].Products[0].Environments[0].Segments[0].Id = ($segment)' \
< /tmp/nav_template.json > /srv/jekyll/_data/blueprint_nav-${tenant}-${product}-${environment}-${segment}.json
done

echo "Generating Navigation..."
# Create a navigation file from the blueprints 
jq -s -r '.[0].Blueprints=([.[]]|flatten)| .[0] | del(.Tenants) ' /srv/jekyll/_data/blueprint_nav-*.json > /srv/jekyll/_data/blueprint_nav.json

# Allows for a debug jekyll export of the site 
if [[ "${OUTPUT}" == "jekyll" ]]; then 
    cp -r /srv/jekyll/. /outdir/

elif [ "${OUTPUT}" == "serve" ]; then
    jekyll serve
    
else
    echo "Building Jekyll Site..."
    # Run the build
    jekyll build --verbose
    # Copy site to outdir
    cp -r /srv/jekyll/_site/. /outdir/
fi