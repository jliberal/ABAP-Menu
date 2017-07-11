class ZCX_UTIL_APPMENU_ITEM_BO definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of NOT_FOUND_ITEM,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '006',
      attr1 type scx_attrname value 'ITEM_ID',
      attr2 type scx_attrname value 'APP_ID',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ITEM .
  constants:
    begin of NOT_FOUND_ITEMS_BY_APP,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '007',
      attr1 type scx_attrname value 'APP_ID',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ITEMS_BY_APP .
  data APP_ID type ZUTLAPPMEN_APPID read-only .
  data ITEM_ID type ZUTLAPPMEN_ITEMID read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !APP_ID type ZUTLAPPMEN_APPID optional
      !ITEM_ID type ZUTLAPPMEN_ITEMID optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_UTIL_APPMENU_ITEM_BO IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->APP_ID = APP_ID .
me->ITEM_ID = ITEM_ID .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
