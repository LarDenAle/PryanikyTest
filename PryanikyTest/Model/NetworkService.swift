//
//  NetworkManager.swift
//  PryanikyTest
//
//  Created by Denis Larin on 31.01.2021.
//

import Foundation
import UIKit

class NetworkService {
    
    func fetchData(completion: @escaping (Pryaniky) -> Void)  {
        let urlString = "https://pryaniky.com/static/json/sample.json"
        guard  let url = URL(string: urlString) else { print("Error, line 16"); return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                let data = data,
                let pryaniky = self.parseJSON(withData: data) else { return }
            completion(pryaniky)
        }
        task.resume()
    }

    func parseJSON(withData data: Data) -> Pryaniky? {
        let decoder = JSONDecoder()
        do {
            let pryaniky = try decoder.decode(Pryaniky.self, from: data)
            return pryaniky
        } catch {
            print("Error")
        }
        return nil
    }
}
