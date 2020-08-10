//
//  NewsListView.swift
//  News App WatchKit Extension
//
//  Created by Mac HD on 09/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import SwiftUI
import Kingfisher

struct NewsListScreen: View {
    @ObservedObject var newsFetcher = NewsFetcher()
    var body: some View {
        VStack {
            if !self.newsFetcher.errorMessage.isEmpty {
                
                Text(newsFetcher.errorMessage)
                    .fontWeight(.ultraLight)
                    .lineLimit(3)
                Button("Reload") {
                    self.newsFetcher.fetchNews()
                }
            } else {
                List(newsFetcher.news, id: \.self){ news in
                    NavigationLink(destination: NewsDetailScreen(news: news)) {
                        NewsListRow(news: news)
                    }
                }
            }
        }
        .navigationBarTitle("News")
        .onAppear(perform: newsFetcher.fetchNews)
        
    }
}

struct NewsListScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListScreen()
    }
}
