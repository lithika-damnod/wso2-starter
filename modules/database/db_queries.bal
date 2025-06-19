import ballerina/sql;

# Generates a SQL query to retrieve all users.
#
# + return - A `sql:ParameterizedQuery` to select all records from the Users table.
isolated function getUsersQuery() returns sql:ParameterizedQuery => `SELECT * FROM Users.Users`;

# Generates a SQL query to retrieve a single user by their ID.
#
# + id - The unique identifier of the user.
# + return - A `sql:ParameterizedQuery` that fetches a specific user.
isolated function getUserByIdQuery(int id) returns sql:ParameterizedQuery => `SELECT * FROM Users.Users WHERE user_id=${id}`;

# Generates a SQL insert query to add a new user.
#
# + payload - A `UserCreate` record containing the new user's data.
# + return - A `sql:ParameterizedQuery` to insert a new record into the Users table.
isolated function insertUserQuery(UserCreate payload) returns sql:ParameterizedQuery => `
    INSERT INTO Users.Users
    (
        first_name, 
        last_name, 
        dob, 
        phone
    ) 
    VALUES 
    (
        ${payload.first_name}, 
        ${payload.last_name}, 
        ${payload.dob}, 
        ${payload.phone}
    )
`;

# Generates a SQL query to delete a user by their ID.
#
# + id - The unique identifier of the user to delete.
# + return - A `sql:ParameterizedQuery` to delete the user record.
isolated function deleteUserQuery(int id) returns sql:ParameterizedQuery => `DELETE FROM Users.Users WHERE user_id=${id}`;

# Generates a SQL update query to modify user details.
#
# + id - The unique identifier of the user to update.
# + payload - A `UserUpdate` record containing fields to update. Fields left as null will be ignored.
# + return - A `sql:ParameterizedQuery` to update the user record with optional fields.
isolated function updatedUserQuery(int id, UserUpdate payload) returns sql:ParameterizedQuery => `
    UPDATE Users 
    SET 
        first_name = COALESCE(${payload.first_name}, first_name),
        last_name = COALESCE(${payload.last_name}, last_name),
        dob = COALESCE(${payload.dob}, dob),
        phone = COALESCE(${payload.phone}, phone)
    WHERE user_id = ${id}
`;

# Generates a SQL search query to find users by partial name match.
#
# + search - A case-insensitive search keyword used to match first or last names.
# + return - A `sql:ParameterizedQuery` to fetch users where the name contains the search term.
isolated function searchUsersQuery(string search) returns sql:ParameterizedQuery => `
    SELECT * FROM Users.Users WHERE LOWER(first_name) LIKE(CONCAT('%', ${search}, '%')) OR LOWER(last_name) LIKE LOWER(CONCAT('%', ${search}, '%'));
`;
