*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 06.02.2017 at 17:08:09
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZUTIL_APPMENU_02................................*
DATA:  BEGIN OF STATUS_ZUTIL_APPMENU_02              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZUTIL_APPMENU_02              .
CONTROLS: TCTRL_ZUTIL_APPMENU_02
            TYPE TABLEVIEW USING SCREEN '9000'.
*.........table declarations:.................................*
TABLES: *ZUTIL_APPMENU_02              .
TABLES: ZUTIL_APPMENU_02               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
