FROM trinodb/trino:476

# Đồng thời cũng thêm vào plugin Iceberg vì Trino Iceberg không tự chia sẻ classpath
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.6/hadoop-aws-3.3.6.jar /usr/lib/trino/plugin/iceberg/
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.6/hadoop-common-3.3.6.jar /usr/lib/trino/plugin/iceberg/
ADD https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/3.3.6/hadoop-auth-3.3.6.jar /usr/lib/trino/plugin/iceberg/
ADD https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.1026/aws-java-sdk-bundle-1.11.1026.jar /usr/lib/trino/plugin/iceberg/
