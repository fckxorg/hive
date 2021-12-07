ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/hive-contrib.jar;
ADD jar /opt/cloudera/parcels/CDH/lib/hive/lib/hive-serde.jar;
USE kokrjashkinma;

SET hive.exec.dynamic.partition.mode=nonstrict;
SET hive.exec.max.dynamic.partitions=100000;
SET hive.exec.max.dynamic.partitions.pernode=100000;

DROP TABLE IF EXISTS user_logs;
DROP TABLE IF EXISTS Logs;
DROP TABLE IF EXISTS Subnets;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS IPRegions;

CREATE EXTERNAL TABLE user_logs (
	    ip STRING,
	    date INT,
	    request STRING,
	    page_size SMALLINT,
	    http_code SMALLINT,
	    meta STRING
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
	    "input.regex" = '^(\\S+)\\t{3}(\\d{8})\\d+\\t(\\S+)\\t(\\d+)\\t(\\d+)\\t([^\n]*)'
)
STORED AS TEXTFILE
LOCATION '/data/user_logs/user_logs_M';

CREATE EXTERNAL TABLE Logs (
	    ip STRING,
	    request STRING,
	    page_size SMALLINT,
	    http_code SMALLINT,
	    meta STRING
)
PARTITIONED BY (date INT)
STORED AS TEXTFILE;

INSERT OVERWRITE TABLE Logs PARTITION (date)
SELECT ip, request, page_size, http_code, meta, date FROM user_logs;

CREATE EXTERNAL TABLE Subnets (
	    ip STRING,
	    mask STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY  '\t'
STORED AS TEXTFILE
LOCATION '/data/subnets/variant3';

CREATE EXTERNAL TABLE Users (
	    ip STRING,
	    browser STRING,
	    sex STRING,
	    age TINYINT
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY  '\t'
STORED AS TEXTFILE
LOCATION '/data/user_logs/user_data_M';

CREATE EXTERNAL TABLE IPRegions (
	    ip STRING,
	    region STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY  '\t'
STORED AS TEXTFILE
LOCATION '/data/user_logs/ip_data_M';

SELECT * FROM Logs LIMIT 10;
SELECT * FROM Subnets LIMIT 10;
SELECT * FROM Users LIMIT 10;
SELECT * FROM IPRegions LIMIT 10;

