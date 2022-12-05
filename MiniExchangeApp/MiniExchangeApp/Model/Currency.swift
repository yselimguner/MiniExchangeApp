//
//  Currency.swift
//  MiniExchangeApp
//
//  Created by Yavuz Güner on 3.12.2022.
//

import Foundation

//   let currency = try? newJSONDecoder().decode(Currency.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.currencyTask(with: url) { currency, response, error in
//     if let currency = currency {
//       ...
//     }
//   }
//   task.resume()


// MARK: - Currency
struct Currency: Codable {
    let result: String
    let documentation, termsOfUse: String
    let timeLastUpdateUnix: Int
    let timeLastUpdateUTC: String
    let timeNextUpdateUnix: Int
    let timeNextUpdateUTC, baseCode: String
    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case result, documentation
        case termsOfUse = "terms_of_use"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUTC = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUTC = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}
