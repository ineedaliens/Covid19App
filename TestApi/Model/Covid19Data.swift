// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//

import Foundation


struct Covid19Data: Decodable {
    let country: String
    let code: String
    var confirmed: Int
    var recovered: Int
    var critical: Int
    var deaths: Int
    let lastChange: String
    var lastUpdate: String {
       let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateStyle = .short
        dateFormatter.locale = .init(identifier: "Ru_ru")
        let strings = dateFormatter.string(from: date)
        return strings
    }
}

struct Covid19DataRussia: Decodable {
    let infected, tested, recovered, deceased: Int
    var infectedByRegion: [InfectedByRegion]
    let country: String
    let historyData, sourceURL: String
    let lastUpdatedAtApify, lastUpdatedAtSource: String
    let readMe: String

    enum CodingKeys: String, CodingKey {
        case infected, tested, recovered, deceased, infectedByRegion, country, historyData
        case sourceURL = "sourceUrl"
        case lastUpdatedAtApify, lastUpdatedAtSource, readMe
    }
}

// MARK: - InfectedByRegion
struct InfectedByRegion: Decodable {
    var region, isoCode: String
    var infected, recovered, deceased: Int
}
