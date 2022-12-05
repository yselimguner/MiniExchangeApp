//
//  ViewController.swift
//  MiniExchangeApp
//
//  Created by Yavuz Güner on 3.12.2022.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
        
    var currency =  [String:Double]()
    var selected = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getRates()
    }

    
    func getRates(){
        let url = URL(string: "https://v6.exchangerate-api.com/v6/e4d3b8581bcc0baad0f751ae/latest/USD")
        
        let task = URLSession.shared.dataTask(with: url!) { result, response, error in
             if let result = result {
                     let currency = try? JSONDecoder().decode(Currency.self, from: result)
                 if let currencyList = currency?.conversionRates{
                     self.currency = currencyList
                     
                     }
                 DispatchQueue.main.async {
                     self.tableView.reloadData()
                 }
             }
           }
          task.resume()
    }
    

}

extension MainPageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyTableViewCell

        cell.currencyLabel.text = Array(currency.keys)[indexPath.row]
        cell.currencyPrice.text = String(Array(currency.values)[indexPath.row])
        //String(Array(paraBirimi.values)[indexPath.row])
            return cell
        
        
        //Burada listelemesini yapacağız key value olarak.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath.row
        performSegue(withIdentifier: "ExchangePageViewController", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ExchangePageViewController" {
            let destinationVC = segue.destination as! ExchangePageViewController
            destinationVC.currencyName = Array(currency.keys)[selected]
            destinationVC.currencyPrice = Array(currency.values)[selected]
            destinationVC.comingCurrencyRates = currency
        }
    }
}

