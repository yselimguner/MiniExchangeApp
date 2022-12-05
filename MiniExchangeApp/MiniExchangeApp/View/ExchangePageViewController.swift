//
//  ExchangePageViewController.swift
//  MiniExchangeApp
//
//  Created by Yavuz Güner on 3.12.2022.
//

import UIKit

class ExchangePageViewController: UIViewController {
    

    @IBOutlet weak var comingExchangeRateLabel: UILabel!
    @IBOutlet weak var exchangeRateTextField: UITextField!
    
    //Diğer sayfadan gelen veriler
    var comingCurrencyRates =  [String:Double]()
    var currencyName = String()
    var currencyPrice = Double()
    
    //Bu sayfadan aldığımız veriler.
    var chosenMoneyName = String()
    var chosenMoneyValue = Double()
    
    var doubleStr = String()
    
    let picker = UIPickerView()
    
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var finalAmountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        comingExchangeRateLabel.text = "\(currencyName)" 
        
        exchangeRateTextField.inputView = picker
        picker.delegate = self
        picker.dataSource = self
        createToolbar()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FinalPageViewController" {
            let destinationVC = segue.destination as! FinalPageViewController
            destinationVC.comingResult = doubleStr
            destinationVC.comingResultName = chosenMoneyName
        }
    }


}

extension ExchangePageViewController : UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return comingCurrencyRates.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return Array(comingCurrencyRates.keys)[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            exchangeRateTextField.text = Array(comingCurrencyRates.keys)[row]
            chosenMoneyName = Array(comingCurrencyRates.keys)[row]
            chosenMoneyValue = (Array(comingCurrencyRates.values)[row])
        }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ExchangePageViewController.dismissPicker))
        toolBar.setItems([doneButton], animated: false)
        
        toolBar.isUserInteractionEnabled = true
        exchangeRateTextField.inputAccessoryView = toolBar
    }
    @objc func dismissPicker() {
        view.endEditing(true)
        
        
    }
    
    @IBAction func exchangeButtonClicked(_ sender: Any) {
        if valueTextField.text == ""{
            let alert = UIAlertController(title: "Incorrect Amount", message: "Please enter the amount you want to change.", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    self.present(alert, animated: true, completion: nil)
        }else{
            let writingValue = Double(valueTextField.text!)
            var finalValue = ((chosenMoneyValue * writingValue!) / currencyPrice)
            doubleStr = String(format: "%.2f", finalValue)
            finalAmountLabel.text = "\(doubleStr) \(chosenMoneyName)"
            let alert = UIAlertController(title: "\(currencyName) to \(chosenMoneyName) Exchange", message: "Are you about to get \(currencyName) for \(chosenMoneyName) ? Do you approve the transaction?", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
            alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                self.performSegue(withIdentifier: "FinalPageViewController", sender: true)
                
            
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive,handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
}
