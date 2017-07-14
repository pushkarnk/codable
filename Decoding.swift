import Foundation

let commitString = """
{
  "author": "clattner",
  "message": "first commit",
  "date": "2017-07-14T20:51:42Z"
}
"""

struct GitCommit : Decodable {
    let author: String
    let message: String
    let date: Date
}

let data = commitString.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let commit = try decoder.decode(GitCommit.self, from: data)
print(commit)
