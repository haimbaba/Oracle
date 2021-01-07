-- Create the user 
create user haim
  identified by haim
  default tablespace USERS
  temporary tablespace TEMP
  profile DEFAULT
  quota unlimited on users;
-- Grant/Revoke system privileges 
grant administer database trigger to haim;
grant create any sequence to haim;
grant create procedure to haim;
grant create session to haim;
grant create table to haim;
grant create trigger to haim;
grant create view to haim;
--End
