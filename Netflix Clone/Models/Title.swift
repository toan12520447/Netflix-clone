//
//  Movie.swift
//  Netflix Clone
//
//  Created by Toan Tran on 10/5/23.
//

import Foundation

struct TrendingTitleResponse: Codable{
    let results: [Title]
}

struct Title: Codable{
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

/*
 
 {
 "adult": false,
 "backdrop_path": "/mRGmNnh6pBAGGp6fMBMwI8iTBUO.jpg",
 "id": 968051,
 "title": "The Nun II",
 "original_language": "en",
 "original_title": "The Nun II",
 "overview": "In 1956 France, a priest is violently murdered, and Sister Irene begins to investigate. She once again comes face-to-face with a powerful evil.",
 "poster_path": "/5gzzkR7y3hnY8AD1wXjCnVlHba5.jpg",
 "media_type": "movie",
 "genre_ids": [
 27,
 9648,
 53
 ],
 "popularity": 2614.527,
 "release_date": "2023-09-06",
 "video": false,
 "vote_average": 6.921,
 "vote_count": 513
 },
 */
