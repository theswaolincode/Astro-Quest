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
                AstroDetailView(item: item)
            }
            .navigationSplitViewColumnWidth(250)
            .toolbar(content: {
                Button(action: { viewModel.isShowingSearchInput = true }) {
                    Image(systemName: "magnifyingglass")
                }
            })
        } detail: {
            Text("""
                Welcome to Astro Quest
                We Selected some Moon Data for you
                However you can always tap search on the sidebar and look for anything related to Nasa files
                """)
                .font(.title)
                .bold()
                .padding()
        }
        .navigationSplitViewStyle(.balanced)
        .alert("Search", isPresented: $viewModel.isShowingSearchInput) {
            TextField("Search Field", text: $viewModel.searchText)
            Button("OK", action: submit)
        } message: {
            Text("Enter An Astro Name")
        }
        .alert("Try Again", isPresented: $viewModel.isShowingSearchNoResultsAlert) {
            Button("OK", action: {})
        } message: {
            Text("Sorry we could not find any results")
        }
        .task {
            await self.viewModel.getAstroData()
        }
    }
    
    func submit() {
        Task(priority: .high) {
            await self.viewModel.getAstroData()
        }
    }
}

struct AstroDetailView: View {
    let item: AstroItem
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ImageItemView(imageURL: item.images.first)
                    .cornerRadius(16.0)
                Spacer()
    
                Text(item.description)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.horizontal)
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    AstroListView()
}
