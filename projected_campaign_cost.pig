-- Load data from the two directories within dualcore

data = LOAD '/dualcore/ad_data[12]' AS (campaign_id:chararray, date:chararray, time:chararray, keyword:chararray, display_site:chararray, placement:chararray, was_clicked:int, cpc:int);

-- Caculate projected maximu cost

max_cpc = FOREACH (GROUP data ALL) GENERATE MAX(data.cpc) * 50000 AS projected_cost;

-- Output result

DUMP max_cpc;




