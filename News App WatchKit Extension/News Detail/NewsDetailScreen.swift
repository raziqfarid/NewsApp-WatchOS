//
//  NewsDetailView.swift
//  News App WatchKit Extension
//
//  Created by Mac HD on 09/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import SwiftUI
import Kingfisher
import UIKit
struct NewsDetailScreen: View {
    var news: News

    var body: some View {
        GeometryReader { geo in
        ScrollView{
            VStack(spacing: 15) {
                Text(self.news.name)
                .font(.headline)
                if self.news.image.thumbnail.imageURL != nil {
                    KFImage(self.news.image.thumbnail.imageURL)
                    .scaledToFit()
                    .frame(maxWidth: 100,  maxHeight: 100, alignment: .center)
                }
                Text(self.news.description)
                .font(.caption)
                .padding(.bottom, 15)
                Text(self.news.formattedDate ?? "")
                .font(.caption)
                .fontWeight(.ultraLight)
            }
        }
    }
    }
    
}

struct NewsDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailScreen(news: News(_type: "", name: "Test", url: "url", description: "des", datePublished: Date(), image: NewsImage(_type: "", isLicensed: false, thumbnail: Thumbnail(_type: "", contentUrl: "https://www.bing.com/th?id=ON.69D3D3350DAF10EB7CCB27F4464A03C4&pid=News", width: 100, height: 100))))
    }
}
