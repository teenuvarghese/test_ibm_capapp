namespace ibmcapapp.srv;
using { anubhav.db.master as master  } from '../db/datamodel';

service MyService {
    function helloWorld(name:String(10))
    returns String(25);
    function calcRadius(radius: Int16) returns Int64;
    @readonly
    entity ReadEmployeeSrv as projection on master.employees;
}

