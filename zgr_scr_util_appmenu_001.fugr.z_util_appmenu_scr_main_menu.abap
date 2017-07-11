FUNCTION z_util_appmenu_scr_main_menu.
*"----------------------------------------------------------------------
*"*"Interfase local
*"  IMPORTING
*"     REFERENCE(IV_TITLE) TYPE  ANY
*"     REFERENCE(IT_DATA) TYPE  ZTT_UTIL_APPMENU_MENU_ITEMS
*"  EXPORTING
*"     REFERENCE(EV_SELECTED) TYPE  ZUTLAPPMEN_MENUID
*"     REFERENCE(EV_UCOMM) TYPE  SY-UCOMM
*"----------------------------------------------------------------------
  CLEAR gs_menu.
  gt_data = it_data.
  gv_title = iv_title.
  CALL SCREEN 900.
  ev_selected = gs_menu-menu_id.
  ev_ucomm = gv_okcode.
ENDFUNCTION.
