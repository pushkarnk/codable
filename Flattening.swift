import Foundation

let commitString = """
{
    "author": "simplyhacking",
    "message": "Fixed that data race",
    "date": "2017-06-21T15:29:32Z",
    "tag": {
        "major": 10,
        "minor": 19
    }
}
""" 

struct GitCommit : Codable {
    let author: String
    let message: String
    let date: Date
    let tag: String
  
    enum CodingKeys: String, CodingKey {
        case author
        case message
        case date
        case tag
    }

    enum TagCodingKeys: String, CodingKey {
        case major
        case minor
    }
}

extension GitCommit {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let author = try container.decode(String.self, forKey: .author)
        let date = try container.decode(Date.self, forKey: .date)
        let message = try container.decode(String.self, forKey: .message)
        let tags = try container.nestedContainer(keyedBy: TagCodingKeys.self, forKey: .tag)
        let major = try tags.decode(Int.self, forKey: .major)
        let minor = try tags.decode(Int.self, forKey: .minor)
       
        self.init(author: author,
                  message: message,
                  date: date,
                  tag: "\(major).\(minor)")
    }
} 

let data = commitString.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
let commit = try decoder.decode(GitCommit.self, from: data)
print(commit)
