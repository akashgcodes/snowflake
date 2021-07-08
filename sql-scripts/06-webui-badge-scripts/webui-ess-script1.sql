//check for all 3 databases
//The SNOWFLAKE database will only be visible if your worksheet role context is set to ACCOUNTADMIN 
// or if you have modified privileges to that database
Select 'databases' as category,count(*) as found, '3' as expected
from SNOWFLAKE.INFORMATION_SCHEMA.DATABASES
where DATABASE_NAME IN 
('USDA_NUTRIENT_STDREF','LIBRARY_CARD_CATALOG','SOCIAL_MEDIA_FLOODGATES')
UNION
//Check for necessary tables in USDA database
Select 'usda tables' as category,count(*) as found, '5' as expected
FROM USDA_NUTRIENT_STDREF.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('FD_GROUP_INGEST', 'FD_GROUP', 'WEIGHT_INGEST','WEIGHT','LANGDESC')
AND TABLE_SCHEMA = 'PUBLIC'
UNION
//Check for necessary tables in LIBRARY CARD CATALOG database
Select 'library card catalog tables' as category,count(*) as found, '6' as expected
FROM LIBRARY_CARD_CATALOG.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN 
('BOOK','AUTHOR','BOOK_TO_AUTHOR','AUTHOR_INGEST_XML','AUTHOR_INGEST_JSON','NESTED_INGEST_JSON')
AND TABLE_SCHEMA = 'PUBLIC'
UNION
Select 'social media floodgates tables' as category,count(*) as found, '1' as expected
FROM SOCIAL_MEDIA_FLOODGATES.INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME IN ('TWEET_INGEST')
AND TABLE_SCHEMA = 'PUBLIC'
UNION
Select 'stages' as category, COUNT(*) as found, '1' as expected
from"USDA_NUTRIENT_STDREF"."INFORMATION_SCHEMA"."STAGES"
WHERE STAGE_NAME = 'MY_S3_BUCKET'
AND STAGE_SCHEMA = 'PUBLIC'
UNION
Select 'usda file formats' as category, COUNT(*) as found, '1' as expected
from"USDA_NUTRIENT_STDREF"."INFORMATION_SCHEMA"."FILE_FORMATS"
WHERE FILE_FORMAT_NAME in ('USDA_FILE_FORMAT')
AND FILE_FORMAT_SCHEMA = 'PUBLIC'
union
Select 'library file formats' as category, COUNT(*) as found, '2' as expected
from"LIBRARY_CARD_CATALOG"."INFORMATION_SCHEMA"."FILE_FORMATS"
WHERE FILE_FORMAT_NAME in ('JSON_FILE_FORMAT','XML_FILE_FORMAT')
AND FILE_FORMAT_SCHEMA = 'PUBLIC'
union
Select 'stages' as category, COUNT(*) as found, '1' as expected
from"USDA_NUTRIENT_STDREF"."INFORMATION_SCHEMA"."STAGES"
WHERE STAGE_NAME ='MY_S3_BUCKET'
AND STAGE_SCHEMA = 'PUBLIC'
UNION
Select 'sequences' as category, COUNT(*) as found, '2' as expected
from"LIBRARY_CARD_CATALOG"."INFORMATION_SCHEMA"."SEQUENCES"
WHERE SEQUENCE_NAME IN ('SEQ_AUTHOR_UID','SEQ_BOOK_UID')
AND SEQUENCE_SCHEMA = 'PUBLIC'
UNION
Select 'views' as category, COUNT(*) as found, '1' as expected
from"SOCIAL_MEDIA_FLOODGATES"."INFORMATION_SCHEMA"."VIEWS"
WHERE TABLE_NAME IN ('HASHTAGS_NORMALIZED')
AND TABLE_SCHEMA = 'PUBLIC'