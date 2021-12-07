ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;
ADD jar /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE kokrjashkinma;

SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.max.dynamic.partitions=100000;
SET hive.exec.max.dynamic.partitions.pernode=100000;

SELECT l.http_code, COUNT(CASE WHEN u.sex = 'male' THEN 1 END), COUNT(CASE WHEN u.sex = 'female' THEN 1 END)
FROM Logs l INNER JOIN Users u
ON l.ip = u.ip
GROUP BY l.http_code;
