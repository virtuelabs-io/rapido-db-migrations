var migration = require('../helpers/migrator')

let databases = [
    "customer",
    "cart",
    "orders"
]

let resolvedDatabases = []

databases.forEach(database => {
    var result = migration.run(database)
    result.then( value => {
        console.log("Finished processing migrations for: "  + value)
        migrationMarker(value)
    }).catch(e => {
        console.log(e)
        process.exit(1)
    })
})

function migrationMarker(database){
    resolvedDatabases.push(database)
    if(resolvedDatabases == database){
        process.exit()
    }
}
