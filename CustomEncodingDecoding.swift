import Foundation 

struct GitCommit : Codable {
    let author: String
    let message: String
    let date: Date 
    
    let filesModified: [String]? //files_modified
    let filesAdded: [String]?    //files_added
    let filesDeleted: [String]?  //files_deleted

    let commitHash: String

    enum CodingKeys: String, CodingKey {
        case author
        case message
        case date
        case commitHash = "hash"
        case filesModified = "files_modified"
        case filesAdded = "files_added"
        case filesDeleted = "files_deleted"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)         
        try container.encode(author, forKey: .author)
        try container.encode(message, forKey: .message)
        try container.encode(date, forKey: .date)
        try container.encode(commitHash, forKey: .commitHash)

        //try container.encode(filesModified, forKey: .filesModified)
        var modified = container.nestedUnkeyedContainer(forKey: .filesModified) 
        try filesModified?.forEach {
            try modified.encode($0.components(separatedBy: "/")[1])
        }

        try container.encodeIfPresent(filesAdded, forKey: .filesAdded)
        try container.encodeIfPresent(filesDeleted, forKey: .filesDeleted)
    }

}

extension GitCommit {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let author = try container.decode(String.self, forKey: .author)
        let message = try container.decode(String.self, forKey: .message)
        let date = try container.decode(Date.self, forKey: .date)
        let hash = try container.decode(String.self, forKey: .commitHash)
        let filesAdded = try container.decodeIfPresent([String].self, forKey: .filesAdded)
        let filesDeleted = try container.decodeIfPresent([String].self, forKey: .filesDeleted)
        var filesModifiedContainer = try container.nestedUnkeyedContainer(forKey: .filesModified)
        var filesModified: [String] = []
        while !filesModifiedContainer.isAtEnd {
            let fileName = try filesModifiedContainer.decode(String.self)
            filesModified.append("Sources/\(fileName)")
        }
        self.init(author: author,
                  message: message,
                  date: date,
                  filesModified: filesModified,
                  filesAdded: filesAdded,
                  filesDeleted: filesDeleted,
                  commitHash: hash)
    }
}

let commit = GitCommit(author: "badguy", 
                       message: "Corrected grammatical mistakes!", 
                       date: Date(), 
                       filesModified: ["Sources/a.swift", "Sources/b.swift", "Sources/c.swift"], 
                       filesAdded: nil, 
                       filesDeleted: nil, 
                       commitHash: "ca82a6dff817ec66f44342007202690a93763949") 

let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601
let data = try! encoder.encode(commit)
let commitString = String(data: data, encoding: .utf8)!

print(commitString)

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let commitData = commitString.data(using: .utf8)!
let commit1 = try decoder.decode(GitCommit.self, from: commitData) 
print(commit1)

    
