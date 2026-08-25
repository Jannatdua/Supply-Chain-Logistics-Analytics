
-- Q1. What is the overall supply chain performance?

-- SELECT
--     COUNT(*) AS total_orders,
--     COUNT(DISTINCT customer_id) AS total_customers,
--     COUNT(DISTINCT supplier_id) AS total_suppliers,
--     ROUND(SUM(order_value_usd), 2) AS total_order_value,
--     ROUND(AVG(order_value_usd), 2) AS avg_order_value,
--     ROUND(AVG(lead_time_days), 2) AS avg_lead_time,
--     ROUND(AVG(payment_delay_days), 2) AS avg_payment_delay,
--     ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction
-- FROM supply_chain_data;


-- Q2. Which markets contribute the most business value?

-- SELECT
--     market_segment,
--     COUNT(order_id) AS total_orders,
--     ROUND(SUM(order_value_usd), 2) AS total_order_value,
--     ROUND(AVG(order_value_usd), 2) AS avg_order_value
-- FROM supply_chain_data
-- GROUP BY market_segment
-- ORDER BY total_order_value DESC;

-- Q3. Which suppliers are most important based on order volume and value?

-- SELECT
--     supplier_id,
--     COUNT(order_id) AS total_orders,
--     ROUND(SUM(order_value_usd), 2) AS total_order_value,
--     ROUND(AVG(order_value_usd), 2) AS avg_order_value
-- FROM supply_chain_data
-- GROUP BY supplier_id
-- ORDER BY total_order_value DESC;

-- Q4. Which suppliers may require attention because of longer fulfillment times?

-- SELECT
--     supplier_id,
--     ROUND(AVG(lead_time_days), 2) AS avg_lead_time,
--     MIN(lead_time_days) AS min_lead_time,
--     MAX(lead_time_days) AS max_lead_time,
--     COUNT(order_id) AS total_orders
-- FROM supply_chain_data
-- GROUP BY supplier_id
-- ORDER BY avg_lead_time DESC;


-- Q5. Do customers associated with longer lead times report lower satisfaction or require more support?

-- SELECT
--     lead_time_category,
--     COUNT(order_id) AS total_orders,
--     ROUND(AVG(lead_time_days), 2) AS avg_lead_time,
--     ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction,
--     ROUND(AVG(support_tickets), 2) AS avg_support_tickets
-- FROM supply_chain_data
-- GROUP BY lead_time_category
-- ORDER BY avg_lead_time;

-- Q6. Which market segments require relatively higher acquisition spending compared with the order value they generate?
 
-- SELECT
--     market_segment,
--     ROUND(AVG(acquisition_cost_usd), 2) AS avg_acquisition_cost,
--     ROUND(AVG(order_value_usd), 2) AS avg_order_value,
--     ROUND(
--         AVG(acquisition_cost_usd) / AVG(order_value_usd) * 100,
--         2
--     ) AS acquisition_cost_ratio_pct
-- FROM supply_chain_data
-- GROUP BY market_segment
-- ORDER BY acquisition_cost_ratio_pct DESC;

-- Q7. Which orders have potentially high payment delays?
-- SELECT
--     order_id,
--     customer_id,
--     supplier_id,
--     order_value_usd,
--     payment_delay_days,
--     CASE
--         WHEN payment_delay_days <= 30 THEN 'Normal'
--         ELSE 'High Delay'
--     END AS payment_status
-- FROM supply_chain_data
-- ORDER BY payment_delay_days DESC; 

-- Q8. Does higher support activity correspond to lower customer satisfaction?

-- SELECT
--     CASE
--         WHEN support_tickets = 0 THEN 'No Tickets'
--         WHEN support_tickets = 1 THEN '1 Ticket'
--         ELSE '2+ Tickets'
--     END AS support_group,
--     COUNT(*) AS total_customers,
--     ROUND(AVG(satisfaction_score), 2) AS avg_satisfaction,
--     ROUND(AVG(lead_time_days), 2) AS avg_lead_time
-- FROM supply_chain_data
-- GROUP BY support_group
-- ORDER BY avg_satisfaction DESC;

-- Q9. Which suppliers generate an average order value above the overall company average? 

-- SELECT
--     supplier_id,
--     ROUND(AVG(order_value_usd), 2) AS avg_order_value
-- FROM supply_chain_data
-- GROUP BY supplier_id
-- HAVING AVG(order_value_usd) >
--        (SELECT AVG(order_value_usd)
--         FROM supply_chain_data)
-- ORDER BY avg_order_value DESC;

-- Q10. How do suppliers rank based on their contribution to total order value?

-- SELECT
--     supplier_id,
--     ROUND(SUM(order_value_usd), 2) AS total_order_value,
--     RANK() OVER (
--         ORDER BY SUM(order_value_usd) DESC
--     ) AS supplier_rank
-- FROM supply_chain_data
-- GROUP BY supplier_id;

-- Q11. Who is the highest-value supplier within each market segment?

-- SELECT
--     market_segment,
--     supplier_id,
--     ROUND(SUM(order_value_usd), 2) AS total_order_value,
--     RANK() OVER (
--         PARTITION BY market_segment
--         ORDER BY SUM(order_value_usd) DESC
--     ) AS supplier_rank
-- FROM supply_chain_data
-- GROUP BY
--     market_segment,
--     supplier_id
-- ORDER BY
--     market_segment,
--     supplier_rank;
 









