FROM jekyll/builder:latest

LABEL MAINTAINER="codeontap"

RUN mkdir /srv/jekyll/blueprints

VOLUME  /srv/jekyll/blueprints

COPY ./src /srv/jekyll
COPY ./scripts/build-infradocs.sh /srv/jekyll/build-infradocs.sh

CMD ["sh", "/srv/jekyll/build-infradocs.sh"]
