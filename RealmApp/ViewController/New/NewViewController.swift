//
//  NewViewController.swift
//  RealmApp
//
//  Created by NR on 2020/12/03.
//  Copyright © 2020 nararyo. All rights reserved.
//

import UIKit
import RealmSwift

class NewViewController: UIViewController {

    
    @IBOutlet weak var taskNameField: UITextField!
    @IBOutlet weak var taskSectionField: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    var pickerList: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        let realm = try! Realm()
        let results = realm.objects(Section.self)
        for result in results {
            pickerList.append(result)
        }
        setupPickerView()
        
    }


    @IBAction func addMovieButton(_ sender: Any) {
        
//        let movie = Movie(value: ["id": 1,
//                                  "name": nameTextField.text ?? "不明",
//                                  "watchDate": [["date": dateTextField.text,"name": nameTextField.text]]])
//
       // let task = Task(value: ["name": taskNameField.text ?? "不明"])
        print(#function)
        let realm = try! Realm()
        let section = realm.objects(Section.self).filter("name = '\(taskSectionField.text ?? "")'").first
            let task = Task(value: ["name": taskNameField.text ?? "aaaa", "section": section])
            do {
                try realm.write{
                    realm.add(task)
                }
            }catch {
                print("エラー")
            }
        dismiss(animated: true)
            
        
//        let realm = try! Realm()
//        do {
//            try realm.write{
//                realm.add(movie)
//
//            }
//        }catch {
//            print("writing error")
//        }
//        dismiss(animated: true)
    }
    

}

extension NewViewController {
    
    @objc func done(){
        taskSectionField.text = "\(pickerList[pickerView.selectedRow(inComponent: 0)].name)"
        taskSectionField.endEditing(true)
    }
    
    @objc func add(){
        let section = Section(value: ["name": "aa"])
        pickerList.append(section)
        taskSectionField.endEditing(true)
        print(pickerList)
    }
    
    func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        let item1 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        // Flexible Space Bar Button Item
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        // 右のBar Button Item
        let item2 = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(add))
        toolbar.setItems([item1, flexibleItem, item2], animated: true)
        
        taskSectionField.inputView = pickerView
        taskSectionField.inputAccessoryView = toolbar
    }
}

extension NewViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row].name
    }
}

extension NewViewController: UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
