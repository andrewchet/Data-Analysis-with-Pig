-- Load advertising data

data = LOAD '/dualcore/ad_data*'
       USING PigStorage('\t') 
       AS (campaign_id:chararray, date:chararray, time:chararray, keyword:chararray, display_site:chararray, placement:chararray, was_clicked:int, cpc:int);

-- Filter the data to retain only important rows

clicked_data = FILTER data BY was_clicked == 1;

-- Group keywords

keyword_group = GROUP clicked_data BY keyword;

-- Calculate total cost and store

total_cost_per_keyword = FOREACH keyword_group GENERATE 
                         group AS keyword, 
                         SUM(clicked_data.cpc) AS total_cost;

high_cost_keywords = ORDER total_cost_per_keyword BY total_cost DESC;

top_five_high_cost_keywords = LIMIT high_cost_keywords 5;

STORE top_five_high_cost_keywords INTO '/dualcore/high_cost_keywords' USING PigStorage('\t');

