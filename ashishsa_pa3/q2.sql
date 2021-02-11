WITH RECURSIVE natural_sequence AS (
    SELECT 0 AS n,0 AS m,0 AS m1
    UNION 
    SELECT n+1,
    CASE	
		WHEN n+1 <= 1 THEN n+1
        WHEN n+1 > 1 AND mod(m,2)<>0 THEN  m+m1
        ELSE m+m1+1
    END AS m,m AS m1 FROM natural_sequence WHERE n<10)SELECT n, m as 'f(n)' FROM natural_sequence;