*&---------------------------------------------------------------------*
* Jorge Alberto Cervantes Montiel                                      *
* All Rights Reserved                                                  *
*&---------------------------------------------------------------------*
* Program Name   : ZJCC_TRAVELGENERATOR                                *
* Created By     : Jorge_Cervantes                                     *
* Created on     : 08.08.2024                                          *
* Development ID : RICEF00001                                          *
* Project        : SDCAug2024                                          *
* TR             : TRLK919406                                          *
* Version        : Initial Version                                     *
* Description    : Travel table content generator                      *
* abapGit Rep    : https://github.com/XemDenots/z_jorge_cervantes/     *
*&=====================================================================*
* Modification Log:                                                    *
*&---------------------------------------------------------------------*
* MOD#    | Date       | Programmer        | Change ID | TR            *
*&--------------------------------------------------------------------&*
* MOD-000 | 08.08.2024 | Jorge_Cervantes   | CR000001  | TRLK919406    *
* Project        : SDCAug2024                                          *
* Description    :                                                     *
*   1. Creation                                                        *
*      use of CASE distinction                                         *
*&---------------------------------------------------------------------*
* MOD-001 | 09.08.2024 | Jorge_Cervantes   | CR000001  | TRLK919406    *
* Project        : SDCAug2024                                          *
* Description    :                                                     *
*   1. Creation                                                        *
*      Insert and modify in 1 instruction                              *
*&---------------------------------------------------------------------*
* MOD-003 | 22.08.2024 | Jorge_Cervantes   | CR000002  | TRLK919406    *
* Project        : SDCAug2024                                          *
* Description    :                                                     *
*      Week 3 Task                                                     *
*   1. Table duplicated, fill table after wizard                       *
*&---------------------------------------------------------------------*
CLASS zjcc_travelgenerator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zjcc_travelgenerator IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    "{ + mod-001
    out->write( TEXT-007 ).
    DELETE FROM zjct_travel.
    out->write( |{ TEXT-008 } { sy-dbcnt }| ).

    " } + mod-001
    out->write( TEXT-001 ).
    "{ + mod-001
    MODIFY zjct_travel FROM (
"} - mod-001
    SELECT FROM /dmo/travel
      FIELDS
             " client, " -mod-001
             travel_id,
             description,
             total_price,
             currency_code,
             CASE status
               WHEN 'N' THEN 'O'
               WHEN 'P' THEN 'O'
               WHEN 'B' THEN 'A'
               ELSE 'X'
             END AS status
      " INTO TABLE @DATA(lt_travel). " - mod-001
"{ + mod-001
     ).
    "} + mod-001
    IF sy-subrc = 0.
      "{ - mod-001
*      out->write( |{ TEXT-002 } { sy-dbcnt }| ).
*      out->write( TEXT-003 ).
*
*      MODIFY zjct_travel
*             FROM TABLE @lt_travel.
      "} - mod-001

      IF sy-subrc = 0.
        out->write( |{ TEXT-004 } { sy-dbcnt }| ).
      ELSE.
        out->write( TEXT-005 ).
      ENDIF.

    ELSE.
      out->write( TEXT-006 ).
    ENDIF.

**********************************************************************
    out->write( TEXT-007 ).
    DELETE FROM zjct_travel_m1.
    out->write( |{ TEXT-008 } { sy-dbcnt }| ).
    out->write( TEXT-001 ).

    MODIFY zjct_travel_m1 FROM (

    SELECT FROM /dmo/travel
      FIELDS
             " client, " -mod-001
             travel_id,
             description,
             total_price,
             currency_code,
             CASE status
               WHEN 'N' THEN 'O'
               WHEN 'P' THEN 'O'
               WHEN 'B' THEN 'A'
               ELSE 'X'
             END AS status
    ).
    IF sy-subrc = 0.

      IF sy-subrc = 0.
        out->write( |{ TEXT-004 } { sy-dbcnt }| ).
      ELSE.
        out->write( TEXT-005 ).
      ENDIF.

    ELSE.
      out->write( TEXT-006 ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
