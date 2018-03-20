FROM jekyll/builder:latest

LABEL MAINTAINER="codeontap"

RUN mkdir /srv/jekyll/blueprints
RUN mkdir /srv/jekyll/_site 

VOLUME  /srv/jekyll/blueprints
VOLUME /srv/jekyll/_site

COPY ./src /srv/jekyll
COPY ./scripts/build-infradocs.sh /srv/jekyll/build-infradocs.sh
COPY ./scripts/nav_template.json /srv/jekyll/nav_template.json

CMD ["sh", "/srv/jekyll/build-infradocs.sh"]
