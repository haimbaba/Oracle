
select lead(t.empid, 1, null) over (order by t.empid asc) as next_empid,t.*

from ( select * from employees) t

---------------------------

select lag(t.empid, 1, null) over (order by t.empid asc) as next_empid,t.*

from ( select * from employees) t