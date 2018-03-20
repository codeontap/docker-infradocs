

# Find all of the blueprint files listed 
BLUEPRINTS=$()

declare -a BLUEPRINTS=$(find ./_data/blueprints -type f -name blueprint.json)

# Generate an index.html file for each blueprint 
for blueprint in ${BLUEPRINTS}; do 

    tenant=$(echo "${blueprint}" | awk -F"/" '{print $4}')
    product=$(echo "${blueprint}" | awk -F"/" '{print $5}')
    environment=$(echo "${blueprint}" | awk -F"/" '{print $6}')
    solution=$(echo "${blueprint}" | awk -F"/" '{print $7}')
    segment=$(echo "${blueprint}" | awk -F"/" '{print $8}')

    mkdir -p blueprints/${tenant}/${product}/${environment}/${solution}/${segment}

cat << EOF > blueprints/${tenant}/${product}/${environment}/${solution}/${segment}/index.html
---
title: Deployment
layout: diagram
---
{% include diagram.html model=site.data.blueprints.${tenant}.${product}.${environment}.${solution}.${segment}.blueprint %}
EOF

jq --arg tenant "${tenant}" --arg product "${product}" --arg environment "${environment}" --arg solution "${solution}" --arg segment "${segment}" \
'.Tenants[0].Id = ($tenant) | .Tenants[0].Products[0].Id = ($product) | .Tenants[0].Products[0].Environments[0].Id = ($environment) | .Tenants[0].Products[0].Environments[0].Solutions[0].Id = ($solution) | .Tenants[0].Products[0].Environments[0].Solutions[0].Segments[0].Id = ($segment)' \
< ../scripts/nav_template.json > _data/nav-${tenant}-${product}-${environment}-${solution}-${segment}.json

done




# Create a navigation file from the blueprints 

# Run the build
jekyll build --verbose