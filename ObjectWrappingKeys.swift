import Foundation


let commitsString = """
[
  {
      "initial": {
        "author": "apollo",
        "message": "Initial commit",
        "date": "2017-06-21T15:29:32Z"
      }
  },
  {
      "readme_update": {
         "author": "thecoolguy",
         "message": "Update README",
         "date": "2017-06-21T19:29:32Z"
      }
  }
]
"""

struct GitCommit : Decodable {
    let author: String
    let message: String
    let date: String
}

let data = commitsString.data(using: .utf8)!
let decoder = JSONDecoder()
let commitsMap = try decoder.decode([[String:GitCommit]].self, from: data)

for commits in commitsMap {
    for (name, commit) in commits {
        print("\(name): \(commit)")
    }
}

