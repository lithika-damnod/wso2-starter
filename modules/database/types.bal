import ballerina/sql;

# Configuration details required to establish a database connection.
type DatabaseConfig record {|
    # Username used for database authentication.
    string user;

    # Password associated with the database user.
    string password;

    # Name of the target database.
    string database;

    # Hostname or IP address of the database server.
    string host;

    # Port on which the database server is running.
    int port;
|};

# Represents a user record as stored in the `Users` table.
public type User record {|
    # Unique identifier of the user.
    @sql:Column {name: "user_id"}
    int id;

    # First name of the user.
    @sql:Column {name: "first_name"}
    string first_name;

    # Last name of the user.
    @sql:Column {name: "last_name"}
    string last_name;

    # Date of birth of the user (formatted as a string: yyyy-mm-dd).
    @sql:Column {name: "dob"}
    string dob;

    # Phone number of the user.
    @sql:Column {name: "phone"}
    string phone;
|};

# Payload used to create a new user in the system.
public type UserCreate record {|
    # First name of the user.
    string first_name;

    # Last name of the user.
    string last_name;

    # Date of birth of the user (formatted as a string: yyyy-mm-dd).
    string dob;

    # Phone number of the user.
    string phone;
|};

# Payload used to update existing user details.
#
# All fields are optional and will only update values if provided.
public type UserUpdate record {|
    # Updated first name of the user.
    string? first_name = ();

    # Updated last name of the user.
    string? last_name = ();

    # Updated date of birth of the user.
    string? dob = ();

    # Updated phone number of the user.
    string? phone = ();
|};
