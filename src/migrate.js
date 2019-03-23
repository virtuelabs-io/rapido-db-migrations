'use strict';

module.exports.fun = async (event, context, callback) => {
    context.callbackWaitsForEmptyEventLoop = false;
    global.fetch = require('node-fetch');
    var migration = require('./helpers/migrator')
    var database = event.body;
    var result = migration.run(database)
    result.then( value => {
        console.log(value)
        callback(JSON.stringify(value))
    }).catch(e => {
        console.log(e)
    })
}
