*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZGRDYN_APPMEN_05
*   generation date: 06.02.2017 at 17:42:07
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZGRDYN_APPMEN_05   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.