 IDENTIFICATION DIVISION.
 PROGRAM-ID. READSTMT.
 ENVIRONMENT DIVISION.
    INPUT-OUTPUT SECTION.
       FILE-CONTROL.
          SELECT SOMEFILE1 ASSIGN TO 'somefile1.txt'.
 DATA DIVISION.
    WORKING-STORAGE SECTION.
       01 ITEMS.
 PROCEDURE DIVISION.
    READ SOMEFILE1
       NEXT RECORD
       INTO ITEMS
       WITH WAIT
       KEY IS SOMEID2
       INVALID KEY DISPLAY 'invalid key'
       NOT INVALID KEY DISPLAY 'valid key'
       AT END DISPLAY 'at end'
       NOT AT END DISPLAY 'not at end'.