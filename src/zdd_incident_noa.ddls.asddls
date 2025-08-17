@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stores the basic information about incidents'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZDD_INCIDENT_NOA
  as select from zdt_inct_noa
  composition [0..*] of ZDD_HIST_NOA as _History
  association [0..1] to zdt_status_noa   as _Status   on $projection.status = _Status.status_code
  association [0..1] to zdt_priority_noa as _Priority on $projection.priority = _Priority.priority_code
{
  key inc_uuid,
      incident_id,
      title,
      description,
      status,
      priority,
      creation_date,
      changed_date,
      local_created_by,
      local_created_at,
      local_last_changed_by,
      local_last_changed_at,
      last_changed_at,
      _Status,
      _Priority,
      _History
}
