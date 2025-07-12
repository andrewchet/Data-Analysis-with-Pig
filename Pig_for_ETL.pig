-- Load data for Pig

data = LOAD '/dualcore/ad_data1.txt' 
       USING PigStorage('\t') 
       AS (keyword:chararray, campaign_id:chararray, date:chararray, time:chararray, display_site:chararray, was_clicked:int, cpc:int, country:chararray, placement:chararray);

-- Filter to only allow data that has country set to USA

usa_data = FILTER data BY country == 'USA';

-- Change feild order to allow for more unified structure

reordered_data = FOREACH usa_data GENERATE 
                 campaign_id, date, time, 
                 UPPER(TRIM(keyword)) AS keyword, 
                 display_site, placement, 
                 (int) was_clicked AS was_clicked, 
                 (int) cpc AS cpc;

-- Store back the output to use in future projects

STORE reordered_data INTO '/dualcore/ad_data1' USING PigStorage('\t');
