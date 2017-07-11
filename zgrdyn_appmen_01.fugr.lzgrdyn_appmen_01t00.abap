*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 06.02.2017 at 16:05:56
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZUTIL_APPMENU_00................................*
DATA:  BEGIN OF STATUS_ZUTIL_APPMENU_00              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUTIL_APPMENU_00              .
CONTROLS: TCTRL_ZUTIL_APPMENU_00
            TYPE TABLEVIEW USING SCREEN '9000'.
*.........table declarations:.................................*
TABLES: *ZUTIL_APPMENU_00              .
TABLES: ZUTIL_APPMENU_00               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
