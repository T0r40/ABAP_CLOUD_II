@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stores information about the history of the Incidents.'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPV_HIST_NOA as projection on ZDD_HIST_NOA
{
key HisUUID,
  key IncUUID,
      HisId,
      PreviousStatus,
      NewStatus,
      Text,
      local_created_by,
      local_created_at,
      local_last_changed_by,
      local_last_changed_at,
      last_changed_at,
      _Incident : redirected to parent ZPV_INCIDENT_NOA
}
