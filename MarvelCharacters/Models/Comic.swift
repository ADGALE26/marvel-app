import Foundation

struct ComicResponse: Codable {
    let code: Int?
    let status, copyright ,attributionText, attributionHTML: String?
    let data: ComicData?
    let etag: String?
}

struct ComicData: Codable {
    //let offset, limit, total, count: Int?
    let results: [ComicResult]?
}

struct ComicResult: Codable {
    //let id, digitalId, pageCount: Int?
    //let title, variantDescription, description, isbn, upc, diamondCode, ean, issn, format, ResourceURL: String?
    //let issueNumber: Double?
    //let modified: Date?
    //let textObjets:[ComicTextObject]?
    //let url: [ComicUrl]?
    //let series: ComicSerie?
    //let variants: [ComicVariant]?
    //let collections: [ComicCollection]?
    //let collectedIssues: [ComicCollectedIssue]?
    //let dates: [ComicDate]?
    //let prices: [ComicPrice]?
    let thumbnail: ComicThumnail?
    //let images: [ComicImage]?
    //let creators: ComicCreator?
    //let characters: ComicCharacter?
    //let stories: ComicStory?
    //let events: ComicEvent?
    
}

/*struct ComicTextObject: Codable {
    let type, language, text: String?
}*/

/*struct ComicUrl: Codable {
    let type, url: String?
}

struct ComicSerie: Codable {
    let resourceUrl, name: String?
}

struct ComicVariant: Codable {
    let resourceUrl, name: String?
}

struct ComicCollection: Codable {
    let resourceUrl, name: String?
}

struct ComicCollectedIssue: Codable {
    let resourceUrl, name: String?
}

struct ComicDate: Codable {
    let type: String?
    //let date: Date?
}

struct ComicPrice: Codable {
    let type: String?
    let price: Float?
}*/

struct ComicThumnail: Codable {
    let path: String?
    let extensionn: String?
    
    private enum CodingKeys: String, CodingKey{
        case path
        case extensionn = "extension"
    }
}
/*
struct ComicImage: Codable {
    let path: String?
    let extensionn: String?
    
    private enum CodingKeys: String, CodingKey{
        case path
        case extensionn = "extension"
    }
}

struct ComicCreator: Codable {
    let available, returned: Int?
    let collectionURL: String?
    let items: [ComicItem]?
}

struct ComicItem: Codable {
    let resourceURL, name, role: String?
}

struct ComicCharacter: Codable {
    let available, returned: Int?
    let collectionURL: String?
    let items: [ComicItem]?
}

struct ComicStory: Codable {
    let available, returned: Int?
    let collectionURL: String?
    let items: [ComicItem]?
}

struct ComicEvent: Codable {
    let available, returned: Int?
    let collectionURL: String?
    let items: [ComicItem]?
}*/







