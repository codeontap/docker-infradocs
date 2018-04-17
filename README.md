# CodeOnTap InfraDocs

InfraDocs is a Jekyll based site which provides an outline of infrastructure components that have been deployed by CodeOnTap. The uses CodeOnTap Blueprint files to generate the documentation, multiple blueprints can be served from the same infradocs instance.  The intention of the site is that it is hosted with an automation server or a central architecture site. 

## Usage

Generate Blueprint files and place them within a central folder. All files should be named based on the deployment that generated them following the following structure

```
<Tenant>-<Product>-<Environment>-<Segment>-blueprint.json
```

Once you have the folder created then mount this volume to /indir on the codeontap/infradocs container. Using this blueprint structure the site will be built and available for hosting in the /outdir of the container