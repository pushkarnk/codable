import Foundation

struct GitCommit : Encodable {
    let author: String
    let message: String
    let date: Date
}

let commit = GitCommit(author: "clattner",
                       message: "first commit",
                       date: Date())

let encoder = JSONEncoder()
encoder.dateEncodingStrategy = .iso8601
encoder.outputFormatting = .prettyPrinted

let data = try encoder.encode(commit)
let json = String(data: data, encoding: .utf8)!
print(json)
