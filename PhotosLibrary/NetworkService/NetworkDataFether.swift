//
//  NetworkDataFether.swift
//  PhotosLibrary
//
//  Created by Поляндий on 10.09.2022.
//

import Foundation

class NetworkDataFether {
    
    var network = Network()
    
    func fetchImages(searchItem: String, complition: @escaping (SearchResults?) -> ()) {
        network.request(searchItem: searchItem) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                complition(nil)
            }
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            complition(decode)
        }
    }
    
    func decodeJSON<T: Codable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let items = try decoder.decode(type.self, from: data)
            return items
        } catch let JSONError {
            print("Failed to decode JSON", JSONError)
            return nil
        }
    }
    
}
