/*
*&---------------------------------------------------------------------*
* Jorge Alberto Cervantes Montiel                                      *
* All Rights Reserved                                                  *
*&---------------------------------------------------------------------*
* Program Name   : ZR_JCT_TRAVEL_M1                                    *
* Created By     : Jorge_Cervantes                                     *
* Created on     : 22.08.2024                                          *
* Development ID : RICEF00001                                          *
* Project        : SDCAug2024                                          *
* TR             : TRLK919406                                          *
* Version        : Initial Version                                     *
* Description    : Data Model View                                     *
* abapGit Rep    : https://github.com/XemDenots/z_jorge_cervantes/     *
*&=====================================================================*
* Modification Log:                                                    *
*&---------------------------------------------------------------------*
* MOD#    | Date       | Programmer        | Change ID | TR            *
*&--------------------------------------------------------------------&*
* MOD-003 | 22.08.2024 | Jorge_Cervantes   | CR000002  | TRLK919406    *
* Project        : SDCAug2024                                          *
* Description    :                                                     *
*      Week 3 Task                                                     *
*   1. Creation with wizard                                            *
*   2. Adding TotalWithCurrency, StatusText                            *
*&---------------------------------------------------------------------*
*/
@AccessControl.authorizationCheck: #NOT_ALLOWED
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_JCT_TRAVEL_M1
  as select from zjct_travel_m1
  association to /DMO/I_Overall_Status_VH as _StatText on $projection.Status = _StatText.OverallStatus

{
  key travel_id             as TravelId,
      description           as Description,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price           as TotalPrice,
      currency_code         as CurrencyCode,
      status                as Status,
// + MOD-003     
      concat_with_space(
        cast(total_price as abap.char(19)),
        currency_code,
        1
      )                     as TotalWithCurrency,
      _StatText.
        _Text[1:Language=$session.system_language].
          Text              as StatusText,
// + MOD-003
// + MOD-004          
      case
        when status = 'A' then 3
        when status = 'O' then 2
        when status = 'X' then 1
        else 1
      end                   as StatusCriticality,
// + MOD-004      
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt

}
