//
//  MyFeedTableViewController.swift
//  KANO
//
//  Created by 陳駿逸 on 2018/8/13.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import UIKit
import LoadMoreTableViewController
import SDWebImage

class MyFeedTableViewController: LoadMoreTableViewController {
    
    public var initialPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        fetchSourceObjects = { [weak self] completion in
            var objects:[Movie]?
            AYIUtility.queryMovies(date: Date(), page: (self?.initialPage)!, block: { (movies, error) in
                objects = movies
                var refreshing:Bool = false
                DispatchQueue.main.async {
                    refreshing = self?.refreshControl?.isRefreshing == true
                    if refreshing { self?.refreshControl?.endRefreshing() }
                }
                self?.initialPage += 1
                completion(objects!, true)
            })
        }
        
        configureCell = { [weak self] cell, row in
            
            let aCell: SampleCell = self?.tableView.dequeueReusableCell(withIdentifier: "SampleCell") as! SampleCell
            aCell.title.text = (self?.sourceObjects[row] as! Movie).title
            aCell.time.text = (self?.sourceObjects[row] as! Movie).release_date
            aCell.overview.text = (self?.sourceObjects[row] as! Movie).overview
            aCell.popularity.text = "\(String((self?.sourceObjects[row] as! Movie).popularity))"
            if !((self?.sourceObjects[row] as! Movie).poster_path.isEmpty) {
                aCell.imgView.layer.cornerRadius = 8.0
                let imageUrl = URL(string: "\(kAYIMovieImageUrl)\((self?.sourceObjects[row] as! Movie).poster_path)")
                aCell.imgView?.sd_setShowActivityIndicatorView(true)
                aCell.imgView?.sd_setIndicatorStyle(.whiteLarge)
                aCell.imgView?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""), options: .cacheMemoryOnly, progress: nil, completed: nil)
            } else { aCell.imgView.image = UIImage(named: "imageNotAvailable") }
            
            if (self?.sourceObjects[row] as! Movie).backdrop_path != "" {
                let imageUrl = URL(string: "\(kAYIMovieImageUrl)\((self?.sourceObjects[row] as! Movie).backdrop_path)")
                aCell.backdrop?.sd_setShowActivityIndicatorView(true)
                aCell.backdrop?.sd_setIndicatorStyle(.white)
                aCell.backdrop?.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: ""), options: .cacheMemoryOnly, progress: nil, completed: nil)
            }
            return aCell
        }
        
        didSelectRow = { [weak self] row in
            let movie = self?.sourceObjects[row]
            self?.performSegue(withIdentifier: "detail", sender: movie)
        }
    }
    
    fileprivate func setupUI() {
        navigationItem.title = NSLocalizedString("CINEMA", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Clear", comment: ""), style: .plain, target: self, action: #selector(clear))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Refresh", comment: ""), style: .plain, target: self, action: #selector(refresh))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func clear() {
        initialPage = 1
        refreshData(immediately: true)
    }
    
    @objc func refresh() {
        initialPage = 1
        refreshData(immediately: false)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let view:MyDetailTableViewController = segue.destination as! MyDetailTableViewController
        view.movie = sender as? Movie
    }
}
