//
//  Service.swift
//  MoneyTransferApp
//
//  Created by Saravanan on 11/11/24.
//

import Foundation
import UIKit

class Service {
    
    static let shared = Service()
    
// MARK: - Fetch currency convertion
    func fetchCurrencyData(completion: @escaping (Result<CurrencyResponse, Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "CurrencyStub", ofType: "json") else {
            completion(.failure(NSError(domain: "Service", code: -1, userInfo: [NSLocalizedDescriptionKey: "Local stub data not found."])))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let currency = try JSONDecoder().decode(CurrencyResponse.self, from: data)
            completion(.success(currency))
        } catch {
            print("Error loading or decoding local stub data: \(error)")
            completion(.failure(error))
        }
    }
    
    // MARK: - Fetch countries
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        let urlString = "https://restcountries.com/v3.1/independent?fields=name,languages,capital,flags,currencies,cca2,cioc"
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching countries: \(error?.localizedDescription ?? "")")
                return
            }
            
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                completion(.success(countries))
            } catch {
                print("Error decoding countries: \(error)")
            }
        }
        task.resume()
    }
    // MARK: - Download images
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
    
}
