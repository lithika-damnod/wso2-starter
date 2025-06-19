import ballerina/sql;

type DatabaseConfig record {|
    string user;
    string password;
    string database;
    string host;
    int port;
|};

public type User record {|
    # User ID
    @sql:Column {name: "user_id"}
    int id;

    @sql:Column {name: "first_name"}
    string first_name;

    @sql:Column {name: "last_name"}
    string last_name;

    @sql:Column {name: "dob"}
    string dob;

    @sql:Column {name: "phone"}
    string phone;
|};

public type UserCreate record {|
    string first_name;
    string last_name;
    string dob;
    string phone;
|};

public type UserUpdate record {|
    string? first_name = ();
    string? last_name = ();
    string? dob = ();
    string? phone = ();
|};
