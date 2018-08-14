//
//  AYIUtility.swift
//  KANO
//
//  Created by 陳駿逸 on 2018/8/11.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class AYIUtility {
    // MARK:- AYIUtility
    /*
     *範例：http://api.themoviedb.org/3/movie/328111?api_key=328c283cd27bd1877d9 080ccb1604c91
     */
    @objc class func queryTheMovie(movieId:String, block completionBlock: ((_ object: Movie, _ error: NSError?) -> Void)?) {
        // local DB 有完整檔案，就不用再call API，減少網路傳輸
        let realm = try! Realm()
        let movies = realm.objects(Movie.self).filter("id = \(movieId)")
        var movie = Movie()
        
        if movies.count > 0 {
            let oldMovie = movies.first
            if (oldMovie?.genres.isEmpty)! {
                // 雖然DB有該電影資料，但無 genres 資料情況，仍需要 call API 進行更新
                Alamofire.request("\(kAYIMovieV3Url)movie/\(movieId)?api_key=\(kAYIMovieV3Key)").responseJSON { (response) in
                    if response.result.isSuccess {
                        // convert data to dictionary array
                        let result:NSDictionary = response.value as! NSDictionary
                        print("success query the movie")
                        try! realm.write {
                            if (result[kAYIMoviesRuntimeKey]! as AnyObject).classForCoder! != NSNull().classForCoder {
                                oldMovie?.runtime = result[kAYIMoviesRuntimeKey]! as! Int
                            }
                            oldMovie?.status = result[kAYIMoviesStatusKey]! as! String
                            oldMovie?.tagline = result[kAYIMoviesTaglineKey]! as! String
                            if let homepage = result[kAYIMoviesHomepageKey] as? String { oldMovie?.homepage = homepage }
                            oldMovie?.vote_count = result[kAYIMoviesVoteCountKey]! as! Int
                            oldMovie?.vote_average = result[kAYIMoviesVoteAverageKey]! as! Double
                            if (result[kAYIMoviesIMDBIdKey]! as AnyObject).classForCoder! != NSNull().classForCoder {
                                oldMovie?.imdb_id = result[kAYIMoviesIMDBIdKey]! as! String
                            }
                            oldMovie?.budget = result[kAYIMoviesBudgetKey]! as! Int
                            if result[kAYIMoviesGenresKey] != nil {
                                for element in (result[kAYIMoviesGenresKey]! as? NSArray)! {
                                    let genre:Genre = Genre()
                                    genre.id = (element as! NSDictionary).object(forKey: "id")! as! Int
                                    genre.name = (element as! NSDictionary).object(forKey: "name")! as! String
                                    oldMovie?.genres.append(genre)
                                }
                            }
                            if result[kAYIMoviesGenreIdsKey] != nil {
                                for element in (result[kAYIMoviesGenreIdsKey]! as? NSArray)! {
                                    print("element = \(element)")
                                }
                            }
                            if result[kAYIMoviesSpokenLanguagesKey] != nil {
                                for element in (result[kAYIMoviesSpokenLanguagesKey]! as? NSArray)! {
                                    let language:SpokenLanguage = SpokenLanguage()
                                    language.iso_639_1 = (element as! NSDictionary).object(forKey: "iso_639_1")! as! String
                                    language.name = (element as! NSDictionary).object(forKey: "name")! as! String
                                    oldMovie?.spoken_languages.append(language)
                                }
                            }
                            movie = oldMovie!   // exist in db
                            completionBlock!(movie, nil)
                        }
                    } else {
                        print("error3: \(String(describing: response.error))")
                        completionBlock!(movie, response.error as NSError?)
                    }
                }
            } else {
                movie = oldMovie!   // exist in db
                completionBlock!(movie, nil)
            }
        }
    }
    
    /*
     *範例：http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877 d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=release_ date.desc&page=1
     */
    @objc class func queryMovies(date:Date, page:Int, block completionBlock: ((_ objects: [Movie], _ error: NSError?) -> Void)?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        Alamofire.request("\(kAYIMovieV3Url)discover/movie?api_key=\(kAYIMovieV3Key)&primary_release_date.lte=\(dateString)&sort_by=release_date.desc&page=\(page)").responseJSON { (response) in
            var movies:[Movie] = [Movie]()
            if response.result.isSuccess {
                // convert data to dictionary array
                let result:NSDictionary = response.value as! NSDictionary
                print("success query")
                if result["results"] != nil {
                    let realm = try! Realm()
                    try! realm.write {
                        for element in (result["results"] as! NSArray) {
                            let movie = Movie()
                            movie.id = (element as! NSDictionary)[kAYIMoviesVideoIdKey]! as! Int
                            movie.vote_count = (element as! NSDictionary)[kAYIMoviesVoteCountKey]! as! Int
                            movie.vote_average = (element as! NSDictionary)[kAYIMoviesVoteAverageKey]! as! Double
                            movie.original_title = (element as! NSDictionary)[kAYIMoviesOriginalTitleKey]! as! String
                            if ((element as! NSDictionary)[kAYIMoviesBackdropPathKey] as AnyObject).classForCoder! != NSNull().classForCoder {
                                movie.backdrop_path = (element as! NSDictionary)[kAYIMoviesBackdropPathKey]! as! String
                            }
                            movie.adult = (element as! NSDictionary)[kAYIMoviesAdultKey]! as! Int
                            if ((element as! NSDictionary)[kAYIMoviesPopularityKey] as AnyObject).classForCoder! != NSNull().classForCoder {
                                movie.popularity = (element as! NSDictionary)[kAYIMoviesPopularityKey]! as! Double
                            }
                            if ((element as! NSDictionary)[kAYIMoviesPosterPathKey] as AnyObject).classForCoder! != NSNull().classForCoder {
                                movie.poster_path = (element as! NSDictionary)[kAYIMoviesPosterPathKey]! as! String
                            }
                            movie.title = (element as! NSDictionary)[kAYIMoviesTitleKey]! as! String
                            movie.overview = (element as! NSDictionary)[kAYIMoviesOverviewKey]! as! String
                            movie.original_language = (element as! NSDictionary)[kAYIMoviesOriginalLanguageKey]! as! String
                            movie.vote_count = (element as! NSDictionary)[kAYIMoviesVoteCountKey]! as! Int
                            movie.release_date = (element as! NSDictionary)[kAYIMoviesReleaseDateKey]! as! String
                            movie.video = (element as! NSDictionary)[kAYIMoviesVideoKey]! as! Int
                            realm.add(movie)
                            movies.append(movie)
                        }
                    }
                    completionBlock!(movies, nil)
                } else {
                    print("error2: \(String(describing: response.error))")
                    completionBlock!(movies, response.error as NSError?)
                }
            } else {
                print("error1: \(String(describing: response.error))")
                completionBlock!(movies, response.error as NSError?)
            }
        }
    }
}
