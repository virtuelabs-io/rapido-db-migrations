var mysql = require('mysql');
let {CommandsRunner, MysqlDriver} = require('node-db-migration');

async function run(database){
    return new Promise((resolve, reject) => {
        var connection = mysql.createConnection({
            "host": process.env.HOST,
            "port": Number(process.env.PORT),
            "user": process.env.DB_USER,
            "password": process.env.DB_PASSWORD,
            "database": process.env.ROOT_DB,
            "multipleStatements" : true
        });
        connection.connect(function(err) {
            let migrations = new CommandsRunner({
                driver: new MysqlDriver(connection),
                directoryWithScripts: './src/migrations/' + database,
            });
            migrations.run(process.argv[2]).then(() => {
                resolve( database ) 
            }).catch((err) => {
                reject(err)
            })
        })
    })
}

module.exports.run = run
