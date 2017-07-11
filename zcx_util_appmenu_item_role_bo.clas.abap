class ZCX_UTIL_APPMENU_ITEM_ROLE_BO definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of NOT_FOUND_ITEM_ROLE,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '012',
      attr1 type scx_attrname value 'ROLE_ID',
      attr2 type scx_attrname value 'ITEM_ID',
      attr3 type scx_attrname value 'APP_ID',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ITEM_ROLE .
  constants:
    begin of NOT_FOUND_ROLE_BY_ITEM,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '013',
      attr1 type scx_attrname value 'ITEM_ID',
      attr2 type scx_attrname value 'APP_ID',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ROLE_BY_ITEM .
  constants:
    begin of NOT_FOUND_ROLE_BY_APP,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '014',
      attr1 type scx_attrname value 'APP_ID',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ROLE_BY_APP .
  constants:
    begin of NOT_FOUND_ITEMS_BY_ROLE,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '018',
      attr1 type scx_attrname value 'ROLE_ID',
      attr2 type scx_attrname value 'APP_ID',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ITEMS_BY_ROLE .
  data APP_ID type ZUTLAPPMEN_APPID read-only .
  data ITEM_ID type ZUTLAPPMEN_ITEMID read-only .
  data ROLE_ID type ZUTLAPPMEN_ROLEID read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !APP_ID type ZUTLAPPMEN_APPID optional
      !ITEM_ID type ZUTLAPPMEN_ITEMID optional
      !ROLE_ID type ZUTLAPPMEN_ROLEID optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_UTIL_APPMENU_ITEM_ROLE_BO IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->APP_ID = APP_ID .
me->ITEM_ID = ITEM_ID .
me->ROLE_ID = ROLE_ID .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
