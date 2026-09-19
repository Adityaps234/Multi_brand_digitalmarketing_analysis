-- 1. Identify which brand generated the most overall revenue and conversions.

/*SELECT 
    Brand, 
    SUM(revenue) AS Total_Revenue,
    SUM(conversions) AS Total_Conversions
FROM marketing_master
GROUP BY Brand
ORDER BY Total_Revenue DESC;*/

-- 2. Determine which marketing channel drove the highest traffic (clicks and impressions).

/*SELECT 
    Channel_Used, 
    SUM(clicks) AS Total_Clicks,
    SUM(Impressions) AS Total_Impressions
FROM marketing_master
GROUP BY Channel_Used
ORDER BY Total_Clicks DESC;*/

-- 3. Calculate the average Return on Investment (ROI) for each type of campaign.

/*SELECT 
    Campaign_Type, 
    ROUND(AVG(ROI),2) AS Average_ROI
FROM marketing_master
GROUP BY Campaign_Type
ORDER BY Average_ROI DESC;*/

-- 4. Evaluate profitability by calculating Net Profit and Customer Acquisition Cost (CAC) per channel.

/*SELECT 
    Channel_Used,
    SUM(revenue) - SUM(acquisition_cost) AS Net_Profit,
    ROUND((SUM(acquisition_cost) / NULLIF(SUM(conversions), 0)), 2) AS Cost_Per_Conversion
FROM marketing_master
GROUP BY Channel_Used
ORDER BY Net_Profit DESC;*/

-- 5. Segment campaigns by engagement scores to see if higher engagement drives better ROI.

/*SELECT 
    CASE 
        WHEN Engagement_score >= 8 THEN 'High Engagement'
        WHEN Engagement_score >= 5 THEN 'Medium Engagement'
        ELSE 'Low Engagement' 
    END AS Engagement_Tier,
    COUNT(Campaign_ID) AS Total_Campaigns,
    SUM(revenue) AS Total_Revenue,
    ROUND(AVG(ROI), 2) AS Average_ROI
FROM marketing_master
GROUP BY Engagement_Tier
ORDER BY Total_Revenue DESC;*/

-- 6. Rank campaigns to find the top 3 highest-earning campaigns for each individual brand.

-- 7. Map the complete customer journey to calculate drop-off rates from impression to final sale.

/*SELECT 
    Brand,
    SUM(Impressions) AS Total_Impressions,
    SUM(clicks) AS Total_Clicks,
    ROUND((SUM(clicks) / NULLIF(SUM(Impressions), 0)) * 100, 2) AS Click_Through_Rate,
    SUM(leads) AS Total_Leads,
    ROUND((SUM(leads) / NULLIF(SUM(clicks), 0)) * 100, 2) AS Lead_Conversion_Rate,
    SUM(conversions) AS Total_Conversions,
    ROUND((SUM(conversions) / NULLIF(SUM(leads), 0)) * 100, 2) AS Final_Conversion_Rate
FROM marketing_master
GROUP BY Brand;*/

-- 8. Smooth out daily revenue volatility using a 7-day rolling average trend line.

/*SELECT 
    Date,
    SUM(revenue) AS Daily_Revenue,
    ROUND(AVG(SUM(revenue)) OVER (
        ORDER BY Date 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2) AS Rolling_7_Day_Avg_Revenue
FROM marketing_master
GROUP BY Date
ORDER BY Date;*/

-- 9. Calculate the Month-Over-Month (MoM) revenue growth percentage for executive reporting.

/*WITH Monthly_Data AS (
    SELECT 
        TO_CHAR(Date, 'YYYY-MM') AS Promo_Month,
        SUM(revenue) AS Monthly_Revenue
    FROM marketing_master
    GROUP BY TO_CHAR(Date, 'YYYY-MM')
)
SELECT 
    Promo_Month,
    Monthly_Revenue,
    LAG(Monthly_Revenue) OVER(ORDER BY Promo_Month) AS Previous_Month_Revenue,
    ROUND(
        ((Monthly_Revenue - LAG(Monthly_Revenue) OVER(ORDER BY Promo_Month)) / 
        NULLIF(LAG(Monthly_Revenue) OVER(ORDER BY Promo_Month), 0)) * 100, 
    2) AS MoM_Growth_Percentage
FROM Monthly_Data;*/