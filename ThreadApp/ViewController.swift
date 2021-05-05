//
//  ViewController.swift
//  ThreadApp
//
//  Created by Shailesh Patel on 05/05/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 2)
        return "Hi there"
    }
    
    func processData(input data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        let message = "Number of chars: \(String(data).count)"
        return message
    }
    
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }

    @IBAction func doButton(_ sender: UIButton) {
        let startTime = NSDate()
        self.resultsTextView.text = ""
        let fetchedData = self.fetchSomethingFromServer()
        let processedData = self.processData(input: fetchedData)
        let firstResult = self.calculateFirstResult(processedData)
        let secondResult = self.calculateSecondResult(processedData)
        let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
        self.resultsTextView.text = resultsSummary
        let endTime = NSDate()
        print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
    }
}

