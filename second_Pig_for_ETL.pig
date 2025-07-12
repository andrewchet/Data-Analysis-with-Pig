-- Load data from dualcore file

data = LOAD '/dualcore/ad_data2.txt' 
       USING PigStorage(',') 
       AS (campaign_id:chararray, date:chararray, time:chararray, display_site:chararray, placement:chararray, was_clicked:int, cpc:int, keyword:chararray);

-- remove duplicates for unique entries

unique_data = DISTINCT data;

-- reorder anf clean data for uniformity

reordered_data = FOREACH unique_data GENERATE 
                 campaign_id, REPLACE(date, '-', '/') AS date, time, 
                 UPPER(TRIM(keyword)) AS keyword, 
                 display_site, placement, was_clicked, 
                 (int) cpc AS cpc;

-- store the new data for processing

STORE reordered_data INTO '/dualcore/ad_data2' USING PigStorage('\t');

