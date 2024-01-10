namespace ibmcapapp.srv;

using {anubhav.db.master as master, anubhav.db.transaction  as transaction } from '../db/datamodel';
using { cappo.cds  } from '../db/CDSViews';

service CatalogService @(path:'CatalogService') {
    //End point to perform CURDQ operation - Create, Update, Read, Delete, Query
    //@readonly
    entity EmployeeSet as projection on master.employees;
    @Capabilities : { Updatable: false, Deletable : false }
    entity BusinessPartnerSet as projection on master.businesspartner;
    entity ProductSet as projection on master.product;
    entity PurchaseOrderItems as projection on transaction.poitems;
   entity POs @( odata.draft.enabled: true ) as projection on transaction.purchaseorder{
        *,
        round(GROSS_AMOUNT) as GROSS_AMOUNT: Decimal(10,2),
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Pending'
            when 'D' then 'Delivered'
            when 'A' then 'Approved'
            when 'X' then 'Rejected'
            end as OverallStatus: String(10),
        case OVERALL_STATUS
            when 'N' then 2
            when 'P' then 2
            when 'D' then 3
            when 'A' then 3
            when 'X' then 1
            end as Criticality: Integer,
        Items: redirected to PurchaseOrderItems
    }actions{
        //definition
        @cds.odata.bindingparameter.name: '_anubhav'
        @Common.SideEffects:{
            TargetProperties:['_anubhav/GROSS_AMOUNT']
        }
        action boost();
        function largestOrder() returns array of POs;
    };
    //entity CProductValuesView as projection on cds.CDSViews.CProductValuesView;
     
    // entity ProductView as projection on cds.CDSViews.ProductView{
    //     *,
    //     To_Items
    // };
    // entity POItems as projection on cds.CDSViews.ItemView;


}
