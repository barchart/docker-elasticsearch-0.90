#
# Elasticsearch Node
#
# docker-build properties:
# TAG=barchart/elasticsearch-aws:0.90-latest

FROM barchart/java
MAINTAINER Jeremy Jongsma "jeremy@barchart.com"

# Download version 0.90.x of elasticsearch
RUN wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - && \
	add-apt-repository -y "deb http://packages.elasticsearch.org/elasticsearch/0.90/debian stable main" && \
	apt-get -y update && \
	apt-get -y install elasticsearch && \
	/usr/share/elasticsearch/bin/plugin install elasticsearch/elasticsearch-cloud-aws/1.16.0 && \
	apt-get clean

ADD elasticsearch/ /etc/elasticsearch
ADD bin/elasticsearch-run /usr/local/bin/elasticsearch-run

EXPOSE 9200
EXPOSE 9300

VOLUME ["/elasticsearch"]

CMD ["/usr/local/bin/elasticsearch-run"]
