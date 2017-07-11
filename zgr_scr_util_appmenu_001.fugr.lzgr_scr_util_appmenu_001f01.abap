*----------------------------------------------------------------------*
***INCLUDE LZGR_SCR_UTIL_APPMENU_001F01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  DO_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM do_alv .
  IF go_salv IS INITIAL.
    "Creamos container
    CREATE OBJECT go_cont
      EXPORTING
        container_name = 'AREA1'.
    IF sy-subrc = 0.
      "Instanciamos handler
      CREATE OBJECT go_handle.
      "Creamos SALV
      CALL METHOD cl_salv_table=>factory
        EXPORTING
          r_container  = go_cont
          "container_name = 'AREA1'
        IMPORTING
          r_salv_table = go_salv
        CHANGING
          t_table      = gt_data.
      "Eventos
      PERFORM do_salv_events CHANGING go_salv.
      "Llamamos ALV
      go_salv->display( ).
    ENDIF.
  ELSE.
    "Refrescamos
    go_salv->refresh( ).
  ENDIF.
ENDFORM.                    " DO_ALV
*&---------------------------------------------------------------------*
*&      Form  DO_SALV_EVENTS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_GO_SALV  text
*----------------------------------------------------------------------*
FORM do_salv_events  CHANGING poc_salv TYPE REF TO cl_salv_table.
  DATA lo_events TYPE REF TO cl_salv_events_table.
  lo_events = poc_salv->get_event( ).
  SET HANDLER go_handle->handle_dbl_clk FOR lo_events.
ENDFORM.                    " DO_SALV_EVENTS
