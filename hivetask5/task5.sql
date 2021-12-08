ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;
ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
ADD FILE udf.py;

USE kokrjashkinma;

SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.max.dynamic.partitions=100000;
SET hive.exec.max.dynamic.partitions.pernode=100000;

SELECT Transform(*)
using 'python3 udf.py' as (ip, date, request, page_size, http_code, meta) FROM Logs LIMIT 10;

