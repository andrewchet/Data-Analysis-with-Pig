-- The first step is to load the data and replace the widcard with a specific path

data = LOAD '/dualcore/ad_data*'
        
       AS (campaign_id:chararray, date:chararray, time:chararray, keyword:chararray, display_site:chararray, placement:chararray, was_clicked:int, cpc:int);



-- Filter data set to keep records that were clicked

clicked_data = FILTER data BY was_clicked == 1;


-- Then Group the clicked data by display site

site_group = GROUP clicked_data BY display_site;



total_cost_per_site = FOREACH site_group GENERATE 
                      group AS display_site, 
                      SUM(clicked_data.cpc) AS total_cost;


-- Sort in ascending order to find lowest cost

low_cost_sites = ORDER total_cost_per_site BY total_cost ASC;


-- Store the top three loest cost sites

top_three_low_cost_sites = LIMIT low_cost_sites 3;

STORE top_three_low_cost_sites INTO '/dualcore/low_cost_sites' USING PigStorage('\t');


