/*
*&---------------------------------------------------------------------*
* Jorge Alberto Cervantes Montiel                                      *
* All Rights Reserved                                                  *
*&---------------------------------------------------------------------*
* Program Name   : ZJCD_TRAVEL                                         *
* Created By     : Jorge_Cervantes                                     *
* Created on     : 08.08.2024                                          *
* Development ID : RICEF00001                                          *
* Project        : SDCAug2024                                          *
* TR             : TRLK919406                                          *
* Version        : Initial Version                                     *
* Description    : DDL Travel                                          *
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
*&---------------------------------------------------------------------*
* MOD-001 | 15.08.2024 | Jorge_Cervantes   | CR000002  | TRLK919406    *
* Project        : SDCAug2024                                          *
* Description    :                                                     *
*      Week 2 Task                                                     *
*   1. Add comment header                                              *
*      Add TotalWithCurrency column                                    *
*      Add StatusText column                                           *
*&---------------------------------------------------------------------*
*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jorge_Cervantes: Travel DDL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity zjcd_travel
  as select from zjct_travel
  association to /DMO/I_Overall_Status_VH as _StatText on $projection.Status = _StatText.OverallStatus
{
  key travel_id                          as TravelId,
      description                        as Description,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price                        as TotalPrice,
      currency_code                      as CurrencyCode,
      status                             as Status,
      // { + MOD.001
      concat_with_space(
        cast(
          total_price as abap.char(19)),
          currency_code,
          1)                             as TotalWithCurrency,
      _StatText._Text[1:Language=$session.system_language].Text as StatusText
      // } + MOD.001
}
