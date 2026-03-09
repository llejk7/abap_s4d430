CLASS zcl_i766667_demo_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_i766667_demo_01 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
  DATA arrivals type table of /DMO/C_Booking_Approver_M.

select from /DMO/C_Booking_Approver_M
fields *
into table @arrivals.

  ENDMETHOD.
ENDCLASS.
