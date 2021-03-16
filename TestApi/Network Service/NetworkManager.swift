//
//  NetworkManager.swift
//  TestApi
//
//  Created by Евгений Сергеевич on 08.03.2021.
//

import UIKit

struct NetworkManager {
    
    var covidDataHandler: (([Covid19Data]) -> Void?)!
    
    func fetchCurrentCovidDataForCountry(with string: String) {
        let request = NSMutableURLRequest(url: NSURL(string: "https://covid-19-data.p.rapidapi.com/country?name=\(string)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, responce, error) in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let covidData = try decoder.decode([Covid19Data].self, from: data)
                self.covidDataHandler?(covidData)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
  static func fetchCurrentCovidDataForRussia(url: String, completion: @escaping (_ coviddata: Covid19DataRussia)->()){
        guard let url = URL(string: url) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, responce, error) in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let covidData = try decoder.decode(Covid19DataRussia.self, from: data)
                completion(covidData)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}


