-- Create table
create table IMAGE_DATA
(
  COL1 NUMBER(10),
  COL2 BLOB
);


-- Create Procedure
CREATE OR REPLACE Procedure Dpr_fileToBlob(Fname in VARCHAR2, Fdir in VARCHAR2, OutBlob out BLOB)

 IS

 fblob               BLOB;
 theBFile            BFILE;

 Bsrc_offset         NUMBER :=1;
Bdest_offset        NUMBER :=1;

BEGIN

dbms_lob.createtemporary(fblob,FALSE,DBMS_LOB.SESSION);

theBFile := BFileName(Fdir,Fname);

 dbms_lob.fileOpen(theBFile);

 dbms_lob.loadblobfromfile(dest_lob    => fblob     ,
                              src_bfile   => theBFile  ,
                              amount      => dbms_lob.getLength(theBFile),
                              dest_offset => Bdest_offset,
                              src_offset  => Bsrc_offset
                              );

 dbms_lob.fileClose(theBFile);

 OutBlob := fblob;

End;

-- Oracle DIRECTORIES

SELECT * FROM DBA_DIRECTORIES;  -- only from sys DBA
-- jpg file must be in dierctory on oracle server

-- Create dierctory
CREATE DIRECTORY BLOB_DATA AS '/oracle/app/oracle/oradata/ETLTEST/blob_data';
-- ETLTEST Database name
-- Windows Path CREATE DIRECTORY BLOB_DATA AS 'D:\images';

-- located jpg file in DIRECTORY (example haim.jpg)

--insert to table 

Declare
vImage blob;
Begin
Dpr_fileToBlob(Fname=> 'haim.jpg', -- Chagne Picture name
               Fdir => 'BLOB_DATA', -- DIRECTORY name
               OutBlob=>  vImage);
               
INSERT INTO IMAGE_DATA
       (col1,
        col2)
     select 
        1,
        vImage
        from dual;
commit;        
End;
