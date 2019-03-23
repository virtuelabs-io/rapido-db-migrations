const { createDb, migrate } = require("postgres-migrations")

function run(database) {
    return new Promise((resolve, reject) => {
        createDb( database, {
            user: process.env.DB_USER,
                password: process.env.DB_PASSWORD,
                host: process.env.HOST,
                port: Number(process.env.PORT)
        }).then(() => {
            return migrate({
                database: database,
                user: process.env.DB_USER,
                password: process.env.DB_PASSWORD,
                host: process.env.HOST,
                port: Number(process.env.PORT)
            }, './src/migrations/' + database)
        }).then(() => {
            let r = [
                "Successfully migrated",
                database,
                "in",
                "./src/migrations/" + database
            ].join(" ")
            console.log(r)
            resolve( JSON.stringify({
                result: r
            }))
        }).catch((err) => {
            reject(err)
        })
    })
}

module.exports.run = run
