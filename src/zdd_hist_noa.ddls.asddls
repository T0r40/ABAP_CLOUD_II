@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stores information about the history of the Incidents'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDD_HIST_NOA
  as select from zdt_inct_h_noa
  association to parent ZDD_INCIDENT_NOA as _Incident on $projection.IncUUID = _Incident.inc_uuid
{
  key    his_uuid        as HisUUID,
  key    inc_uuid        as IncUUID,
         his_id          as HisId,
         previous_status as PreviousStatus,
         new_status      as NewStatus,
         text            as Text,
         local_created_by,
         local_created_at,
         local_last_changed_by,
         local_last_changed_at,
         last_changed_at,
         _Incident
}
