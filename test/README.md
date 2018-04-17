# Testing and Development

The intention of the infradocs container is to take a collection of blueprint json files generated using codeontap, copy these files to the appropriate locations and generate a new JSON file for the navigation menu. 

## Usage

### Infradocs Build Process 

To test the full infradocs process 

1. Clone this repo down
3. cd into the repo
2. Run the docker build
```sh 
docker build -t infradocs .
```
3. Run the container with the following properties 
```sh

docker run \
--volume="<Working Directory>/test/:/indir" \
--volume="<Working Directory>/cache:/usr/local/bundle" \
--volume="<Working Directory>/outdir:/outdir" \
infradocs
``` 
4. The Jekyll site will then be saved to the ./outdir directory 
5. The site can then be hosted using an nginx container 
```sh
docker run --name static-nginx -d -p 80:80 -v <Working Directory>/outdir:/usr/share/nginx/html:ro nginx
```
6. To update the site update the contents of the src directory re run the build and rerun the docker run to generate the site.

### Jekyll Only Site
If you just want to work on the Jekyll site with some test data 

1. Clone down the repo 
2. From in the repo run the following  
```sh 
mv src/_data/blueprints/msw_example src/_data/blueprints/msw
mv src/_data/blueprint_nav_example.json src/_data/blueprint_nav.json
mv src/blueprints/msw_example src/blueprints/msw
```
3. This will enable the test data 
4. Run Jekyll serve from the src directory to get going