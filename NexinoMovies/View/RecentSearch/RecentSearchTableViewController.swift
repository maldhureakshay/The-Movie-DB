//
//  RecentSearchTableViewController.swift
//  NexinoMovies
//
//  Created by Akshay Maldhure on 12/18/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import UIKit

protocol RecentSearchControllerDelegate{
    func didSelectSearch(searchName : String)
}

class RecentSearchTableViewController: UITableViewController {

    var searchs  = [String]()
    var delegate : RecentSearchControllerDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         initialize()
    }
    
    func initialize() {
       searchs = searchStore().searchNames
       self.tableView.reloadData()
    }

   
    func searchStore() -> RecentSearchStore {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appStore.searchStore
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent Search's"
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchs.count <= 0{
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: self.view.frame.size.height))
            messageLabel.text = "No recent searchs to display"
            messageLabel.textColor = UIColor.darkGray
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font.withSize(15)
            messageLabel.sizeToFit()
            self.tableView.backgroundView = messageLabel
            self.tableView.separatorStyle = .none;
        }else{
            self.tableView.backgroundView = nil
        }
        return searchs.count > 10 ? 10 : searchs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = searchs[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectSearch(searchName: searchs[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
