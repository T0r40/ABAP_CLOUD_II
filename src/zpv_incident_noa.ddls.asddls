@Metadata.allowExtensions: true
@EndUserText.label: 'Consumption view Incident'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZPV_INCIDENT_NOA
  provider contract transactional_query
  as projection on ZDD_INCIDENT_NOA
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
      _History : redirected to composition child ZPV_HIST_NOA
}
