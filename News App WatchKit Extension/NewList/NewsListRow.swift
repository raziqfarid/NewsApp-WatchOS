//
//  NewsListRow.swift
//  News App WatchKit Extension
//
//  Created by Mac HD on 09/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import SwiftUI
import Kingfisher
struct NewsListRow: View {
    var news: News
    var body: some View {
        HStack {
            if news.image.thumbnail.imageURL != nil {
                KFImage(news.image.thumbnail.imageURL)
                    .resizable()
                    .placeholder{
                        Image(systemName: "arrow.2.circlepath.cirle")
                            .font(.largeTitle)
                            .opacity(0.3)
                }
                .scaledToFit()
                .cornerRadius(4)
                .frame(width: 30, height: 30)
                .padding(.vertical)
            }
            Text(news.name)
                .font(.caption)
                .fontWeight(.ultraLight)
                .lineLimit(2)
        }
    }
}

struct NewsListRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsListRow(news: News(_type: "", name: "Test", url: "url", description: "des", datePublished: Date(), image: NewsImage(_type: "", isLicensed: false, thumbnail: Thumbnail(_type: "", contentUrl: "", width: 100, height: 100))))
    }
}

