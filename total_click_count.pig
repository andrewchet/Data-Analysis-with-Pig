-- Load data from the needed directories

data = LOAD '/dualcore/ad_data[12]' AS (campaign_id:chararray, date:chararray, time:chararray, keyword:chararray, display_site:chararray, placement:chararray, was_clicked:int, cpc:int);

-- FIlter record for only the ones clicked

clicked = FILTER data BY was_clicked == 1;

-- Group and sum the clicked records

grouped_data = GROUP clicked ALL;
total_clicks = FOREACH grouped_data GENERATE COUNT(clicked) AS click_count;

DUMP total_clicks;



