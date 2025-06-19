// # Returns the string `Hello` with the input string name.
// #
// # + name - name as a string or nil
// # + return - "Hello, " with the input string name
// public function hello(string? name) returns string {
//     if name !is () {
//         return string `Hello, ${name}`;
//     }
//     return "Hello, World!";
// }

// import ballerina/http;
// import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

configurable DatabaseConfig databaseConfig = ?;

final mysql:Client dbClient = check new (
    user = databaseConfig.user,
    password = databaseConfig.password,
    database = databaseConfig.database,
    host = databaseConfig.host,
    port = databaseConfig.port
);

// TODO: // final mysql:Client dbClient = check new (...databaseConfig);

