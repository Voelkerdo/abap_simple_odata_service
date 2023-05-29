CLASS zcl_ftent_perseon_srv DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS constructor.

    METHODS get_person_details
      IMPORTING iv_pernr         TYPE string
      RETURNING VALUE(rs_person) TYPE zftent_s_person_odata.

    METHODS create_person
      IMPORTING is_person TYPE zftent_s_person_odata.

    METHODS get_persons
      RETURNING VALUE(rt_persons) TYPE zftent_t_person_odata.

    METHODS update_person
      IMPORTING is_person TYPE zftent_s_person_odata.

    METHODS delete_person
      IMPORTING iv_person_number TYPE string.
  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA: gt_sample_data TYPE zftent_t_person_odata.
ENDCLASS.



CLASS zcl_ftent_perseon_srv IMPLEMENTATION.


  METHOD constructor.
    gt_sample_data = VALUE #(
        ( perner = '0' first_name = 'Max' last_name = 'Mustermann'  birth_date = '19960923' ename = 'ename')
        ( perner = '1' first_name = 'Erika' last_name = 'Mustermann'  birth_date = '19960923' ename = 'ename')
        ( perner = '2' first_name = 'John' last_name = 'Doe'  birth_date = '19960923' ename = 'ename')
    ).

  ENDMETHOD.


  METHOD create_person.
    DATA(ls_person) = is_person.

    IF NOT line_exists( gt_sample_data[ perner = ls_person-perner ] ).
      APPEND ls_person TO gt_sample_data.
    ENDIF.
  ENDMETHOD.


  METHOD delete_person.
    DATA(lv_person) = iv_person_number.

    DELETE gt_sample_data WHERE perner = lv_person.
  ENDMETHOD.


  METHOD get_persons.
    rt_persons = gt_sample_data.
  ENDMETHOD.


  METHOD get_person_details.
    DATA(lv_pernr) = iv_pernr.

    "XXX: Use functional language to filter out the data
    "DATA(lt_filtered) = VALUE zftent_t_person_odata( FOR ls_person IN lt_sample_data WHERE ( perner = lv_pernr ) ).
    READ TABLE gt_sample_data INTO DATA(ls_person) WITH KEY perner = lv_pernr.

    rs_person = ls_person.
  ENDMETHOD.


  METHOD update_person.
    DATA(ls_person) = is_person.

    IF line_exists( gt_sample_data[ perner = ls_person-perner ] ).
      MODIFY gt_sample_data FROM ls_person
      TRANSPORTING
          first_name
          last_name
          ename
          birth_date
      WHERE perner = ls_person-perner.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
