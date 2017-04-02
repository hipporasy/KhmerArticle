//
//  HomeTableViewController.swift
//  Khmer-Social News
//
//  Created by ភី ម៉ារ៉ាសុី on 7/29/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Firebase

class HomeTableViewController: UITableViewController,UISearchBarDelegate, UISearchResultsUpdating{
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    let reuseId = "homeCell"
    var ref = FIRDatabaseReference()
    var index = 0;
    var uid = String()
    let dataItem = NSMutableArray()
    let newsId = NSMutableArray()
    let search = UISearchBar()

    let backgroundImage = UIImage(named: "newBackground")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.cyan
        self.definesPresentationContext = true
        search.frame = CGRect(x: 5 ,y: 5, width: 300,height: 45);
        search.delegate = self;
        search.showsBookmarkButton = false;
        search.placeholder = "Search for Article";
        search.barTintColor = UIColor.lightGray;
        self.navigationItem.titleView = search;
        
        ref = FIRDatabase.database().reference()
        
        
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
       self.search.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.search.resignFirstResponder()
        self.search.showsCancelButton = false
        search.isHidden = true
        self.navigationItem.rightBarButtonItem = self.btnAdd
         
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
    }
    override func viewWillAppear(_ animated: Bool) {
    
        if(dataItem.count > 0){
        dataItem.removeAllObjects()
        }
        ref.child("News").observe(.childAdded) { (snapshot:FIRDataSnapshot) in

            let snapshotValue = snapshot.value as? NSDictionary
            
            if let string = snapshotValue?["Name"] as? String{
            self.newsId.add(snapshot.key)
            self.dataItem.add(string)
            self.tableView.reloadData()
            }

            
            
        }
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        

        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.7
        blurView.frame = imageView.bounds
        imageView.contentMode = .scaleAspectFill
        imageView.addSubview(blurView)
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }
    
    
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor.clear
        cell!.backgroundColor = UIColor(white: 1, alpha: 0.1)

        

    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItem.count;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = (indexPath as NSIndexPath).row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.backgroundColor = UIColor(red: 255.0/255.0, green: 50.0/255.0, blue: 120/255.0, alpha: 10.0)
        
       self.performSegue(withIdentifier: "newsSegue", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId,for: indexPath) as! HomeTableViewCell
        cell.backgroundColor = UIColor.clear
        //cell.layer.cornerRadius = cell.frame.size.height / 2
        cell.subLabel.backgroundColor = UIColor.clear
        cell.myLabel.backgroundColor = UIColor.clear
        cell.myLabel.text = dataItem[(indexPath as NSIndexPath).row] as? String
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "newsSegue"){
            
            let destination = segue.destination as! NewsViewController
            destination.newsId = newsId[index] as! NSString
            
        }
    }
    
    
    
}
