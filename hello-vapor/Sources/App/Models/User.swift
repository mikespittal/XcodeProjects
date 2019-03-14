import PostgreSQLProvider
//import AuthProvider

final class User: Model {
    var userName: String
    var email: String
    var password: String
    var userType: Int
    
    struct Keys {
        static let id = "id"
        static let username = "username"
        static let email = "email"
        static let password = "password"
        static let usertype = "userType"
    }
    
    init(userName: String, email: String, password: String, userType: Int) {
        self.userName = userName
        self.email = email
        self.password = password
        self.userType = userType
    }
    let storage = Storage()
    init(row: Row) throws {
        self.userName = try row.get(User.Keys.username)
        self.email = try row.get(User.Keys.email)
        self.password = try row.get(User.Keys.password)
        self.userType = try row.get(User.Keys.usertype)
    }
}


extension User: RowRepresentable {
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(User.Keys.username, userName)
        try row.set(User.Keys.email, email)
        try row.set(User.Keys.password, password)
        try row.set(User.Keys.usertype, userType)
        return row
    }
}

extension User: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { (builder) in
            builder.id()
            builder.string(User.Keys.username)
            builder.string(User.Keys.email)
            builder.string(User.Keys.password)
            builder.int(User.Keys.usertype)
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

extension User: JSONConvertible {
    convenience init(json: JSON) throws {
        try self.init(userName: json.get(User.Keys.username), email: json.get(User.Keys.email),
                      password: json.get(User.Keys.password), userType: json.get(User.Keys.usertype))
    }
    
    func makeJSON() throws -> JSON {
        var json = JSON()
        try json.set(User.Keys.id, id)
        try json.set(User.Keys.username, userName)
        try json.set(User.Keys.email, email)
        try json.set(User.Keys.usertype, userType)
        return json
    }
//    func makeDisplayForm() throws -> JSON {
//
//    }
    
}

