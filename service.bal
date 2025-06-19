import users.database;

import ballerina/http;
import ballerina/io;
import ballerina/sql;

service / on new http:Listener(9090) {

    resource function post users(database:UserCreate user) returns http:Created|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:insertUser(user);

        io:print(response);

        if response is error {
            return <http:InternalServerError>{
                body: "Error while inserting new user"
            };
        }

        return http:CREATED;
    }

    resource function get users(string? search) returns database:User[]|http:InternalServerError {
        database:User[]|error response;

        if search == () {
            response = database:getUsers();
        } else {
            response = database:searchUsers(search);
        }

        if response is error {
            return <http:InternalServerError>{
                body: "Error while retrieving users"
            };
        }

        return response;
    }

    resource function get users/[int id]() returns database:User|http:InternalServerError {
        database:User|error response = database:getUserById(id);

        if response is error {
            return <http:InternalServerError>{
                body: string `Error while retrieving the user with id ${id}`
            };
        }

        return response;
    }

    resource function patch users/[int id](database:UserUpdate payload) returns http:NoContent|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:updateUser(id, payload);

        io:print(response);

        if response is sql:Error {
            return <http:InternalServerError>{
                body: "Error while updating book"
            };
        }

        return http:NO_CONTENT;
    }

    resource function delete users/[int id]() returns http:NoContent|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:deleteUser(id);

        if response is sql:Error {
            return <http:InternalServerError>{
                body: string `Error while deleting the user with id ${id} `
            };
        }

        return http:NO_CONTENT;
    }

}
