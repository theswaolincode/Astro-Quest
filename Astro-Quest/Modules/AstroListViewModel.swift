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
        var showingAlert = false
        var searchText: String = "moon"

        func readLocalJSONFile() async {
                   guard items?.isEmpty ?? true else { return }
                   
                   do {
                       guard let filePath = Bundle.main.path(forResource: "nasa_moon_results", ofType: "json") else {
                           print("Can't find file")
                           return
                       }
                       
                       let fileUrl = URL(fileURLWithPath: filePath)
                       let data = try Data(contentsOf: fileUrl)
                       let response = try JSONDecoder().decode(MediaItemsResponse.self, from: data)
                       response.collection?.items?.forEach({ item in
                           self.items?.append(AstroItem(item: item))
                       })
                   } catch {
                       self.items = []
                   }
               }
        
        func getAstroData() async {
            // Define the URL for the API
            let apiUrl = URL(string: "https://images-api.nasa.gov/search?q=\(searchText)")!

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
