class ZCX_UTIL_APPMENU definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of NOT_FOUND_APP_DATA,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '015',
      attr1 type scx_attrname value 'APP_ID',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_APP_DATA .
  constants:
    begin of NOT_FOUND_ITEMS,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '016',
      attr1 type scx_attrname value '',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ITEMS .
  constants:
    begin of NOT_AUTHORIZED,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '017',
      attr1 type scx_attrname value 'USER_ID',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_AUTHORIZED .
  constants:
    begin of NOT_FOUND_ROLE,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '019',
      attr1 type scx_attrname value 'ROLE_ID',
      attr2 type scx_attrname value 'USER_ID',
      attr3 type scx_attrname value 'APP_ID',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ROLE .
  constants:
    begin of NOT_FOUND_ROLE_ITEMS,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '020',
      attr1 type scx_attrname value 'ROLE_ID',
      attr2 type scx_attrname value 'APP_ID',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ROLE_ITEMS .
  data APP_ID type ZUTLAPPMEN_APPID read-only .
  data ITEM_ID type ZUTLAPPMEN_ITEMID read-only .
  data ROLE_ID type ZUTLAPPMEN_ROLEID read-only .
  data USER_ID type XUBNAME read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !APP_ID type ZUTLAPPMEN_APPID optional
      !ITEM_ID type ZUTLAPPMEN_ITEMID optional
      !ROLE_ID type ZUTLAPPMEN_ROLEID optional
      !USER_ID type XUBNAME optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_UTIL_APPMENU IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->APP_ID = APP_ID .
me->ITEM_ID = ITEM_ID .
me->ROLE_ID = ROLE_ID .
me->USER_ID = USER_ID .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
