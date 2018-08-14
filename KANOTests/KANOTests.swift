//
//  KANOTests.swift
//  KANOTests
//
//  Created by 陳駿逸 on 2018/8/11.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import XCTest
@testable import KANO
import Alamofire
import RealmSwift

class KANOTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testQueryMovies() {
        AYIUtility.queryMovies(date: Date(), page: 1) { (movies, error) in
            let result = movies
            XCTAssert(result.count == 20)
        }
    }
    
    func testQueryTheMovie() {
        AYIUtility.queryTheMovie(movieId: "328111") { (movie, error) in
            XCTAssert(movie.id == Int("328111"))
        }
    }
}
