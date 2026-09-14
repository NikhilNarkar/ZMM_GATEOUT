@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for gate entry'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_GATEOUT 
as select from ZI_GATEENTRY_HDR_S as a
left outer join zdb_gateout as b on a.Zgate = b.zgate
{
    key a.Zgate ,
    a.Plant ,
    a.Gateindt ,
    a.Gateoutdt ,
    b.base64_3,
    b.m_ind
}
