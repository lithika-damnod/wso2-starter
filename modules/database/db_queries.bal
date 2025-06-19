import ballerina/sql;

isolated function getUsersQuery() returns sql:ParameterizedQuery => `SELECT * FROM Users.Users`;

isolated function getUserByIdQuery(int id) returns sql:ParameterizedQuery => `SELECT * FROM Users.Users WHERE user_id=${id}`;

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

isolated function deleteUserQuery(int id) returns sql:ParameterizedQuery => `DELETE FROM Users.Users WHERE user_id=${id}`;

isolated function updatedUserQuery(int id, UserUpdate payload) returns sql:ParameterizedQuery => `
    UPDATE Users 
    SET 
        first_name = COALESCE(${payload.first_name}, first_name),
        last_name = COALESCE(${payload.last_name}, last_name),
        dob = COALESCE(${payload.dob}, dob),
        phone = COALESCE(${payload.phone}, phone)
    WHERE user_id = ${id}
`;

isolated function searchUsersQuery(string search) returns sql:ParameterizedQuery => `
    SELECT * FROM Users.Users WHERE LOWER(first_name) LIKE(CONCAT('%', ${search}, '%')) OR LOWER(last_name) LIKE LOWER(CONCAT('%', ${search}, '%'));
`;
