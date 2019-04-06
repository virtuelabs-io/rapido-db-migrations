var migration = require('../helpers/migrator')

let databases = [
    "customer"
]

databases.forEach(database => {
    var result = migration.run(database)
    result.then( value => {
        console.log(value)
    }).catch(e => {
        console.log(e)
    })
})
