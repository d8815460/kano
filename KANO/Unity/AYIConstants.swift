//
//  AYIConstants.swift
//  KANO
//
//  Created by 陳駿逸 on 2018/8/11.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import UIKit
import RealmSwift

// for TMDb
let kAYIMovieV3Key = "8e08f125c9980610217afbf7de9d6a23"
let kAYIMovieV4Key = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZTA4ZjEyNWM5OTgwNjEwMjE3YWZiZjdkZTlkNmEyMyIsInN1YiI6IjViNmU1ZGM4OTI1MTQxNDA0ZjEyYWI4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.e0sTxHmLpbZBbYf3zsEIjusrd56GIxY8YadBgzkQB_4"
let kAYIMovieV3Url = "https://api.themoviedb.org/3/"


// MARK: - Videos Object
class Movie: Object {
    @objc dynamic var id                    = 0
    @objc dynamic var video                 = 0
    @objc dynamic var vote_average          = 0
    @objc dynamic var title                 = ""
    @objc dynamic var popularity            = 0.0
    @objc dynamic var poster_path           = ""
    @objc dynamic var original_language     = "en"
    @objc dynamic var original_title        = ""
    @objc dynamic var backdrop_path         = "<null>"
    @objc dynamic var adult                 = 0
    @objc dynamic var overview              = ""
    @objc dynamic var release_date          = ""
    @objc dynamic var imdb_id               = ""
    @objc dynamic var budget                = 0
    @objc dynamic var genres                = ""
    @objc dynamic var homepage              = ""
    @objc dynamic var status                = ""
    @objc dynamic var tagline               = ""
    @objc dynamic var vote_count            = 0
    @objc dynamic var revenue               = 0
    @objc dynamic var runtime               = 0
//    @objc dynamic var genre_ids             = genreIds
//    @objc dynamic var belongs_to_collection = belongsToCollection
//    @objc dynamic var production_companies  = ""
//    @objc dynamic var production_countries  = ""
//    @objc dynamic var spoken_languages      = ""
}



// MARK: - Videos Class
// Class key
let kAYIMoviesClassKey                  = "Movies"
// Field keys
let kAYIMoviesVideoIdKey                = "id"
let kAYIMoviesVideoKey                  = "video"
let kAYIMoviesVoteAverageKey            = "vote_average"
let kAYIMoviesTitleKey                  = "title"
let kAYIMoviesPopularityKey             = "popularity"
let kAYIMoviesPosterPathKey             = "poster_path"
let kAYIMoviesOriginalLanguageKey       = "original_language"
let kAYIMoviesOriginalTitleKey          = "original_title"
let kAYIMoviesGenreIdsKey               = "genre_ids"
let kAYIMoviesBackdropPathKey           = "backdrop_path"
let kAYIMoviesAdultKey                  = "adult"
let kAYIMoviesOverviewKey               = "overview"
let kAYIMoviesReleaseDateKey            = "release_date"
let kAYIMoviesIMDBIdKey                 = "imdb_id"
let kAYIMoviesBelongsToCollectionKey    = "belongs_to_collection"
let kAYIMoviesBudgetKey                 = "budget"
let kAYIMoviesGenresKey                 = "genres"
let kAYIMoviesHomepageKey               = "homepage"
let kAYIMoviesProductionCompaniesKey    = "production_companies"
let kAYIMoviesProductionCountriesKey    = "production_countries"
let kAYIMoviesSpokenLanguagesKey        = "spoken_languages"
let kAYIMoviesStatusKey                 = "status"
let kAYIMoviesTaglineKey                = "tagline"
let kAYIMoviesVoteCountKey              = "vote_count"
let kAYIMoviesRevenueKey                = "revenue"
let kAYIMoviesRuntimeKey                = "runtime"

