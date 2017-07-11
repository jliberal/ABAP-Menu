*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZGRDYN_APPMEN_01
*   generation date: 06.02.2017 at 16:05:56
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZGRDYN_APPMEN_01   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
