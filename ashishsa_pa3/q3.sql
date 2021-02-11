WITH RECURSIVE natural_sequence AS
  ( SELECT 1 AS m,1 AS n, 1 AS 'm*n'    
    UNION 
    SELECT m, n + 1, m*(n+1) FROM natural_sequence    
    WHERE n<9
    UNION 
    SELECT m+1, n , (m+1)*n FROM natural_sequence    
    WHERE m<9 and n<10
  )
SELECT * FROM natural_sequence;



