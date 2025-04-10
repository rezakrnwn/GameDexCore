//
//  SwiftUIView.swift
//  
//
//  Created by Reza Kurniawan on 09/04/25.
//

import SwiftUI
import Kingfisher

public struct GameItemView: View {
    let id: Int
    let name: String
    let backgroundImage: URL
    let releaseDate: String
    let rating: Double
    let destination: AnyView

    public init(
        id: Int,
        name: String,
        backgroundImage: URL,
        releaseDate: String,
        rating: Double,
        destination: AnyView
    ) {
        self.id = id
        self.name = name
        self.backgroundImage = backgroundImage
        self.releaseDate = releaseDate
        self.rating = rating
        self.destination = destination
    }

    public var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                KFImage(backgroundImage)
                    .resizable()
                    .placeholder { ProgressView() }
                    .frame(width: 100, height: 100)
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(8.0)

                VStack(alignment: .leading, spacing: 5) {
                    Text(name)
                        .fontWeight(.bold)
                    Text(releaseDate)
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.body)
                        Text(String(format: "%.2f", rating))
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    GameItemView(
        id: 1,
        name: "Name",
        backgroundImage: URL(string: "https://placehold.co/600x400.png")!,
        releaseDate: "22 April 2025",
        rating: 4,
        destination: AnyView(EmptyView())
    )
}

