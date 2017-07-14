import Foundation

let commitString = """
{
  "author": "clattner",
  "message": "first commit",
  "date": "2017-07-14T20:51:42Z",
  "commit_hash": "ce1a76c081f4b0bb98a33d98e595db95c7a4c871"
}
"""

struct GitCommit : Decodable {
    let author: String
    let message: String
    let date: Date
    let commitHash: String

    enum CodingKeys: String, CodingKey {
        case author
        case message
        case date
        case commitHash = "commit_hash"
    }
}

let data = commitString.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let commit = try decoder.decode(GitCommit.self, from: data)
print(commit)
