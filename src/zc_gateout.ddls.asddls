@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption for gateout'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo:{
    typeName: 'Gate Out',
    typeNamePlural: 'Gate Out',
    title:{ type: #STANDARD, value: 'Zgate' } }
define root  view entity ZC_GATEOUT as projection on ZI_GATEOUT
{


   @UI.facet: [{ id : 'ZGATE',
  purpose: #STANDARD,
  type: #IDENTIFICATION_REFERENCE,
  label: 'Gate Entry',
   position: 10 }]

  @UI.lineItem:       [{ position: 10, label: 'Gate Out document No.' },{ type: #FOR_ACTION , dataAction: 'ZPRINT', label: 'Generate Print'}]
  @UI.identification: [{ position: 10, label: 'Material Document' }] 
  @UI.selectionField: [{ position: 10 }]
@EndUserText.label: 'Gate Out document No.'
    key zgate,
    
    
       @UI.lineItem:       [{ position: 20, label: 'Plant' }]
  @UI.identification: [{ position: 20, label: 'Plant' }]
  @UI.selectionField: [{ position: 20 }]
    plant,
    
      @UI.lineItem:       [{ position: 30, label: 'gateindate' }]
  @UI.identification: [{ position: 30, label: 'gateindate' }]
  @UI.selectionField: [{ position: 30 }]
    gateindt,
    
    
       @UI.lineItem:       [{ position: 40, label: 'gateoutdate' }]
  @UI.identification: [{ position: 40, label: 'gateoutdate' }]
  @UI.selectionField: [{ position: 40 }]
    gateoutdt,
    base64_3,
    m_ind
}
