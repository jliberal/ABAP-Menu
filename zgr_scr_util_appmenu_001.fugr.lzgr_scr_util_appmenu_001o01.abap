*----------------------------------------------------------------------*
***INCLUDE LZGR_SCR_UTIL_APPMENU_001O01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  STATUS_0900  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE status_0900 OUTPUT.
  SET PF-STATUS '900'.
  SET TITLEBAR '900' WITH gv_title.

ENDMODULE.                 " STATUS_0900  OUTPUT
*&---------------------------------------------------------------------*
*&      Module  DO_ALV  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE do_alv OUTPUT.
  PERFORM do_alv.
ENDMODULE.                 " DO_ALV  OUTPUT
