//
//  News.swift
//  News App WatchKit Extension
//
//  Created by Mac HD on 09/08/20.
//  Copyright © 2020 Mac HD. All rights reserved.
//

import Foundation

struct NewsResponse: Codable {
    var _type: String
    var webSearchUrl: String
    var value: [News]
}

struct News: Codable, Hashable {
    var _type: String
    var name: String
    var url: String
    var description: String
    var datePublished: Date
    var image: NewsImage
    
    
    var formattedDate: String? {
        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = true
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: datePublished)
    }
    
}

struct NewsImage: Codable, Hashable {
    var _type: String
    var isLicensed: Bool
    var thumbnail: Thumbnail
}

struct Thumbnail: Codable, Hashable {
    var _type: String
    var contentUrl: String
    var width: Int
    var height: Int
    
    var imageURL: URL? {
        guard let url = URL(string: contentUrl) else { return nil}
        return url
    }
}

class NewsFetcher: ObservableObject {
    @Published var news = [News]()
    @Published var errorMessage = ""
    
    func fetchNews() {
        errorMessage = ""
        let headers = [
            "x-rapidapi-host": "bing-news-search1.p.rapidapi.com",
            "x-rapidapi-key": "Hv1TUESzicmshJiihj4bLXIgmto4p15bAkojsnSYURrvBzyQG8",
            "x-bingapis-sdk": "true"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://bing-news-search1.p.rapidapi.com/news?safeSearch=Off&textFormat=Raw")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            DispatchQueue.main.async {
                if (error != nil) {
                    self.errorMessage = error?.localizedDescription ?? "Unable to fetch data"
                    return
                } else {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(.iso8601Full)
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200{
                        if let data = data, let decodedNewsResponse = try? decoder.decode(NewsResponse.self, from: data) {
                            print(decodedNewsResponse.value)
                            self.news = decodedNewsResponse.value
                        } else {
                            self.errorMessage = "Unable to decode object"
                        }
                    } else {
                        self.errorMessage = "Unable to fetch data"
                    }
                }
            }
        })
        
        dataTask.resume()
    }
}
extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
