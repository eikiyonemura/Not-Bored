//
//  SugestionService.swift
//  Not Bored
//
//  Created by Douglas Eiki Yonemura on 23/06/22.
//

import Foundation
import Alamofire

class SugestionService {
    
    let apiClient = AlamofireAPIClient()
    
    func getSugestion(urlString: String, completion: @escaping (Sugestion?) -> Void) {
        apiClient.get(url: urlString) { response in
            switch response {
            case .success(let data):
                do {
                    if let data = data {
                        let sugestion = try JSONDecoder().decode(Sugestion.self, from: data)
                        completion(sugestion)
                    }
                } catch {
                    completion(nil)
                }
            case.failure(_):
                completion(nil)
            }
        }
    }
}

class AlamofireAPIClient {
    func get(url:String, completion: @escaping (Result<Data?, AFError>) -> Void) {
        AF.request(url).response { response in
            completion(response.result)
        }
    }
}
