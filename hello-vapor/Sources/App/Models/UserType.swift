import PostgreSQLProvider

final class UserType: Model {
    
    let storage = Storage()
    
    var description: String
    
    struct Keys {
        static let id = "id"
        static let description = "description"
    }
    
    init(_description: String) {
        self.description = _description
    }
    
    init(row: Row) throws {
        self.description = try row.get(UserType.Keys.description)
    }
}


extension UserType: RowRepresentable {
    func makeRow() throws -> Row {
        var row = Row()
        try row.set(UserType.Keys.description, description)
        return row
    }
}

extension UserType: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self) { builder in
            builder.id()
            builder.string(UserType.Keys.description)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}

