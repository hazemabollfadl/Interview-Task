//
//  ViewController.swift
//  InterviewTask
//
//  Created by Hazem Abou El Fadl on 27/03/2024.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let realm=try! Realm()
    var dateArray:Results<DateModel>?
    var currentDate:String=""
    var currentDataModel:DataModel?
    var dateExist:Bool=false
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var number1: UITextField!
    @IBOutlet var number2: UITextField!
    @IBOutlet var number3: UITextField!
    @IBOutlet var number4: UITextField!
    @IBOutlet var title1: UITextField!
    @IBOutlet var title2: UITextField!
    @IBOutlet var title3: UITextField!
    @IBOutlet var title4: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd" // this is "2021-10-29"
        currentDate=dateFormatter.string(from: datePicker.date)
        
        title1.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        title2.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        title3.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        title4.attributedPlaceholder = NSAttributedString(
            string: "Title",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        number1.attributedPlaceholder = NSAttributedString(
            string: "Value",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        number2.attributedPlaceholder = NSAttributedString(
            string: "Value",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        number3.attributedPlaceholder = NSAttributedString(
            string: "Value",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        number4.attributedPlaceholder = NSAttributedString(
            string: "Value",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
    
        load()
    }
    
    @IBAction func doSomething(sender: UIDatePicker, forEvent event: UIEvent){
        
        presentedViewController?.dismiss(animated: true, completion: nil)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "yyyy-MM-dd" // this is "2021-10-29"
        currentDate=dateFormatter.string(from: sender.date)
        dateExist=false
        load()
        
    }
    
    @IBAction func ButtonPressed(_ sender: UIButton) {
        var total=0
        let titleArray=[title1.text!,title2.text!,title3.text!,title4.text!]
        let numbersArray=[number1.text!,number2.text!,number3.text!,number4.text!]
        
            if (dateExist){
                try! realm.write {
                    currentDataModel?.names.replaceSubrange(0...3, with: titleArray)
                    currentDataModel?.numbers.replaceSubrange(0...3, with: numbersArray)
                    for num in numbersArray{
                        total+=Int(num) ?? 0
                    }
                    totalLabel.text=String(total) + " EGP"
                    currentDataModel!.total=total
                }
            }else{
                let newDate=DateModel()
                newDate.date=currentDate
                
                let newData=DataModel()
                
                newData.names.append(objectsIn: titleArray)
                newData.numbers.append(objectsIn: numbersArray)
                
                for num in numbersArray{
                    total+=Int(num) ?? 0
                }
                
                totalLabel.text=String(total) + " EGP"
                newData.total=total
                
                newDate.data=newData
                dateExist=true
                saveDate(the: newDate)
            }
    }
    
    
    //MARK: - Data Manipulation Methods
    func saveDate(the date:DateModel){
        do{
            try realm.write {
                realm.add(date)
            }
        }catch{
            print("Error saving the data\(error)")
        }
    }
    
    
    func load(){
        //        //Fetches Data as a Result Container containing bunch of category objects
        dateArray = realm.objects(DateModel.self)
        
        var dateModelArray:[DateModel]=[]
        
        for dateModel in dateArray!{
            dateModelArray.append(dateModel)
        }
        
        //check for value in the array of date model
        for dateModel in dateModelArray{
            if dateModel.date == currentDate{
                
                currentDataModel=dateModel.data
                
                dateExist=true
                
                if let currentDataModel=dateModel.data{
                    
                    totalLabel.text=String(currentDataModel.total) + " EGP"
                    title1.text=currentDataModel.names[0]
                    title2.text=currentDataModel.names[1]
                    title3.text=currentDataModel.names[2]
                    title4.text=currentDataModel.names[3]
                    
                    number1.text=currentDataModel.numbers[0]
                    number2.text=currentDataModel.numbers[1]
                    number3.text=currentDataModel.numbers[2]
                    number4.text=currentDataModel.numbers[3]
                    break
                }
                
            }else{
                resetUI()
            }
        }
    }
    
    func resetUI(){
        totalLabel.text="0"
        number1.text=""
        number2.text=""
        number3.text=""
        number4.text=""
        title1.text=""
        title2.text=""
        title3.text=""
        title4.text=""
    }
    
}

