CLASS lsc_zi_gate_out DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.


CLASS lhc_ZI_GATE_out_doc DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ZI_GATEOUT_DOC RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZI_GATEOUT_DOC RESULT result.

    METHODS zprint FOR MODIFY
      IMPORTING keys FOR ACTION ZI_GATEOUT_doc~zprint RESULT result.

ENDCLASS.


CLASS lsc_zi_gate_out IMPLEMENTATION.

  METHOD save_modified.

  DATA lo_pfd TYPE REF TO zcl_gate_out.  "<-write your class name
    DATA wa_data TYPE zdb_gateout.  "<-write your table name
    CREATE OBJECT lo_pfd.

    IF update-ZI_GATEOUT_doc IS NOT INITIAL."<-write your interface name

      LOOP AT update-ZI_GATEOUT_doc INTO DATA(ls_data)."<-write your interface name

        DATA(new) = NEW zbg_gate_out( iv_bill = ls_data-Zgate iv_m_ind = ls_data-m_ind  )."<-write your background process class

        DATA background_process TYPE REF TO if_bgmc_process_single_op.

        TRY.

            background_process = cl_bgmc_process_factory=>get_default( )->create( ).

            background_process->set_operation_tx_uncontrolled( new ).

            IF ls_data-m_ind EQ 'X'.
*                 MOVE-CORRESPONDING ls_data TO wa_data.
              wa_data-zgate    = ls_data-Zgate.
              wa_data-m_ind = ls_data-m_ind.
              wa_data-base64_3 = ls_data-base64_3.
              MODIFY zdb_gateOUT FROM @wa_data.  "<-write your table name
            ENDIF.

            background_process->save_for_execution( ).

          CATCH cx_bgmc INTO DATA(exception).
            "handle exception
        ENDTRY.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZI_GATE_OUT_doc IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD zprint.


  DATA ls_pdf TYPE REF TO zcl_gate_out.

    CREATE OBJECT ls_pdf.

    READ ENTITIES OF zi_gateout  IN LOCAL MODE
           ENTITY ZI_GATEOUT_doc
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lt_result).

    LOOP AT lt_result INTO DATA(lw_result).

      DATA : update_lines TYPE TABLE FOR UPDATE zi_gateout,
             update_line  TYPE STRUCTURE FOR UPDATE zi_gateout.

      update_line-%tky                   = lw_result-%tky.
      update_line-base64_3                = 'A'.

      IF update_line-base64_3 IS NOT INITIAL.

        APPEND update_line TO update_lines.

        MODIFY ENTITIES OF zi_gateout IN LOCAL MODE
         ENTITY ZI_GATEOUT_doc
           UPDATE
           FIELDS ( base64_3 )
           WITH update_lines
         REPORTED reported
         FAILED failed
         MAPPED mapped.

        READ ENTITIES OF zi_gateout IN LOCAL MODE  ENTITY ZI_GATEOUT_doc
            ALL FIELDS WITH CORRESPONDING #( lt_result ) RESULT DATA(lt_final).

        result =  VALUE #( FOR  lw_final IN  lt_final ( %tky = lw_final-%tky
         %param = lw_final  )  ).

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-success
                        text = 'PDF Generated!, Please Wait for 30 Sec' )
                         ) TO reported-ZI_GATEOUT_doc.

      ELSE.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
