 IDENTIFICATION DIVISION.
 PROGRAM-ID. REPGRPDESCVERT.
 DATA DIVISION.
    REPORT SECTION.
    RD REPORT1
       IS GLOBAL.
       01 SOMEDATANAME
          LINE NUMBER IS PLUS 2
          NEXT GROUP IS NEXT PAGE
          TYPE IS CONTROL HEADING SOMEDATA1
          USAGE IS DISPLAY-1
       .