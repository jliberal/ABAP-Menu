*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 06.02.2017 at 17:40:56
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZUTIL_APPMENU_01................................*
DATA:  BEGIN OF STATUS_ZUTIL_APPMENU_01              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUTIL_APPMENU_01              .
CONTROLS: TCTRL_ZUTIL_APPMENU_01
            TYPE TABLEVIEW USING SCREEN '9000'.
*.........table declarations:.................................*
TABLES: *ZUTIL_APPMENU_01              .
TABLES: ZUTIL_APPMENU_01               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
