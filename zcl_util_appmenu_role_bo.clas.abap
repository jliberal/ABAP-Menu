class ZCL_UTIL_APPMENU_ROLE_BO definition
  public
  final
  create private .

public section.

  data GT_ROLE_ITEMS type ZTT_UTIL_APPMENU_ITEM_ROLE_BO read-only .
  data GS_DATA type ZUTIL_APPMENU_02 read-only .

  class-methods GET_SINGLE_ROLE
    importing
      !IV_APP_ID type ZUTLAPPMEN_APPID
      !IV_ROLE_ID type ZUTLAPPMEN_ROLEID
    returning
      value(RO_OBJ) type ref to ZCL_UTIL_APPMENU_ROLE_BO
    raising
      ZCX_UTIL_APPMENU_ROLE_BO .
  class-methods GET_ROLE_BY_APP
    importing
      !IV_APP_ID type ZUTLAPPMEN_APPID
    returning
      value(RT_OBJ) type ZTT_UTIL_APPMENU_ROLE_BO
    raising
      ZCX_UTIL_APPMENU_ROLE_BO .
protected section.
private section.

  methods LOAD_ADDITIONAL_DATA .
  methods CONSTRUCTOR
    importing
      !IS_DATA type ZUTIL_APPMENU_02 .
ENDCLASS.



CLASS ZCL_UTIL_APPMENU_ROLE_BO IMPLEMENTATION.


  METHOD constructor.
    "Almacenamos información
    me->gs_data = is_data.
    "Cargamos datos adicionales.
    me->load_additional_data( ).
  ENDMETHOD.


  METHOD get_role_by_app.
    DATA lt_data TYPE TABLE OF zutil_appmenu_02.
    FIELD-SYMBOLS <wa_data> LIKE LINE OF lt_data.
    FIELD-SYMBOLS <wa_obj> LIKE LINE OF rt_obj.
    "Buscamos la aplicación
    SELECT *
      INTO TABLE lt_data
      FROM zutil_appmenu_02
     WHERE app_id = iv_app_id.

    IF sy-subrc = 0.
      LOOP AT lt_data ASSIGNING <wa_data>.
        APPEND INITIAL LINE TO rt_obj ASSIGNING <wa_obj>.
        <wa_obj>-app_id = <wa_data>-app_id.
        <wa_obj>-role_id = <wa_data>-role_id.
        "Creamos constructor
        CREATE OBJECT <wa_obj>-obj EXPORTING is_data = <wa_data>.
        UNASSIGN <wa_obj>.
      ENDLOOP.
    ELSE.
      "Disparamos excepción
      RAISE EXCEPTION TYPE zcx_util_appmenu_role_bo
        EXPORTING
          textid = zcx_util_appmenu_role_bo=>not_found_role_by_app
          app_id = iv_app_id.
    ENDIF.
  ENDMETHOD.


  METHOD get_single_role.
    DATA ls_data TYPE zutil_appmenu_02.
    "Buscamos la aplicación
    SELECT SINGLE *
      INTO ls_data
      FROM zutil_appmenu_02
     WHERE app_id = iv_app_id
       AND role_id = iv_role_id.

    IF sy-subrc = 0.
      "Creamos constructor
      CREATE OBJECT ro_obj EXPORTING is_data = ls_data.
    ELSE.
      "Disparamos excepción
      RAISE EXCEPTION TYPE zcx_util_appmenu_role_bo
        EXPORTING
          textid  = zcx_util_appmenu_role_bo=>not_found_role
          app_id  = iv_app_id
          role_id = iv_role_id.
    ENDIF.
  ENDMETHOD.


  METHOD load_additional_data.
    "Buscamos roles asociados
    TRY.
        me->gt_role_items = zcl_util_appmenu_item_role_bo=>get_items_by_role( iv_app_id = me->gs_data-app_id
                                                                              iv_role_id = me->gs_data-role_id ).
      CATCH zcx_util_appmenu_item_role_bo.
        "No pasa nada si no hay descendencia
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
