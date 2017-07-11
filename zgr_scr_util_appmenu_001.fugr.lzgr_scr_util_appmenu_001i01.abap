*----------------------------------------------------------------------*
***INCLUDE LZGR_SCR_UTIL_APPMENU_001I01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0900  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0900 INPUT.
  CLEAR gv_okcode.
  gv_okcode = sy-ucomm.

  CASE gv_okcode.
    WHEN 'BACK' OR 'EXIT' OR 'CANCEL' or 'EXEC'.
      CLEAR go_salv.
      go_cont->free( ).
      CLEAR go_cont.
      LEAVE TO SCREEN 0.
    WHEN OTHERS.
  ENDCASE.
ENDMODULE.                 " USER_COMMAND_0900  INPUT
