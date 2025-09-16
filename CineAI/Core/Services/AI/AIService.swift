//
//  AIService.swift
//  CineAI
//
//  Created by MB-BTMC001 on 29.08.2025.
//

import Foundation
import Alamofire

protocol AIServiceProtocol{
    
    func getSimilarMovies(title:String, completion: @escaping (Result<String,Error>) -> Void)
}

struct GeminiResponse: Codable {
    let candidates: [Candidate]
}

struct Candidate: Codable {
    let content: Content
}

struct Content: Codable {
    let parts: [Part]
}

struct Part: Codable {
    let text: String
}

class AIService: AIServiceProtocol{
    
    private let apiKey = ""
    let baseUrl = ""
    
    
        func getSimilarMovies(title: String, completion: @escaping (Result<String, Error>) -> Void) {
            
                let prompt = "Önerilecek fimlerin listesini madde madde formatında ver.\(title) filmine benzer popüler filmler öner. kısa ve net cevap ver"
                
            let parameters: [String: Any] = [
                  "contents": [
                      [
                          "role": "user",
                          "parts": [
                              ["text": prompt]
                          ]
                      ]
                  ]
              ]
                  
                  let headers: HTTPHeaders = [
                      "Content-Type": "application/json"
                  ]
                  
                AF.request(
                
                    "\(baseUrl)?key=\(apiKey)",
                    method: .post,
                    parameters: parameters,
                    encoding: JSONEncoding.default,
                    headers: headers
                )
                
                .responseDecodable(of:GeminiResponse.self){response in
                    switch response.result{
                    case.success(let geminiResponce):
                        guard let text = geminiResponce.candidates.first?.content.parts.first?.text else {
                            
                            let error = NSError(domain: "AIServiceError", code: 0, userInfo: [NSLocalizedDescriptionKey: "AI cevabı bulunamadı."])
                            completion(.failure(error))
                            return
                        }
                        completion(.success(text))
                        
                    case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }

