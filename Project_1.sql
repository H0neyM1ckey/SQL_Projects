SELECT c.id, c.name, c.city, c.zipcode, agg.total_requests, agg.avg_wait_time 
FROM(SELECT request_history.customer_id, 
   AVG(DATEDIFF(MINUTE, request_time, complete_time)) AS avg_wait_time,
   COUNT(request_id) AS total_requests
FROM request_history
GROUP BY request_history.customer_id) agg
JOIN customer c
ON c.id = agg.customer_id;




SELECT DISTINCT c.city, c.state, agg.zipcode, agg.total_requests, agg.avg_wait_time
FROM
(SELECT
   customer.zipcode AS zipcode, 
   AVG(DATEDIFF(MINUTE, request_time, complete_time)) AS avg_wait_time, 
   COUNT(request_id) AS total_requests
FROM request_history, customer
WHERE request_history.customer_id = customer.id
GROUP BY customer.zipcode) agg
JOIN customer c
ON c.zipcode = agg.zipcode
ORDER BY agg.avg_wait_time DESC