//
//  ContentView.swift
//  News App WatchKit Extension
//
//  Created by Mac HD on 09/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sheetShowing = false
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack(alignment: .center) {
            Text("News")
                .font(.title)
                .fontWeight(.ultraLight)
            Text("Click on start to watch the news")
                .fontWeight(.ultraLight)
                .multilineTextAlignment(.center)
                .padding([.top])
            Spacer()
            NavigationLink(destination: NewsListScreen(), isActive: $sheetShowing){
                Text("Start")
            }
        }.onReceive(timer) { (time) in
            self.timer.upstream.connect().cancel()
            self.sheetShowing = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
