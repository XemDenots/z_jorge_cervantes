/*
*&---------------------------------------------------------------------*
* Jorge Alberto Cervantes Montiel                                      *
* All Rights Reserved                                                  *
*&---------------------------------------------------------------------*
* Program Name   : ZC_JCT_TRAVEL_M1                                    *
* Created By     : Jorge_Cervantes                                     *
* Created on     : 22.08.2024                                          *
* Development ID : RICEF00001                                          *
* Project        : SDCAug2024                                          *
* TR             : TRLK919406                                          *
* Version        : Initial Version                                     *
* Description    : Projection View                                     *
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
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #NOT_ALLOWED
@Search.searchable: true
@ObjectModel.semanticKey: [ 'Description' ] // + MOD-003
define root view entity ZC_JCT_TRAVEL_M1
  provider contract transactional_query
  as projection on ZR_JCT_TRAVEL_M1
{
  key TravelId,
  // { + MOD-003 
  @Search:{
    defaultSearchElement: true,
    fuzzinessThreshold: 0.80
  }
  // } + MOD-003
  Description,
  TotalPrice,
  @Semantics.currencyCode: true
  CurrencyCode,
  // { + MOD-003
  @Consumption.valueHelpDefinition: [{ 
    entity: {
      name: '/DMO/I_Overall_Status_VH',
      element: 'OverallStatus'
    }
  }]    
  @ObjectModel.text.element: [ 'StatusText' ]
  // } + MOD-003  
  Status,
  
  TotalWithCurrency,
  StatusText,
  StatusCriticality,

  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
