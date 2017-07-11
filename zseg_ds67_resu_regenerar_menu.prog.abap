*&---------------------------------------------------------------------*
*& Report  ZSEG_DS67_RESU_REGENERAR_MENU
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT zseg_ds67_resu_regenerar_menu.
CONSTANTS lc_app_1 TYPE zutlappmen_appid VALUE '000001'.

START-OF-SELECTION.

  "Llamamos a la transacción.
  zcl_util_appmenu_ctrl=>start( iv_app_id = lc_app_1
                                iv_user_id = sy-uname ).
