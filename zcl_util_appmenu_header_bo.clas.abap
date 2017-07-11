class ZCL_UTIL_APPMENU_HEADER_BO definition
  public
  final
  create private .

public section.

  data GS_DATA type ZUTIL_APPMENU_00 read-only .
  data GT_ITEMS type ZTT_UTIL_APPMENU_ITEMS_BO read-only .
  data GT_ROLE type ZTT_UTIL_APPMENU_ROLE_BO read-only .
  data GT_USERS type ZTT_UTIL_APPMENU_ROLE_USR_BO read-only .

  class-methods GET_SINGLE_APP
    importing
      !IV_APP_ID type ZUTLAPPMEN_APPID
    returning
      value(RO_OBJ) type ref to ZCL_UTIL_APPMENU_HEADER_BO
    raising
      ZCX_UTIL_APPMENU_HEADER_BO .
protected section.
private section.

  methods LOAD_ADDITIONAL_DATA .
  methods CONSTRUCTOR
    importing
      !IS_DATA type ZUTIL_APPMENU_00 .
ENDCLASS.



CLASS ZCL_UTIL_APPMENU_HEADER_BO IMPLEMENTATION.


  METHOD constructor.
    "Almacenamos información
    me->gs_data = is_data.
    "Cargamos datos adicionales.
    me->load_additional_data( ).
  ENDMETHOD.


  METHOD get_single_app.
    DATA ls_data TYPE zutil_appmenu_00.
    "Buscamos la aplicación
    SELECT SINGLE *
      INTO ls_data
      FROM zutil_appmenu_00
     WHERE app_id = iv_app_id.

    IF sy-subrc = 0.
      "Creamos constructor
      CREATE OBJECT ro_obj EXPORTING is_data = ls_data.
    ELSE.
      "Disparamos excepción
      RAISE EXCEPTION TYPE zcx_util_appmenu_header_bo
        EXPORTING
          textid = zcx_util_appmenu_header_bo=>not_found_app
          app_id = iv_app_id.
    ENDIF.
  ENDMETHOD.


  METHOD load_additional_data.
    "Buscamos items
    TRY.
        me->gt_items = zcl_util_appmenu_items_bo=>get_all_app_items( me->gs_data-app_id ).
      CATCH zcx_util_appmenu_item_bo.
        "No pasa nada si no hay descendencia
    ENDTRY.

    "Buscamos roles
    TRY.
        me->gt_role = zcl_util_appmenu_role_bo=>get_role_by_app( me->gs_data-app_id ).
      CATCH zcx_util_appmenu_role_bo.
        "No pasa nada si no hay descendencia
    ENDTRY.

    "Buscamos usuarios
    TRY.
        me->gt_users = zcl_util_appmenu_role_users_bo=>get_all_users_by_app( me->gs_data-app_id ).
      CATCH zcx_util_appmenu_role_users_bo.
        "No pasa nada si no hay descendencia
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
