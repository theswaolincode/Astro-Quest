//
//  ImageItemView.swift
//  Astro-Quest
//
//  Created by Daniel Ayala on 10/3/24.
//

import SwiftUI

struct ImageItemView: View {
    let imageURL: String?
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL ?? "")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                       .scaledToFit()
                       .containerRelativeFrame(.horizontal) { size, axis in
                           size * 0.8
                       }
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .empty:
                ProgressView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    ImageItemView(imageURL: "https://images-assets.nasa.gov/image/PIA14208/PIA14208~thumb.jpg")
}
