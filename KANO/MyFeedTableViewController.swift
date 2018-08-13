//
//  MyFeedTableViewController.swift
//  KANO
//
//  Created by 陳駿逸 on 2018/8/13.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import UIKit
import LoadMoreTableViewController

func delay(_ delay: TimeInterval, block: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        block()
    }
}

class MyFeedTableViewController: LoadMoreTableViewController {
    
    private var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clear))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refresh))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        fetchSourceObjects = { [weak self] completion in
            var objects:[Movie]?
            AYIUtility.queryMovies(date: Date(), page: (self?.page)!, block: { (movies, error) in
                objects = movies
                var refreshing:Bool = false
                DispatchQueue.main.async {
                    refreshing = self?.refreshControl?.isRefreshing == true
                    if refreshing {
                        self?.refreshControl?.endRefreshing()
                    }
                }
                delay(refreshing ? 0 : 0) {
                    self?.page += 1
                    completion(objects!, true)
                }
            })
        }
        configureCell = { [weak self] cell, row in
            
            let aCell: SampleCell = self?.tableView.dequeueReusableCell(withIdentifier: "SampleCell") as! SampleCell
            aCell.title.text = (self?.sourceObjects[row] as! Movie).title
            aCell.time.text = (self?.sourceObjects[row] as! Movie).release_date
            aCell.overview.text = (self?.sourceObjects[row] as! Movie).overview
            aCell.voteAverage.text = String((self?.sourceObjects[row] as! Movie).vote_count)
            aCell.voteCount.text = "\(String((self?.sourceObjects[row] as! Movie).vote_average)) Reviews"
            return aCell
        }
        didSelectRow = { [weak self] row in
            print("did select \(String(describing: self?.sourceObjects[row]))")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func clear() {
        page = 0
        refreshData(immediately: true)
    }
    
    @objc func refresh() {
        page = 0
        refreshData(immediately: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
