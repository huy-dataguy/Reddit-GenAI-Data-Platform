FROM sparkbase

USER sparkuser
WORKDIR /home/sparkuser


RUN cp spark/yarn/spark-*-yarn-shuffle.jar hadoop/share/hadoop/yarn/lib/

COPY config/spark_on_YARN/worker/hdfs-site.xml hadoop/etc/hadoop/hdfs-site.xml

USER root
RUN apt-get update && \
    apt-get install -y wget -y openjdk-17-jdk vim ssh openssh-server telnet iputils-ping net-tools dos2unix

COPY config/spark_on_YARN/entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]