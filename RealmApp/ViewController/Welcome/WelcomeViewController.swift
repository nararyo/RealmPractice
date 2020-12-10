//
//  WelcomeViewController.swift
//  RealmApp
//
//  Created by NR on 2020/11/11.
//  Copyright © 2020 nararyo. All rights reserved.
//

import UIKit
import RealmSwift

class WelcomeViewController: UIViewController {

    var sections: Results<Section>?
    let realm = try! Realm()
    @IBOutlet weak var ListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        title = "Hello"
        loadData()
        ListTableView.delegate = self
        ListTableView.dataSource = self
       
        
      
//        ListTableView.reloadData()
//
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        loadData()
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        let vc = NewViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

extension WelcomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections?[section].tasks.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = sections?[indexPath.section].tasks[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections?[section].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
}

extension  WelcomeViewController: UITableViewDelegate {
    
}

extension WelcomeViewController {
    
    func loadData(){
        sections = realm.objects(Section.self)
        ListTableView.reloadData()
    }
    //ファイルを一回全部消したい時に使用
    func deleteRealmfile(){
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]
        for URL in realmURLs {
            do {
                try FileManager.default.removeItem(at: URL)
            } catch {
                // handle error
            }
        }
    }

}
