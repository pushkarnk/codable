import Foundation

let commitsString = """
{
 "commits": [
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
}
"""

struct GitCommit : Decodable {
    let author: String
    let message: String
    let date: String
}

struct GitCommits : Decodable {
    let commits: [GitCommit]
}

let data = commitsString.data(using: .utf8)!
let decoder = JSONDecoder()
let commits = try! decoder.decode(GitCommits.self, from: data)

for commit in commits.commits {
    print(commit)
}
