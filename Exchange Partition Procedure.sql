CREATE OR REPLACE PROCEDURE PR_EXCHANGE_PARTITION(P_TRG_OWNER IN VARCHAR2,P_TRG_TABLE IN VARCHAR2,
                                                               P_SRC_OWNER IN VARCHAR2,P_SRC_TABLE IN VARCHAR2,
                                                               /*AUTHID CURRENT_USER  */
                                                               PARTITION_NAME IN VARCHAR2)

IS
V_TXT VARCHAR2(500);


BEGIN


      -- EXCHANGE PARTITION
      V_TXT := 'ALTER TABLE ' ||P_TRG_OWNER||'.'||P_TRG_TABLE || ' EXCHANGE PARTITION ' ||
       PARTITION_NAME || ' WITH TABLE ' ||P_SRC_OWNER||'.'||P_SRC_TABLE || ' WITH VALIDATION UPDATE GLOBAL INDEXES';
      DBMS_OUTPUT.put_line (V_TXT) ;

      EXECUTE IMMEDIATE V_TXT ;

--==============================================================
   --rebuild index
--=========
   -- src_table
     ETL.P_Rebuild_index(P_SRC_OWNER,P_SRC_TABLE,PARTITION_NAME,Null);

     --trg_table
      ETL.P_Rebuild_index(P_TRG_OWNER,P_TRG_TABLE,PARTITION_NAME,Null);
 --==============================================================

End PR_EXCHANGE_PARTITION ;



-- SRC Table And TRG Table have same structure
-- SRC Table should be partition object
-- TRG Table Not partition object