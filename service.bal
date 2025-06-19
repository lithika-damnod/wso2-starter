import users.database;

import ballerina/http;
import ballerina/io;
import ballerina/sql;

service / on new http:Listener(9090) {

    # Creates a new user record in the database.
    #
    # + user - A `UserCreate` record containing the new user's data.
    # + return - `201 Created` if successful, or `500 Internal Server Error` on failure.
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

    # Retrieves users from the database, optionally filtered by a search term.
    #
    # + search - Optional query parameter to search by first or last name.
    # + return - A list of `User` records or `500 Internal Server Error` on failure.
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

    # Retrieves a user by their unique ID.
    #
    # + id - The ID of the user to retrieve.
    # + return - A `User` record if found, or `500 Internal Server Error` if not.
    resource function get users/[int id]() returns database:User|http:InternalServerError {
        database:User|error response = database:getUserById(id);

        if response is error {
            return <http:InternalServerError>{
                body: string `Error while retrieving the user with id ${id}`
            };
        }

        return response;
    }

    # Updates user details for a given ID using the provided payload.
    #
    # + id - The ID of the user to update.
    # + payload - A `UserUpdate` record with fields to update (partial update).
    # + return - `204 No Content` if successful, or `500 Internal Server Error` on failure.
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

    # Deletes a user by their unique ID.
    #
    # + id - The ID of the user to delete.
    # + return - `204 No Content` if successful, or `500 Internal Server Error` on failure.
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
