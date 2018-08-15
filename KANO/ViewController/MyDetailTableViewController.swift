//
//  MyDetailTableViewController.swift
//  KANO
//
//  Created by 陳駿逸 on 2018/8/14.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import UIKit
import SDWebImage

class MyDetailTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var headerView: UIImageView!
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = movie?.title
        
        AYIUtility.queryTheMovie(movieId: "\(String(describing: movie!.id))") { (movie, error) in
            self.movie = movie
            self.table.reloadData()
        }
        
        if (self.movie?.poster_path.isEmpty)! { headerView.image = UIImage(named: "no-image-icon-15") }
        else {
            headerView.sd_setImage(with: URL(string: "\(kAYIMovieImageUrl)\((self.movie?.poster_path)!)")) { (image, error, type, url) in }
        }
        self.table.tableHeaderView = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return kAYIMovieDetailContentCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        // Configure the cell...
        switch indexPath.row {
        case DETAIL.TITLE.hashValue:
            cell.title.text = "Title"
            cell.detail.text = self.movie?.title
        case DETAIL.RELEASEDATE.hashValue:
            cell.title.text = "Date"
            cell.detail.text = self.movie?.release_date
        case DETAIL.DURATION.hashValue:
            cell.title?.text = "Duration"
            cell.detail?.text = "\(String(self.movie?.runtime ?? 0)) mins"
        case DETAIL.GENRES.hashValue:
            cell.title?.text = "Genres"
            let genresString:NSMutableString = NSMutableString(string: "")
            if (self.movie?.genres.count)! < 1 {
                cell.detail?.text = "no genre information"
            } else {
                for genre in (self.movie?.genres)! {
                    genresString.append("\(genre.name), ")
                }
                cell.detail?.text = genresString as String
            }
        case DETAIL.SYNOPSIS.hashValue:
            cell.title?.text = "Synopsis"
            if (self.movie?.overview.isEmpty)! {
                cell.detail.text = "no synopsis information"
            } else {
                cell.detail?.text = self.movie?.overview
            }
        case DETAIL.HOMEPAGE.hashValue:
            cell.title?.text = "Home"
            if (self.movie?.homepage.isEmpty)! {
                cell.detail?.text = "no homepage information"
            } else {
                cell.detail?.text = self.movie?.homepage
            }
        case DETAIL.ORIGINALLANGUAGE.hashValue:
            cell.title.text = "Original"
            cell.detail?.text = self.movie?.original_language
        case DETAIL.SPOKENLANGUAGE.hashValue:
            cell.title.text = "Spoken"
            let spokenLanguages:NSMutableString = NSMutableString(string: "")
            if (self.movie?.genres.count)! < 1 {
                cell.detail.text = "no spoken language information"
            } else {
                for language in (self.movie?.spoken_languages)! {
                    spokenLanguages.append("\(language.name), ")
                }
                cell.detail?.text = spokenLanguages as String
            }
            
        case DETAIL.POPULARITY.hashValue:
            cell.title.text = "Popular"
            cell.detail?.text = "\(String(self.movie?.popularity ?? 0))"
        default: break
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.addSubview(self.headerView)
        if section == 0 {
            return view
        } else {
            return nil
        }
    }
}
