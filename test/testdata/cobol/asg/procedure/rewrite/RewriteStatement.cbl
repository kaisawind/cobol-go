 IDENTIFICATION DIVISION.
 PROGRAM-ID. REWRSTMT.
 PROCEDURE DIVISION.
    REWRITE SOMERECORD1
       FROM SOMEID1
       INVALID KEY DISPLAY 'invalid key'
       NOT INVALID KEY DISPLAY 'not invalid key'.