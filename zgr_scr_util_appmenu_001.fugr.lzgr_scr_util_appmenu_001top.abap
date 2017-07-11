FUNCTION-POOL zgr_scr_util_appmenu_001.     "MESSAGE-ID ..

DATA gv_title TYPE string.
DATA gv_okcode TYPE sy-ucomm.
DATA gs_menu TYPE zstr_util_appmenu_menu_items.
DATA go_salv TYPE REF TO cl_salv_table.
DATA go_cont TYPE REF TO cl_gui_custom_container.
DATA gt_data TYPE ztt_util_appmenu_menu_items.

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    METHODS handle_dbl_clk
                  FOR EVENT  double_click OF cl_salv_events_table
      IMPORTING row column.
ENDCLASS.
CLASS lcl_handler IMPLEMENTATION.
  METHOD handle_dbl_clk.
    FIELD-SYMBOLS <wa_alv> LIKE LINE OF gt_data.
    READ TABLE gt_data ASSIGNING <wa_alv> INDEX row.
    IF <wa_alv> IS ASSIGNED.
      gs_menu = <wa_alv>.
      UNASSIGN <wa_alv>.
      CALL FUNCTION 'SAPGUI_SET_FUNCTIONCODE'
        EXPORTING
          FUNCTIONCODE                 = 'EXEC'
        EXCEPTIONS
          FUNCTION_NOT_SUPPORTED       = 1
          OTHERS                       = 2.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
DATA go_handle TYPE REF TO lcl_handler.
"INCLUDE LZGR_SCR_UTIL_APPMENU_001D...      " Local class definition
