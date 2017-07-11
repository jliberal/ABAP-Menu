class ZCX_UTIL_APPMENU_ROLE_BO definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_MESSAGE .

  constants:
    begin of NOT_FOUND_ROLE,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '008',
      attr1 type scx_attrname value 'ROLE_ID',
      attr2 type scx_attrname value 'APP_ID',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ROLE .
  constants:
    begin of NOT_FOUND_ROLE_BY_APP,
      msgid type symsgid value 'ZUTIL_APPMENU',
      msgno type symsgno value '009',
      attr1 type scx_attrname value 'APP_ID',
      attr2 type scx_attrname value '',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of NOT_FOUND_ROLE_BY_APP .
  data APP_ID type ZUTLAPPMEN_APPID read-only .
  data ROLE_ID type ZUTLAPPMEN_ROLEID read-only .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !APP_ID type ZUTLAPPMEN_APPID optional
      !ROLE_ID type ZUTLAPPMEN_ROLEID optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_UTIL_APPMENU_ROLE_BO IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->APP_ID = APP_ID .
me->ROLE_ID = ROLE_ID .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
