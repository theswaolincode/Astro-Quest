//
//  AstroListViewModel.swift
//  Astro-Quest
//
//  Created by Daniel Ayala on 10/3/24.
//

import Foundation
import SwiftUI

extension AstroListView {
    @Observable class ViewModel{
        var visibility: NavigationSplitViewVisibility = .all
        var items: [AstroItem]? = []
        
        func getAstroData() async {
            // Define the URL for the API
            let apiUrl = URL(string: "https://images-api.nasa.gov/search?q=moon")!

            // Create a URLRequest
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "GET"

            // Perform the API request using URLSession
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // Check for errors
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // Check if there is data
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    // Try to decode the JSON response
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MediaItemsResponse.self, from: data)
                    // Now you can access the response object
                    print(response)
                    
                    response.collection?.items?.forEach({ item in
                        self.items?.append(AstroItem(item: item))
                    })
                    
                } catch let decodingError {
                    print("Error decoding JSON: \(decodingError)")
                }
            }

            // Start the task
            task.resume()
        }
    }
}
