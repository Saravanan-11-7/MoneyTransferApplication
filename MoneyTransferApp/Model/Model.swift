//
//  Model.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 11/11/24.
//

import Foundation

// MARK: - Currency Model
struct CurrencyResponse: Codable {
    let result: CurrencyResult?
    
    enum CodingKeys: String, CodingKey {
        case result
    }
}

struct CurrencyResult: Codable {
    let depositCountry: String?
    let depositCurrency: String?
    let depositCountryCode: String?
    let data: [CurrencyData]?
    let timestamp: String?
    let errorCode: String?
    let responseStatus: String?
    let responseMessage: String?
    let reason: String?
    
    enum CodingKeys: String, CodingKey {
        case depositCountry
        case depositCurrency
        case depositCountryCode
        case data
        case timestamp
        case errorCode
        case responseStatus
        case responseMessage
        case reason
    }
}

struct CurrencyData: Codable {
    let currencypair: String?
    let countryCode: String?
    let exchangeRate: String?
    
    enum CodingKeys: String, CodingKey {
        case currencypair
        case countryCode
        case exchangeRate
    }
}

// MARK: - Country Model
struct Country: Codable {
    let flags: Flags?
    let name: FlagName?
    let cca2: String?
    let cioc: String?
    let currencies: [String: FlagCurrency]?
    let capital: [String]?
    let languages: [String: String]?
    
    enum CodingKeys: String, CodingKey {
        case flags
        case name
        case cca2
        case cioc
        case currencies
        case capital
        case languages
    }
}

struct Flags: Codable {
    let png: String?
    let svg: String?
    let alt: String?
    
    enum CodingKeys: String, CodingKey {
        case png
        case svg
        case alt
    }
}

struct FlagName: Codable {
    let common: String?
    let official: String?
    let nativeName: [String: NativeName]?
    
    enum CodingKeys: String, CodingKey {
        case common
        case official
        case nativeName
    }
}

struct NativeName: Codable {
    let official: String?
    let common: String?
    
    enum CodingKeys: String, CodingKey {
        case official
        case common
    }
}

struct FlagCurrency: Codable {
    let name: String?
    let symbol: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
    }
}
