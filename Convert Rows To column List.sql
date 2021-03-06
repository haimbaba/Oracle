WITH T AS
(
SELECT 1 ID , 'ROW 1' NAME FROM DUAL
UNION
SELECT 1 ID, 'ROW 2' NAME FROM DUAL
UNION
SELECT 1 ID, 'ROW 3' NAME FROM DUAL
)

SELECT T.ID,
DBMS_LOB.SUBSTR(WM_CONCAT(T.NAME))
FROM T
GROUP BY ID
  