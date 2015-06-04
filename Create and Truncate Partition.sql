-- Create table
create table TEST_PARTITION
(
  ISPROCESS INTEGER
)
partition by list (ISPROCESS)
(
  partition P0 values (0)
    tablespace USERS
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 64K
      next 1M
      minextents 1
      maxextents unlimited
    ),
  partition P1 values (1)
    tablespace USERS
    pctfree 10
    initrans 1
    maxtrans 255
    storage
    (
      initial 64K
      next 1M
      minextents 1
      maxextents unlimited
    )
)
;

-- Create Table with 2 partition 
--P0 - Can insert only 0
--P1 - Can Insert Only 1

-- insert data
insert into TEST_PARTITION(ISPROCESS) values (0);
insert into TEST_PARTITION(ISPROCESS) values (0);
insert into TEST_PARTITION(ISPROCESS) values (0);
insert into TEST_PARTITION(ISPROCESS) values (0);
insert into TEST_PARTITION(ISPROCESS) values (1);
insert into TEST_PARTITION(ISPROCESS) values (1);
insert into TEST_PARTITION(ISPROCESS) values (1);
insert into TEST_PARTITION(ISPROCESS) values (1);
commit;

-- show data
select * from test_partition;


-- Insert Data to partition not exists
insert into TEST_PARTITION(ISPROCESS) values (5);

-- Get Error = ORA-14400: inserted partition key does not map to any partition 



ALTER TABLE  test_partition TRUNCATE PARTITION P0;
-- show data only 1 exists
select * from test_partition;
