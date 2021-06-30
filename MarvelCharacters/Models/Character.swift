import Foundation

struct CharacterResponse: Codable {
    //let code: Int?
    //let status: String?
    //let copyright : String?
    //let attributionText: String?
    //let attributionHTML: String?
    let data: CharacterData?
    //let etag: String?
}

struct CharacterData: Codable {
    //let offset: Int?
    //let limit: Int?
    //let total: Int?
    //let count: Int?
    let results:[CharacterResult]?
}

struct CharacterResult: Codable{
    let id: Int?
    let name: String?
    let description: String?
    //let modified: String?
    //let resourceURL: String?
    //let urls:[CharacterUrl]?
    let thumbnail:thumbnail?
    //let comics: Comic?
    //let stories: Story?
    //let events: Event?
    //let series: Serie?
}

/*struct CharacterUrl: Codable {
    let type: String?
    let url: String?
}*/

struct thumbnail: Codable {
    let path: String?
    let extensionn: String?
    
    private enum CodingKeys: String, CodingKey{
        case path
        case extensionn = "extension"
    }
}

/*struct Comic: Codable {
    let available: Int?
    let returned: Int?
    let colletionURL: String?
    let items: [Item]?
}

struct Item: Codable {
    let resourceURL:String?
    let name: String?
    let type: String?
}

struct Story: Codable {
    let available: Int?
    let returned: Int?
    let colletionURL: String?
    let items:[Item]?
}

struct Event: Codable {
    let available: Int?
    let returned: Int?
    let colletionURIL: String?
    let items: [Item]?
}

struct Serie: Codable {
    let available: Int?
    let returned: Int?
    let colletionURL: String?
    let items: [Item]?
}*/
