*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 06.02.2017 at 17:42:07
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZUTIL_APPMENU_04................................*
DATA:  BEGIN OF STATUS_ZUTIL_APPMENU_04              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUTIL_APPMENU_04              .
CONTROLS: TCTRL_ZUTIL_APPMENU_04
            TYPE TABLEVIEW USING SCREEN '9000'.
*.........table declarations:.................................*
TABLES: *ZUTIL_APPMENU_04              .
TABLES: ZUTIL_APPMENU_04               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
