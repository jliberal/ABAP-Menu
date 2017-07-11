class ZCL_UTIL_APPMENU_ROLE_USERS_BO definition
  public
  final
  create private .

public section.

  data GS_DATA type ZUTIL_APPMENU_03 read-only .

  class-methods GET_SINGLE_USER
    importing
      !IV_APP_ID type ZUTLAPPMEN_APPID
      !IV_USER_ID type XUBNAME
    returning
      value(RO_OBJ) type ref to ZCL_UTIL_APPMENU_ROLE_USERS_BO
    raising
      ZCX_UTIL_APPMENU_ROLE_USERS_BO .
  class-methods GET_ALL_USERS_BY_APP
    importing
      !IV_APP_ID type ZUTLAPPMEN_APPID
    returning
      value(RT_OBJ) type ZTT_UTIL_APPMENU_ROLE_USR_BO
    raising
      ZCX_UTIL_APPMENU_ROLE_USERS_BO .
protected section.
private section.

  methods CONSTRUCTOR
    importing
      !IS_DATA type ZUTIL_APPMENU_03 .
ENDCLASS.



CLASS ZCL_UTIL_APPMENU_ROLE_USERS_BO IMPLEMENTATION.


  METHOD constructor.
    "Almacenamos información
    me->gs_data = is_data.
  ENDMETHOD.


  METHOD get_all_users_by_app.
    DATA lt_data TYPE TABLE OF zutil_appmenu_03.
    FIELD-SYMBOLS <wa_data> LIKE LINE OF lt_data.
    FIELD-SYMBOLS <wa_obj> LIKE LINE OF rt_obj.
    "Buscamos la aplicación
    SELECT *
      INTO TABLE lt_data
      FROM zutil_appmenu_03
     WHERE app_id = iv_app_id.

    IF sy-subrc = 0.
      LOOP AT lt_data ASSIGNING <wa_data>.
        APPEND INITIAL LINE TO rt_obj ASSIGNING <wa_obj>.
        <wa_obj>-app_id = <wa_data>-app_id.
        <wa_obj>-user_id = <wa_data>-uname.
        "Creamos constructor
        CREATE OBJECT <wa_obj>-obj EXPORTING is_data = <wa_data>.
        UNASSIGN <wa_obj>.
      ENDLOOP.
    ELSE.
      "Disparamos excepción
      RAISE EXCEPTION TYPE zcx_util_appmenu_role_users_bo
        EXPORTING
          textid = zcx_util_appmenu_role_users_bo=>not_found_users_by_app
          app_id = iv_app_id.
    ENDIF.
  ENDMETHOD.


  METHOD get_single_user.
    DATA ls_data TYPE zutil_appmenu_03.
    "Buscamos la aplicación
    SELECT SINGLE *
      INTO ls_data
      FROM zutil_appmenu_03
     WHERE app_id = iv_app_id
       AND uname = iv_user_id.

    IF sy-subrc = 0.
      "Creamos constructor
      CREATE OBJECT ro_obj EXPORTING is_data = ls_data.
    ELSE.
      "Disparamos excepción
      RAISE EXCEPTION TYPE zcx_util_appmenu_role_users_bo
        EXPORTING
          textid  = zcx_util_appmenu_role_users_bo=>not_found_user
          app_id  = iv_app_id
          user_id = iv_user_id.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
