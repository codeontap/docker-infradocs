# CodeOnTap InfraDocs

InfraDocs is a Jekyll based site which provides an outline of infrastructure components that have been deployed by CodeOnTap. The uses CodeOnTap Blueprint files to generate the documentation, multiple blueprints can be served from the same infradocs instance.  The intention of the site is that it is hosted with an automation server or a central architecture site. 

## Usage

Generate Blueprint files and place them within a central folder. All files should be named based on the deployment that generated them following the following structure

```
<Tenant>-<Product>-<Environment>-<Segment>-blueprint.json
```

Once you have the folder created then mount this volume to /indir on the codeontap/infradocs container. Using this blueprint structure the site will be built and available for hosting in the /outdir of the container

While the blueprint file generates the HTML pages used on the site we also save the raw blueprint file that generates the site so that more information can be found or you can use the blueprint for other reasons. When you are on a deployment diagram page change the index.html in your path to blueprint.json to get the blueprint file.

## Local Hosting

Jekyll also has a built in server for local development or quickly hosting the site. To use this for infradocs you can run the following command

```sh 
docker run -it --volume <Your Blueprint Directory>:/indir --env OUTPUT=serve -p 4000:4000 codeontap/infradocs:latest
```

Your blueprint directory is the location of your blueprint files. For most codeontap deployments this will be the `blueprints/content/` directory in your `automation-registry` repository.

This will launch as an interactive docker container, remove the -it flag to run the container as a service. 

If the blueprint files are updated the site will automatically rebuild and update the site.