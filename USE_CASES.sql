#primo use-case
SELECT 
    name
FROM
    content
WHERE
    ID IN (SELECT 
            content_ID
        FROM
            rate
        WHERE
            value >= 4)
        AND type = 'single';

#secondo use-case
SELECT 
    name
FROM
    content
WHERE
    upload_date >= (DATE_SUB(CURRENT_DATE(),
        INTERVAL 3 MONTH))
        OR genre = 'pop'; 

# terzo use-case
SELECT 
    *
FROM
    (SELECT 
        email,
            CASE
                WHEN sp.type = 'weekly' THEN DATE_ADD(start_date, INTERVAL 7 DAY)
                WHEN sp.type = 'monthly' THEN DATE_ADD(start_date, INTERVAL 1 MONTH)
                WHEN sp.type = 'yearly' THEN DATE_ADD(start_date, INTERVAL 1 YEAR)
            END AS subscription_end_date,
            name
    FROM
        customer c
    JOIN subscription s ON c.ID = s.customer_ID
    JOIN subscription_plan sp ON s.subscription_ID = sp.ID) AS derived
WHERE
    subscription_end_date >= CURRENT_DATE()
        AND subscription_end_date <= DATE_ADD(CURRENT_DATE(),
        INTERVAL 31 DAY);

#quarto use-case
select customer.ID as cust, content.ID as cont from content inner join
(SELECT t.genre, t.customer_ID, t.cont_count
	FROM 
    (SELECT genre, customer_ID, cont_count,ROW_NUMBER() OVER 
    (PARTITION BY customer_ID ORDER BY cont_count DESC) AS rn 
		FROM 
		(SELECT COUNT(*) AS cont_count, genre, customer_ID 
			FROM
			(SELECT customer_ID, content_ID, name, genre, fullname FROM customer cu 
			LEFT JOIN listen li ON cu.ID = li.customer_ID
			JOIN content co ON content_ID = co.ID) AS a
			GROUP BY genre, customer_ID
			ORDER BY cont_count desc
		) as n
	) AS t WHERE t.rn = 1
) as tot on tot.genre=content.genre 
inner join customer on tot.customer_ID=customer.ID
where (content.ID, customer.ID) not in (select content_ID, customer_ID from listen);