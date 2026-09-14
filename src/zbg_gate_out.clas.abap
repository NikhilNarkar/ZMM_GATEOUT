CLASS zbg_gate_out DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_bgmc_operation .
    INTERFACES if_bgmc_op_single_tx_uncontr .
    INTERFACES if_serializable_object .

    METHODS constructor
      IMPORTING
        iv_bill  TYPE  zde_out_payment
        iv_m_ind TYPE abap_boolean.


  PROTECTED SECTION.


    DATA : im_bill TYPE  zde_out_payment,
           im_ind  TYPE abap_boolean.

    METHODS modify
      RAISING
        cx_bgmc_operation.


  PRIVATE SECTION.
ENDCLASS.



CLASS ZBG_GATE_OUT IMPLEMENTATION.


  METHOD constructor.
    im_bill = iv_bill.
    im_ind = iv_m_ind.

  ENDMETHOD.


  METHOD if_bgmc_op_single_tx_uncontr~execute.
    modify( ).
  ENDMETHOD.


  METHOD modify.
    DATA : wa_data TYPE zdb_gateout.  "<-write your table name
    DATA :lv_pdftest TYPE string.
    DATA lo_pfd TYPE REF TO zcl_gate_out.  "<-write your logic class

    CREATE OBJECT lo_pfd.
    lo_pfd->get_pdf_64( EXPORTING io_gate = im_bill  RECEIVING pdf_64 = DATA(pdf_64) ).


    wa_data-zgate    = im_bill.
    wa_data-base64_3 = pdf_64.
    wa_data-m_ind    = im_ind.
    MODIFY zdb_gateOUT FROM @wa_data.
  ENDMETHOD.
ENDCLASS.
