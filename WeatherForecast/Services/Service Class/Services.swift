//
//  Services.swift
//  WeatherForecast
//
//  Created by Vaibhav on 26/03/21.
//

import Foundation


class Services {
    static func postAction(params: [String: Any], url: String, completion:@escaping(WeatherData?, Bool)-> Void) {
        guard let serviceUrl = URL(string: url) else {
            return
        }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data ?? Data(), options: [])
//                print(json)
                
                let data = self.jsonToData(json: json as Any)
                do {
                    let decoder = JSONDecoder()
                    let userModel = try decoder.decode(WeatherData.self, from: data ?? Data())
//                    print(userModel)
                    completion(userModel, true)
                } catch  {
                    print("Error: \(error.localizedDescription)")
                    print("Error: \(error)")
                    completion(nil, false)
                }
            } catch {
//                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    static func getWeatherData(url: String, completion: @escaping (WeatherData) -> Void){
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(WeatherData.self, from: data)
                        return completion(res)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    static func getFiveDayWeatherData(url: String, completion: @escaping (WeatherData?) -> Void){
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let res = try JSONDecoder().decode(WeatherData.self, from: data)
                        return completion(res)
                    } catch let error {
                        print(error)
                    }
                }
            }.resume()
        }
    }
    
    static func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let JSONError {
            print(JSONError)
        }
        return nil
    }

}




