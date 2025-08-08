//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by Toan Tran on 05/10/2023.
//

import Foundation
struct YoutubeSearchResults: Codable{
    let items:[VideoElement]
}

struct VideoElement: Codable{
    let etag: String
    let id: IDVideoElement
    let kind: String
}

struct IDVideoElement: Codable{
    let kind: String
    let videoId: String
}
struct DS: Codeable{
    let id: String 
    let data: String
}


/**items =     (
 {
etag = wlO8powFOMyqeebgN6JTt1sJ6qg;
id =             {
 kind = "youtube#video";
 videoId = H1lUvYGMcoY;
};
kind = "youtube#searchResult";
},*/
