class ZCL_UTIL_APPMENU_ITEMS_BO definition
  public
  final
  create private .

public section.

  data GS_DATA type ZUTIL_APPMENU_01 read-only .
  data GT_ROLE type ZTT_UTIL_APPMENU_ITEM_ROLE_BO read-only .

  class-methods GET_SINGLE_ITEM
    importing
      !IV_APP_ID type ZUTLAPPMEN_APPID
      !IV_ITEM_ID type ZUTLAPPMEN_ITEMID
    returning
      value(RO_OBJ) type ref to ZCL_UTIL_APPMENU_ITEMS_BO
    raising
      ZCX_UTIL_APPMENU_ITEM_BO .
  class-methods GET_ALL_APP_ITEMS
    importing
      !IV_APP_ID type ZUTLAPPMEN_APPID
    returning
      value(RT_OBJ) type ZTT_UTIL_APPMENU_ITEMS_BO
    raising
      ZCX_UTIL_APPMENU_ITEM_BO .
protected section.
private section.

  methods LOAD_ADDITIONAL_DATA .
  methods CONSTRUCTOR
    importing
      !IS_DATA type ZUTIL_APPMENU_01 .
ENDCLASS.



CLASS ZCL_UTIL_APPMENU_ITEMS_BO IMPLEMENTATION.


  METHOD CONSTRUCTOR.
    "Almacenamos información
    me->gs_data = is_data.
    "Cargamos datos adicionales.
    me->load_additional_data( ).
  ENDMETHOD.


  METHOD get_all_app_items.
    DATA lt_data TYPE TABLE OF zutil_appmenu_01.
    FIELD-SYMBOLS <wa_data> LIKE LINE OF lt_data.
    FIELD-SYMBOLS <wa_obj> LIKE LINE OF rt_obj.
    "Buscamos la aplicación
    SELECT *
      INTO TABLE lt_data
      FROM zutil_appmenu_01
     WHERE app_id = iv_app_id.

    IF sy-subrc = 0.
      LOOP AT lt_data ASSIGNING <wa_data>.
        APPEND INITIAL LINE TO rt_obj ASSIGNING <wa_obj>.
        <wa_obj>-app_id = <wa_data>-app_id.
        <wa_obj>-item_id = <wa_data>-item_id.
        "Creamos constructor
        CREATE OBJECT <wa_obj>-obj EXPORTING is_data = <wa_data>.
        UNASSIGN <wa_obj>.
      ENDLOOP.
    ELSE.
      "Disparamos excepción
      RAISE EXCEPTION TYPE zcx_util_appmenu_item_bo
        EXPORTING
          textid = zcx_util_appmenu_item_bo=>not_found_items_by_app
          app_id = iv_app_id.
    ENDIF.
  ENDMETHOD.


  METHOD GET_SINGLE_ITEM.
    DATA ls_data TYPE zutil_appmenu_01.
    "Buscamos la aplicación
    SELECT SINGLE *
      INTO ls_data
      FROM zutil_appmenu_01
     WHERE app_id = iv_app_id
       AND item_id = iv_item_id.

    IF sy-subrc = 0.
      "Creamos constructor
      CREATE OBJECT ro_obj EXPORTING is_data = ls_data.
    ELSE.
      "Disparamos excepción
      RAISE EXCEPTION TYPE zcx_util_appmenu_item_bo
        EXPORTING
          textid = zcx_util_appmenu_header_bo=>not_found_app
          app_id = iv_app_id
          item_id = iv_item_id.
    ENDIF.
  ENDMETHOD.


  METHOD load_additional_data.
    "Buscamos roles asociados
    TRY.
        me->gt_role = zcl_util_appmenu_item_role_bo=>get_role_by_item( iv_app_id = me->gs_data-app_id
                                                                       iv_item_id = me->gs_data-item_id ).
      CATCH zcx_util_appmenu_item_role_bo.
        "No pasa nada si no hay descendencia
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
