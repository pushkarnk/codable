import Foundation


let commitsString = """
[
  {
    "author": "apollo",
    "message": "Initial commit",
    "date": "2017-06-21T15:29:32Z"
  },
  {
     "author": "thecoolguy",
     "message": "Update README",
     "date": "2017-06-21T19:29:32Z"
  }
]
"""

struct GitCommit : Decodable {
    let author: String
    let message: String
    let date: Date 
}

let data = commitsString.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let commits = try! decoder.decode([GitCommit].self, from: data)

for commit in commits {
    print(commit)
}



