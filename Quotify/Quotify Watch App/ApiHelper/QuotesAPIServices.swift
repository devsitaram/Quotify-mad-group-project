//
//  QuotesAPIServices.swift
//  Quotify Watch App
//
//  Created by Anuza Simkhada on 12/05/2024.
//

import Foundation

class QuotesAPIServices: ObservableObject {
    let selectedCategory: String
    @Published var quotes: [Quote] = []
    @Published var category: String = ""
    
    init(selectedCategory: String) {
        self.selectedCategory = selectedCategory
    }

    func getQuotes() {
        guard let url = URL(string: "https://api.api-ninjas.com/v1/quotes?category=\(selectedCategory)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("A6Ef10DX16cYKutXjRT0xw==HXFUFRM3giV0IjtQ", forHTTPHeaderField: "X-Api-Key")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Quote].self, from: data)
                DispatchQueue.main.async {
                    self.quotes = result
                    if let firstQuote = result.first {
                        self.category = firstQuote.category
                    }
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
