//
//  Services.swift
//  WeatherForecast
//
//  Created by Vaibhav on 26/03/21.
//

import Foundation

class Services {
    static func getApiData<T: Codable>(url: String, completion: @escaping (T?) -> Void){
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(T.self, from: data)
                        return completion(res)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }

}




