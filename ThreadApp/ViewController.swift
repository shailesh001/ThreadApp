//
//  ViewController.swift
//  ThreadApp
//
//  Created by Shailesh Patel on 05/05/2021.
// Example of Grand Central Dispatch (GCD) for Multi-Threading 

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var resultsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView.hidesWhenStopped = true
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
        // Single Threaded application with appropriate yield for other tasks
        let startTime = NSDate()
        self.resultsTextView.text = ""
        spinnerView.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let fetchedData = self.fetchSomethingFromServer()
            let processedData = self.processData(input: fetchedData)
            let firstResult = self.calculateFirstResult(processedData)
            let secondResult = self.calculateSecondResult(processedData)
            let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
            
            DispatchQueue.main.async {
                self.resultsTextView.text = resultsSummary
                self.spinnerView.stopAnimating()
            }
            
            let endTime = NSDate()
            print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
        }
    }
    
    @IBAction func doGroupButton(_ sender: UIButton) {
        // Multi-Threaded Application with appropriate yield for other tasks
        let startTime = Date()
        self.resultsTextView.text = ""
        spinnerView.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            let fetchData = self.fetchSomethingFromServer()
            let processedData = self.processData(input: fetchData)
            var firstResult: String!
            var secondResult: String!
            let group = DispatchGroup()
            
            queue.async(group: group) {
                firstResult = self.calculateFirstResult(processedData)
            }
            
            queue.async(group: group) {
                secondResult = self.calculateSecondResult(processedData)
            }
            
            group.notify(queue: queue) {
                let resultsSummary = "First: [\(firstResult!)]\nSecond: [\(secondResult!)]"
                DispatchQueue.main.async {
                    self.resultsTextView.text = resultsSummary
                    self.spinnerView.stopAnimating()
                }
                let endTime = Date()
                print("Completed in \(endTime.timeIntervalSince(startTime)) seconds")
            }
        }
    }
}

