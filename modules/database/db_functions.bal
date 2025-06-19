import ballerina/sql;

# Retrieves all users from the database. 
#
# + return - An array of `User` records if successful; otherwise, a `sql:Error`.
public isolated function getUsers() returns User[]|sql:Error {
    stream<User, sql:Error?> results = dbClient->query(getUsersQuery());
    User[]|sql:Error users = from User user in results
        select user;

    if users is sql:Error {
        return users;
    }
    return users;
}

# Retrieves a single user by their unique ID.
#
# + id - The unique identifier of the user.
# + return - A `User` record if found; otherwise, a `sql:Error`.
public isolated function getUserById(int id) returns User|sql:Error {
    User user = check dbClient->queryRow(
        `SELECT * FROM Users.Users WHERE user_id = ${id}`
    );

    return user;
}

# Inserts a new user into the database.
#
# + payload - A `UserCreate` record containing the user data to insert.
# + return - A `sql:ExecutionResult` on success; otherwise, a `sql:Error`.
public isolated function insertUser(UserCreate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(insertUserQuery(payload));
}

# Deletes a user from the database by their ID.
#
# + id - The unique identifier of the user to delete.
# + return - A `sql:ExecutionResult` on success; otherwise, a `sql:Error`.
public isolated function deleteUser(int id) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(deleteUserQuery(id));
}

# Updates user information based on the given ID and update payload.
#
# + id - The unique identifier of the user to update.
# + payload - A `UserUpdate` record containing the fields to update.
# + return - A `sql:ExecutionResult` on success; otherwise, a `sql:Error`.
public isolated function updateUser(int id, UserUpdate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(updatedUserQuery(id, payload));
}

# Searches users by a partial match on fields like first name or last name.
#
# + search - A case-insensitive keyword used for matching user records.
# + return - A list of matching `User` records if successful; otherwise, a `sql:Error`.
public isolated function searchUsers(string search) returns User[]|sql:Error {
    stream<User, sql:Error?> results = dbClient->query(searchUsersQuery(search));
    User[]|sql:Error users = from User user in results
        select user;

    if users is sql:Error {
        return users;
    }
    return users;
}
