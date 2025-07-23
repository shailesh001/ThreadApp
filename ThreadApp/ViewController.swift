//
//  ViewController.swift
//  ThreadApp
//
//  Created by Shailesh Patel on 05/05/2021.
//  Example of Grand Central Dispatch (GCD) for Multi-Threading 

import UIKit

class ViewController: UIViewController {
    // Spinner to indicate background activity
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    // Text view to display results
    @IBOutlet weak var resultsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide spinner when not animating
        spinnerView.hidesWhenStopped = true
    }

    // Simulate fetching data from a server (2 seconds delay)
    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 2)
        return "Hi there"
    }
    
    // Simulate processing data (2 seconds delay)
    func processData(input data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    // Simulate a calculation (3 seconds delay)
    // Returns a string with the number of characters in the data
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        let message = "Number of chars: \(String(data).count)"
        return message
    }
    
    // Simulate another calculation (4 seconds delay)
    // Returns the data with all 'E' replaced by 'e'
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }

    // Action for single-threaded execution
    // Runs all tasks sequentially on a background queue
    @IBAction func doButton(_ sender: UIButton) {
        // Single Threaded application with appropriate yield for other tasks
        let startTime = NSDate()
        self.resultsTextView.text = ""
        spinnerView.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            // Fetch, process, and calculate results sequentially
            let fetchedData = self.fetchSomethingFromServer()
            let processedData = self.processData(input: fetchedData)
            let firstResult = self.calculateFirstResult(processedData)
            let secondResult = self.calculateSecondResult(processedData)
            let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
            
            // Update UI on main thread
            DispatchQueue.main.async {
                self.resultsTextView.text = resultsSummary
                self.spinnerView.stopAnimating()
            }
            
            let endTime = NSDate()
            print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
        }
    }
    
    // Action for multi-threaded execution
    // Runs two calculations in parallel after fetching and processing
    @IBAction func doGroupButton(_ sender: UIButton) {
        // Multi-Threaded Application with appropriate yield for other tasks
        let startTime = Date()
        self.resultsTextView.text = ""
        spinnerView.startAnimating()
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            // Fetch and process data sequentially
            let fetchData = self.fetchSomethingFromServer()
            let processedData = self.processData(input: fetchData)
            var firstResult: String!
            var secondResult: String!
            let group = DispatchGroup()
            
            // Run both calculations in parallel using DispatchGroup
            queue.async(group: group) {
                firstResult = self.calculateFirstResult(processedData)
            }
            
            queue.async(group: group) {
                secondResult = self.calculateSecondResult(processedData)
            }
            
            // Notify when both calculations are done
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
