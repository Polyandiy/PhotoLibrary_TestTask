//
//  Network.swift
//  PhotosLibrary
//
//  Created by Поляндий on 10.09.2022.
//

import Foundation

class Network {
    
    func request(searchItem: String, complition: @escaping (Data?, Error?) -> Void) {
        let parameters = self.prepareParameters(searchItem: searchItem)
        let url = self.url(params: parameters)
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "GET"
        
        let task = createDataTask(from: request, completion: complition)
        task.resume()
    }
    
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID kaTYd6_oC8w8eS8KpqGlER0c4Vkd2i3DrB60scs40mI"
        
        return headers
    }
    
    private func prepareParameters(searchItem: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchItem
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1 )}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
