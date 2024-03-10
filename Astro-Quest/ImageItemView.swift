//
//  ImageItemView.swift
//  Astro-Quest
//
//  Created by Daniel Ayala on 10/3/24.
//

import SwiftUI

struct ImageItemView: View {
    let imageURL: String?
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL ?? "")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: height)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: height)
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    ImageItemView(imageURL: "", height: 150)
}
