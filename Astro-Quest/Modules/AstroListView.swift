//
//  AstroListView.swift
//  Astro-Quest
//
//  Created by Daniel Ayala on 10/3/24.
//

import SwiftUI

struct AstroListView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationSplitView(columnVisibility: $viewModel.visibility) {
            List(viewModel.items ?? [], id: \.self) { item in
                NavigationLink(item.title, value: item)
            }
            .navigationTitle("Categories")
            .navigationDestination(for: AstroItem.self) { item in
                HStack {
                    ImageItemView(imageURL: item.image, height: 150)
                    Text(item.description)
                }
            }
        } detail: {
            Text("Select an item from the list")
        }
        .task {
            await self.viewModel.getAstroData()
        }
    }
}

#Preview {
    AstroListView()
}
