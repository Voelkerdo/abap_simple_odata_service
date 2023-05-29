CLASS zcl_zftent_howto_odata_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zftent_howto_odata_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.
  PROTECTED SECTION.
    METHODS personset_get_entityset REDEFINITION.
    METHODS: personset_get_entity REDEFINITION.
    METHODS: personset_create_entity REDEFINITION.
    METHODS: personset_update_entity REDEFINITION.
    METHODS: personset_delete_entity REDEFINITION.

  PRIVATE SECTION.
    DATA: lr_person_srv TYPE REF TO zcl_ftent_perseon_srv.
ENDCLASS.



CLASS zcl_zftent_howto_odata_dpc_ext IMPLEMENTATION.

  METHOD constructor.
    super->constructor(  ).
    lr_person_srv = NEW zcl_ftent_perseon_srv(  ).
  ENDMETHOD.


  METHOD personset_get_entityset.
    lr_person_srv->get_persons( ).
  ENDMETHOD.


  METHOD personset_get_entity.

    READ TABLE it_key_tab INTO DATA(ls_key_pair) WITH KEY name = 'Perner'.
    DATA(lv_pernr) = ls_key_pair-value.
    DATA(ls_pernr) = lr_person_srv->get_person_details( iv_pernr = lv_pernr ).

    er_entity = ls_pernr.
  ENDMETHOD.


  METHOD personset_create_entity.
    DATA: ls_person TYPE zftent_s_person_odata.

    io_data_provider->read_entry_data( IMPORTING es_data = ls_person ).
    lr_person_srv->create_person( is_person = ls_person ).

    er_entity = ls_person.
  ENDMETHOD.


  METHOD personset_update_entity.
    DATA: ls_person TYPE zftent_s_person_odata.

    READ TABLE it_key_tab INTO DATA(ls_key_pair) WITH KEY name = 'Perner'.
    DATA(lv_pernr) = ls_key_pair-value.

    io_data_provider->read_entry_data( IMPORTING es_data = ls_person ).

    lr_person_srv->update_person( is_person = ls_person ).
  ENDMETHOD.


  METHOD personset_delete_entity.
    READ TABLE it_key_tab INTO DATA(ls_key_pair) WITH KEY name = 'Perner'.
    DATA(lv_pernr) = ls_key_pair-value.

    lr_person_srv->delete_person( iv_person_number = lv_pernr ).
  ENDMETHOD.

ENDCLASS.
