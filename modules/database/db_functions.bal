import ballerina/sql;

public isolated function getUsers() returns User[]|sql:Error {
    stream<User, sql:Error?> results = dbClient->query(getUsersQuery());
    User[]|sql:Error users = from User user in results
        select user;

    if users is sql:Error {
        return users;
    }
    return users;
}

public isolated function getUserById(int id) returns User|sql:Error {
    User user = check dbClient->queryRow(
        `SELECT * FROM Users.Users WHERE user_id = ${id}`
    );

    return user;
}

public isolated function insertUser(UserCreate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(insertUserQuery(payload));
}

public isolated function deleteUser(int id) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(deleteUserQuery(id));
}

public isolated function updateUser(int id, UserUpdate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(updatedUserQuery(id, payload));
}

public isolated function searchUsers(string search) returns User[]|sql:Error {
    stream<User, sql:Error?> results = dbClient->query(searchUsersQuery(search));
    User[]|sql:Error users = from User user in results
        select user;

    if users is sql:Error {
        return users;
    }
    return users;
}
