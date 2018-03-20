FROM jekyll/builder:latest

LABEL MAINTAINER="codeontap"

RUN apk update
RUN apk upgrade
RUN apk add bash
RUN apk add jq

RUN mkdir /indir
RUN mkdir /outdir

RUN chmod ugo+rwx /indir
RUN chmod ugo+rwx /outdir

RUN mkdir /srv/jekyll/blueprints
RUN mkdir /srv/jekyll/_site 

VOLUME /outdir
VOLUME /indir 

COPY ./src /srv/jekyll
COPY ./scripts/build-infradocs.sh /tmp/build-infradocs.sh
COPY ./scripts/nav_template.json /tmp/nav_template.json

CMD ["bash", "/tmp/build-infradocs.sh"]
