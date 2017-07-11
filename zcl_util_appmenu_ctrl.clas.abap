class ZCL_UTIL_APPMENU_CTRL definition
  public
  final
  create private .

public section.

  data GT_ITEMS type ZTT_UTIL_APPMENU_01 read-only .
  data GT_MENU type ZTT_UTIL_APPMENU_MENU_ITEMS read-only .
  data GT_MENU_LINK type ZTT_UTIL_APPMENU_MENU_ITM_LNK read-only .
  data GO_MENU_DATA type ref to ZCL_UTIL_APPMENU_HEADER_BO read-only .
  data GO_ROLE type ref to ZCL_UTIL_APPMENU_ROLE_BO read-only .
  constants GC_APP_MEM_ID type CHAR15 value 'ZMENUAPP_MENU'. "#EC NOTEXT
  constants GC_ITEM_MEM_ID type CHAR15 value 'ZMENUAPP_ITEM'. "#EC NOTEXT

  class-methods START
    importing
      !IV_APP_ID type ZUTLAPPMEN_APPID
      !IV_USER_ID type XUBNAME default SY-UNAME .
  class-methods GET_MENU_FROM_MEMORY
    returning
      value(RV_MENU) type ZUTLAPPMEN_APPID .
  class-methods CLEAR_MENU_MEMORY .
  type-pools ABAP .
  class-methods BLOCK_TRANSACTION
    importing
      !IV_TCODE type SY-TCODE
    returning
      value(RV_TRUE) type ABAP_BOOL .
protected section.
private section.

  class-methods TRANSACTION_IS_BLOCKED
    importing
      !IV_TCODE type SY-TCODE
    returning
      value(RV_TRUE) type ABAP_BOOL .
  methods CREATE_MENU_OPTIONS
    raising
      ZCX_UTIL_APPMENU .
  methods EXCECUTE_ITEM
    importing
      !IS_ITEM type ZUTIL_APPMENU_01
    exceptions
      ZCX_UTIL_APPMENU .
  methods LOAD_ITEMS_BY_ROLE
    importing
      !IV_ROLE_ID type ZUTLAPPMEN_ROLEID
    raising
      ZCX_UTIL_APPMENU .
  methods LOAD_USER_CONFIG
    importing
      !IV_USER_ID type XUBNAME
    raising
      ZCX_UTIL_APPMENU .
  methods SHOW_MENU
    raising
      ZCX_UTIL_APPMENU .
  methods LOAD_ROLE
    importing
      !IV_USER_ID type XUBNAME
    raising
      ZCX_UTIL_APPMENU .
  class-methods SHOW_CATCH_MESSAGE
    importing
      value(IO_CATCHED_ERROR) type ref to CX_ROOT .
  methods CONSTRUCTOR
    importing
      !IV_APP_ID type ZUTLAPPMEN_APPID
    raising
      ZCX_UTIL_APPMENU .
  methods SET_MENU_TO_MEMORY
    importing
      !IV_MENU type ZUTLAPPMEN_APPID .
ENDCLASS.



