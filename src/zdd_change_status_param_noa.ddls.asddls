@EndUserText.label: 'Parameters for Change Status'
define abstract entity zdd_change_status_param_noa
{
@EndUserText.label: 'Change Status'
@Consumption.valueHelpDefinition: [ {
    entity.name: 'zdd_status_vh_noa',
    entity.element: 'StatusCode',
    useForValidation: true
  } ]
    status : zde_status_code;    
@EndUserText.label: 'Add Observation Text'
    text : zde_text;
}
