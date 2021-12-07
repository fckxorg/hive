ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;
ADD jar /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE kokrjashkinma;

SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.max.dynamic.partitions=100000;
SET hive.exec.max.dynamic.partitions.pernode=100000;

SELECT split(meta, '[ ]')[0], count(meta) as counts FROM Logs
GROUP BY split(meta, '[ ]')[0]
ORDER BY counts DESC;
