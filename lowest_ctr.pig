
data = LOAD '/dualcore/ad_data[12]' AS (campaign_id:chararray, date:chararray, time:chararray, keyword:chararray, display_site:chararray, placement:chararray, was_clicked:int, cpc:int);

grouped = GROUP data BY display_site;

by_site = FOREACH grouped {
  clicked_ads = FILTER data BY was_clicked == 1;
  total_ads = COUNT(data);
  total_clicks = COUNT(clicked_ads);
  GENERATE group AS display_site, (total_clicks / (double)total_ads) AS ctr;
}

sorted_ctr = ORDER by_site BY ctr ASC;
top_three_lowest_ctr = LIMIT sorted_ctr 3;

DUMP top_three_lowest_ctr;

