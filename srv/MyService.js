module.exports = async (srv) => {
    srv.on('helloWorld',(req)=>{
        return "Hello" + req.data.name;
    })
    srv.on('calcRadius', (req) => {
        return 3.14 * req.data.radius * req.data.radius ;
    })
      srv.on("READ", "ReadEmployeeSrv", async(req,res) =>{
    // srv.on("READ", "ReadEmployeeSrv", async(req,res) =>{
    //     //exmaple 1: replace your own data
    //     return {
    //         "ID": "SPIDERMAN",
    //         "nameFirst": "Peter",
    //         "nameLast": "Parker",
    //         "nameInitials": "Mr.",
    //     };
    // });

    const {employees} = cds.entities("anubhav.db.master");
    //Example 2: Manually extraction of data using CDS QL
    const cdstx = await cds.tx(req);
    const results = await cdstx.run(SELECT.from(employees).limit(5)
    .where({salaryAmount: {'>=' : 25000}}));
   // return results;
   var myResult = [];
        for (let i = 0; i < results.length; i++) {
            const element = results[i];
            myResult.push({
                nameFirst: element.nameFirst + " " + element.nameLast,
                salaryAmount: element.salaryAmount,
                ID: element.ID
            })
        };
        return myResult;
      });
}
