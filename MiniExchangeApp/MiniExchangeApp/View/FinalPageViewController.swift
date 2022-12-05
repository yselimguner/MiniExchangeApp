//
//  FinalPageViewController.swift
//  MiniExchangeApp
//
//  Created by Yavuz Güner on 3.12.2022.
//

import UIKit

class FinalPageViewController: UIViewController {

    var comingResult = String()
    var comingResultName = String()
    
    @IBOutlet weak var finalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        finalLabel.text = "\(comingResult) \(comingResultName)"

    }
    
    @IBAction func mainPageButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    


}