CLASS ZCL_UTIL_APPMENU_CTRL IMPLEMENTATION.


  METHOD block_transaction.
    IF transaction_is_blocked( iv_tcode ) = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD clear_menu_memory.
    DATA lv_menu TYPE zutlappmen_appid.
    SET PARAMETER ID gc_app_mem_id FIELD lv_menu.
  ENDMETHOD.


  METHOD constructor.
    DATA lo_error TYPE REF TO zcx_util_appmenu_header_bo.
    TRY.
        me->go_menu_data = zcl_util_appmenu_header_bo=>get_single_app( iv_app_id ).
      CATCH zcx_util_appmenu_header_bo INTO lo_error.
        RAISE EXCEPTION TYPE ZCX_UTIL_APPMENU
          EXPORTING textid = ZCX_UTIL_APPMENU=>not_found_app_data
                    app_id = iv_app_id.
    ENDTRY.
  ENDMETHOD.


  METHOD create_menu_options.
    DATA lv_id TYPE zutlappmen_menuid.
    FIELD-SYMBOLS <wa_itm> LIKE LINE OF me->gt_items.
    FIELD-SYMBOLS <wa_men> LIKE LINE OF me->gt_menu.
    FIELD-SYMBOLS <wa_lnk> LIKE LINE OF me->gt_menu_link.

    CLEAR me->gt_menu.
    CLEAR me->gt_menu_link.
    LOOP AT me->gt_items ASSIGNING <wa_itm>.
      ADD 1 TO lv_id.
      "Menu
      APPEND INITIAL LINE TO me->gt_menu ASSIGNING <wa_men>.
      <wa_men>-menu_id = lv_id.
      <wa_men>-item_desc = <wa_itm>-item_desc.
      UNASSIGN <wa_men>.
      "Asociación de menu
      APPEND INITIAL LINE TO me->gt_menu_link ASSIGNING <wa_lnk>.
      <wa_lnk>-menu_id = lv_id.
      <wa_lnk>-item_id = <wa_itm>-item_id.
      UNASSIGN <wa_lnk>.
    ENDLOOP.
    UNASSIGN <wa_itm>.
  ENDMETHOD.


  METHOD excecute_item.
    IF is_item-trx_id IS NOT INITIAL.
      "Envio ID de Menu y de Item
      me->set_menu_to_memory( is_item-app_id ).
      SET PARAMETER ID me->gc_item_mem_id FIELD is_item-item_id.
      TRY.
          CALL TRANSACTION is_item-trx_id.
        CATCH cx_root.
      ENDTRY.
    ENDIF.
    IF is_item-tablename IS NOT INITIAL.
    ENDIF.
  ENDMETHOD.


  METHOD get_menu_from_memory.
    GET PARAMETER ID gc_app_mem_id FIELD rv_menu.
  ENDMETHOD.


  METHOD load_items_by_role.
    FIELD-SYMBOLS <wa_obj_itm> LIKE LINE OF me->go_menu_data->gt_items.
    FIELD-SYMBOLS <wa_itm> LIKE LINE OF me->gt_items.
    FIELD-SYMBOLS <wa_obj> LIKE LINE OF me->go_role->gt_role_items.
    LOOP AT me->go_role->gt_role_items ASSIGNING <wa_obj>.
      "Leemos tabla de objetos items
      READ TABLE me->go_menu_data->gt_items ASSIGNING <wa_obj_itm>
       WITH KEY app_id = me->go_menu_data->gs_data-app_id
                item_id = <wa_obj>-item_id.
      IF <wa_obj_itm> IS ASSIGNED.
        "Añadimos items
        APPEND INITIAL LINE TO me->gt_items ASSIGNING <wa_itm>.
        <wa_itm> = <wa_obj_itm>-obj->gs_data.
        UNASSIGN <wa_itm>.
        UNASSIGN <wa_obj_itm>.
      ENDIF.
    ENDLOOP.
    UNASSIGN <wa_obj>.
    "Si no hay items
    IF lines( me->gt_items ) = 0.
      RAISE EXCEPTION TYPE zcx_util_appmenu
        EXPORTING
          textid  = zcx_util_appmenu=>not_found_role_items
          app_id  = me->go_menu_data->gs_data-app_id
          role_id = iv_role_id.
    ENDIF.
  ENDMETHOD.


  METHOD load_role.
    DATA lo_role TYPE REF TO zcl_util_appmenu_role_bo.
    FIELD-SYMBOLS <wa_obj> LIKE LINE OF me->go_menu_data->gt_users.
    READ TABLE me->go_menu_data->gt_users
         ASSIGNING <wa_obj> WITH KEY user_id = iv_user_id.
    IF <wa_obj> IS ASSIGNED.
      "Con el ID de rol buscamos el objeto
      TRY.
          me->go_role = zcl_util_appmenu_role_bo=>get_single_role(
            iv_app_id = me->go_menu_data->gs_data-app_id
            iv_role_id = <wa_obj>-obj->gs_data-role_id ).
        CATCH zcx_util_appmenu_item_role_bo.
          UNASSIGN <wa_obj>.
          RAISE EXCEPTION TYPE zcx_util_appmenu
            EXPORTING
              textid  = zcx_util_appmenu=>not_found_role
              app_id  = me->go_menu_data->gs_data-app_id
              role_id = <wa_obj>-obj->gs_data-role_id
              user_id = iv_user_id.
      ENDTRY.
      UNASSIGN <wa_obj>.
    ELSE.
      RAISE EXCEPTION TYPE zcx_util_appmenu
        EXPORTING
          textid  = zcx_util_appmenu=>not_authorized
          user_id = iv_user_id.
    ENDIF.
  ENDMETHOD.


  METHOD load_user_config.
    "Cargamos el rol del usuario
    me->load_role( iv_user_id ).
    "Cargamos items asociados al rol
    me->load_items_by_role( me->go_role->gs_data-role_id ).
  ENDMETHOD.


  METHOD set_menu_to_memory.
    SET PARAMETER ID gc_app_mem_id FIELD iv_menu.
  ENDMETHOD.


  METHOD show_catch_message.
    DATA lv_message TYPE string.

    CHECK io_catched_error IS NOT INITIAL.
    lv_message = io_catched_error->get_text( ).
    MESSAGE lv_message TYPE 'I'.
  ENDMETHOD.


  METHOD show_menu.
    DATA lv_menu TYPE zutlappmen_menuid.
    DATA lv_ucomm TYPE sy-ucomm.
    FIELD-SYMBOLS <wa_item> LIKE LINE OF me->gt_items.
    FIELD-SYMBOLS <wa_link> LIKE LINE OF me->gt_menu_link.
    "Mostramos pantalla
    CALL FUNCTION 'Z_UTIL_APPMENU_SCR_MAIN_MENU'
      EXPORTING
        iv_title    = me->go_menu_data->gs_data-app_desc
        it_data     = me->gt_menu
      IMPORTING
        ev_selected = lv_menu
        ev_ucomm    = lv_ucomm.
    "Tratamos selección
    IF lv_menu IS NOT INITIAL.
      "Leemos Asociacion
      READ TABLE gt_menu_link ASSIGNING <wa_link> WITH KEY menu_id = lv_menu.
      IF <wa_link> IS ASSIGNED.
        "Leemos items
        READ TABLE me->gt_items ASSIGNING <wa_item> WITH KEY item_id = <wa_link>-item_id.
        IF <wa_item> IS ASSIGNED.
          "Ejecutamos opción
          me->excecute_item( <wa_item> ).
          UNASSIGN <wa_item>.
        ELSE.
          MESSAGE text-e02 TYPE 'S'.
        ENDIF.
        UNASSIGN <wa_link>.
      ELSE.
        MESSAGE text-e02 TYPE 'S'.
      ENDIF.
    ENDIF.
    "Llamamos a la pantalla de nuevo en caso de que no haya pasado
    CASE lv_ucomm.
      WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
        MESSAGE text-s01 TYPE 'S'.
      WHEN OTHERS.
        me->show_menu( ).
    ENDCASE.
  ENDMETHOD.


  METHOD start.
    DATA lo_obj TYPE REF TO zcl_util_appmenu_ctrl.
    DATA lo_error TYPE REF TO zcx_util_appmenu.

    TRY.
        "Constructor
        CREATE OBJECT lo_obj
          EXPORTING
            iv_app_id = iv_app_id.
        "Verificamos que existan items configurados
        IF lines( lo_obj->go_menu_data->gt_items ) = 0.
          RAISE EXCEPTION TYPE zcx_util_appmenu
            EXPORTING
              textid = zcx_util_appmenu=>not_found_items.
        ENDIF.
        "Cargamos la configuración del usuario
        lo_obj->load_user_config( iv_user_id ).
        "Creamos menu
        lo_obj->create_menu_options( ).
        "Mostramos menu
        lo_obj->show_menu( ).
      CATCH zcx_util_appmenu INTO lo_error.
        show_catch_message( lo_error ).
    ENDTRY.

  ENDMETHOD.


  method TRANSACTION_IS_BLOCKED.
  endmethod.
ENDCLASS.
