//
//  ViewController.swift
//  ThreadApp
//
//  Created by Shailesh Patel on 05/05/2021.
//  Example of Grand Central Dispatch (GCD) for Multi-Threading

/*
 This ViewController demonstrates the use of Grand Central Dispatch (GCD) to perform
 multi-threading in an iOS application. It provides examples of both single-threaded
 and multi-threaded execution for simulating data fetching, processing, and calculations,
 showcasing how to update the UI appropriately on the main thread.
 */

import UIKit

/// ViewController demonstrates single-threaded and multi-threaded execution using Grand Central Dispatch (GCD).
/// It provides two actions: one for sequential execution and one for parallel execution of simulated tasks.
class ViewController: UIViewController {
    /// Spinner to indicate background activity (connected via storyboard)
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    /// Text view to display results (connected via storyboard)
    @IBOutlet weak var resultsTextView: UITextView!
    
    /// Initial UI setup: configure spinner to hide when stopped
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide spinner when not animating for better UX
        spinnerView.hidesWhenStopped = true
    }

    /// Simulates fetching data from a server with a 2-second delay.
    /// - Returns: A string representing fetched data.
    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 2)
        return "Hi there"
    }
    
    /// Simulates processing data with a 2-second delay.
    /// - Parameter data: The input string to process.
    /// - Returns: The processed string in uppercase.
    func processData(input data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    /// Simulates a calculation with a 3-second delay.
    /// - Parameter data: The input string to analyze.
    /// - Returns: A string describing the number of characters in the input.
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        let message = "Number of chars: \(String(data).count)"
        return message
    }
    
    /// Simulates another calculation with a 4-second delay.
    /// - Parameter data: The input string to process.
    /// - Returns: The input string with all 'E' replaced by 'e'.
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }
    
    /// Simulates a third calculation with a 5-second delay.
    /// - Parameter data: The input string to process.
    /// - Returns: A string indicating the third result was calculated.
    func calculateThirdResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 5)
        return "Third result for: \(data)"
    }

    /// Action for single-threaded execution.
    /// Runs all tasks sequentially on a background queue and updates the UI when done.
    /// - Parameter sender: The button triggering the action.
    @IBAction func doButton(_ sender: UIButton) {
        // Record start time for performance measurement
        let startTime = NSDate()
        // Clear previous results and start spinner
        self.resultsTextView.text = ""
        // Start animating spinner to show activity
        spinnerView.startAnimating()
        // Use a global background queue
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            // Fetch data from server (blocking 2 sec delay)
            let fetchedData = self.fetchSomethingFromServer()
            
            // Process fetched data (blocking 2 sec delay)
            let processedData = self.processData(input: fetchedData)
            
            // Calculate first result (blocking 3 sec delay)
            let firstResult = self.calculateFirstResult(processedData)
            
            // Calculate second result (blocking 4 sec delay)
            let secondResult = self.calculateSecondResult(processedData)
            let thirdResult = self.calculateThirdResult(processedData)
            let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]\nThird: [\(thirdResult)]"
            
            // Update UI on main thread after all work is done
            DispatchQueue.main.async {
                self.resultsTextView.text = resultsSummary
                self.spinnerView.stopAnimating()
            }
            
            // Print total time taken
            let endTime = NSDate()
            print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
        }
    }
    
    /// Action for multi-threaded execution.
    /// Runs two calculations in parallel after fetching and processing data, then updates the UI.
    /// - Parameter sender: The button triggering the action.
    @IBAction func doGroupButton(_ sender: UIButton) {
        // Record start time for performance measurement
        let startTime = Date()
        // Clear previous results and start spinner
        self.resultsTextView.text = ""
        // Start animating spinner to show activity
        spinnerView.startAnimating()
        // Use a global background queue
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            // Fetch data from server (blocking 2 sec delay)
            let fetchData = self.fetchSomethingFromServer()
            
            // Process fetched data (blocking 2 sec delay)
            let processedData = self.processData(input: fetchData)
            
            var firstResult: String!
            var secondResult: String!
            var thirdResult: String!
            let group = DispatchGroup()
            
            // Run all three calculations in parallel using DispatchGroup
            queue.async(group: group) {
                firstResult = self.calculateFirstResult(processedData)
            }
            
            // Run second calculation in parallel within DispatchGroup
            queue.async(group: group) {
                secondResult = self.calculateSecondResult(processedData)
            }
            
            queue.async(group: group) {
                thirdResult = self.calculateThirdResult(processedData)
            }
            
            // Notify when all calculations are done
            group.notify(queue: queue) {
                let resultsSummary = "First: [\(firstResult!)]\nSecond: [\(secondResult!)]\nThird: [\(thirdResult!)]"
                // Update UI on main thread
                DispatchQueue.main.async {
                    self.resultsTextView.text = resultsSummary
                    self.spinnerView.stopAnimating()
                }
                // Print total time taken
                let endTime = Date()
                print("Completed in \(endTime.timeIntervalSince(startTime)) seconds")
            }
        }
    }
}

