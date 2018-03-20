# Copy Indir to Blueprints 
cp -r /indir/ /srv/jekyll/_data/blueprints/ 

echo "Generating Blueprint Structure..."
# Find all of the blueprint files listed 
declare -a BLUEPRINTS=$(find /srv/jekyll/_data/blueprints -type f -name blueprint.json)

# Generate an index.html file for each blueprint 
for blueprint in ${BLUEPRINTS}; do 

tenant=$(echo "${blueprint}" | awk -F"/" '{print $6}')
product=$(echo "${blueprint}" | awk -F"/" '{print $7}')
environment=$(echo "${blueprint}" | awk -F"/" '{print $8}')
solution=$(echo "${blueprint}" | awk -F"/" '{print $9}')
segment=$(echo "${blueprint}" | awk -F"/" '{print $10}')

echo "Deployment Found - ${tenant}-${product}-${environment}-${solution}-${segment}"

mkdir -p /srv/jekyll/blueprints/${tenant}/${product}/${environment}/${solution}/${segment}

cat << EOF > /srv/jekyll/blueprints/${tenant}/${product}/${environment}/${solution}/${segment}/index.html
---
title: Deployment
layout: diagram
---
{% include diagram.html model=site.data.blueprints.${tenant}.${product}.${environment}.${solution}.${segment}.blueprint %}
EOF

jq -r --arg tenant "${tenant}" --arg product "${product}" --arg environment "${environment}" --arg solution "${solution}" --arg segment "${segment}" \
'.Tenants[0].Id = ($tenant) | .Tenants[0].Products[0].Id = ($product) | .Tenants[0].Products[0].Environments[0].Id = ($environment) | .Tenants[0].Products[0].Environments[0].Solutions[0].Id = ($solution) | .Tenants[0].Products[0].Environments[0].Solutions[0].Segments[0].Id = ($segment)' \
< /tmp/nav_template.json > /srv/jekyll/_data/blueprint_nav-${tenant}-${product}-${environment}-${solution}-${segment}.json
done

echo "Generating Navigation..."
# Create a navigation file from the blueprints 
jq -s -r '.[0].Blueprints=([.[]]|flatten)| .[0] | del(.Tenants) ' /srv/jekyll/_data/blueprint_nav-*.json > /srv/jekyll/_data/blueprint_nav.json

echo "Building Jekyll Site..."
# Run the build
jekyll build --verbose

# Copy site to outdir
cp -r /srv/jekyll/_site/. /outdir/