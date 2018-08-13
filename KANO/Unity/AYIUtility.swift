//
//  AYIUtility.swift
//  KANO
//
//  Created by 陳駿逸 on 2018/8/11.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import UIKit
import Alamofire

class AYIUtility {
    // MARK:- AYIUtility
    // 範例：http://api.themoviedb.org/3/movie/328111?api_key=328c283cd27bd1877d9 080ccb1604c91
    @objc class func queryTheMovie(movieId:String) {
        Alamofire.request("\(kAYIMovieV3Url)movie/\(movieId)?api_key=\(kAYIMovieV3Key)").responseJSON { (response) in
            if response.result.isSuccess {
                // convert data to dictionary array
                let result:NSDictionary = response.value as! NSDictionary
                print("success: result:\n\(result)")
            } else {
                print("error: \(String(describing: response.error))")
            }
        }
    }
    
    // 範例：http://api.themoviedb.org/3/discover/movie?api_key=328c283cd27bd1877 d9080ccb1604c91&primary_release_date.lte=2016-12-31&sort_by=release_ date.desc&page=1
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
                for element in (result["results"] as! NSArray) {
                    let movie = Movie()
                    movie.id = (element as! NSDictionary)[kAYIMoviesVideoIdKey]! as! Int
                    movie.vote_count = (element as! NSDictionary)[kAYIMoviesVoteCountKey]! as! Int
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
                    
                    movies.append(movie)
                }
                completionBlock!(movies, nil)
            } else {
                print("error: \(String(describing: response.error))")
                completionBlock!(movies, response.error as NSError?)
            }
        }
    }
}
