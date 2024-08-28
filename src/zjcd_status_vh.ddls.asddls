@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'status value help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity zjcd_status_vh as select from /dmo/oall_stat_t
{
  key text as OverallStatusText,
  overall_status as OverallStatus
}
where language = $session.system_language
