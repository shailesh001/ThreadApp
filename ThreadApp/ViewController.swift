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

class ViewController: UIViewController {
    /// Spinner to indicate background activity to the user
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    /// Text view to display the results of operations
    @IBOutlet weak var resultsTextView: UITextView!
    
    /// Initial UI setup: configure spinner to hide when stopped
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide spinner when it is not animating
        spinnerView.hidesWhenStopped = true
    }

    /// Simulates fetching data from a server with a delay
    ///
    /// - Returns: A greeting string after a 2 second delay
    /// - Note: Uses Thread.sleep to simulate network latency
    func fetchSomethingFromServer() -> String {
        Thread.sleep(forTimeInterval: 2)
        return "Hi there"
    }
    
    /// Simulates processing of input data with a delay
    ///
    /// - Parameter data: Input string data to process
    /// - Returns: The input string converted to uppercase after a 2 second delay
    /// - Note: Uses Thread.sleep to simulate processing time
    func processData(input data: String) -> String {
        Thread.sleep(forTimeInterval: 2)
        return data.uppercased()
    }
    
    /// Simulates a calculation that counts characters in data with a delay
    ///
    /// - Parameter data: Processed string data
    /// - Returns: A string indicating the number of characters after a 3 second delay
    /// - Note: Uses Thread.sleep to simulate a time-consuming calculation
    func calculateFirstResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 3)
        let message = "Number of chars: \(String(data).count)"
        return message
    }
    
    /// Simulates a calculation that replaces characters in data with a delay
    ///
    /// - Parameter data: Processed string data
    /// - Returns: The string with all 'E' characters replaced by 'e' after a 4 second delay
    /// - Note: Uses Thread.sleep to simulate a longer calculation
    func calculateSecondResult(_ data: String) -> String {
        Thread.sleep(forTimeInterval: 4)
        return data.replacingOccurrences(of: "E", with: "e")
    }

    /// Action triggered by the "Do" button demonstrating single-threaded execution.
    ///
    /// This method runs all tasks sequentially on a background queue:
    /// 1. Start spinner and clear results.
    /// 2. Fetch data from server.
    /// 3. Process data.
    /// 4. Perform first calculation.
    /// 5. Perform second calculation.
    /// 6. Update results text view and stop spinner on main thread.
    ///
    /// - Parameter sender: The UIButton triggering this action
    @IBAction func doButton(_ sender: UIButton) {
        // Single Threaded application with appropriate yield for other tasks
        let startTime = NSDate()
        
        // Clear results text view before starting work
        self.resultsTextView.text = ""
        // Start animating spinner to show activity
        spinnerView.startAnimating()
        
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
            
            // Create summary string for display
            let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
            
            // Update UI on main thread
            DispatchQueue.main.async {
                self.resultsTextView.text = resultsSummary
                self.spinnerView.stopAnimating()
            }
            
            // Log completion time
            let endTime = NSDate()
            print("Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds")
        }
    }
    
    /// Action triggered by the "Do Group" button demonstrating multi-threaded execution.
    ///
    /// This method runs tasks with a combination of sequential and parallel execution:
    /// 1. Start spinner and clear results.
    /// 2. Fetch data from server.
    /// 3. Process data.
    /// 4. Perform first and second calculations in parallel using DispatchGroup.
    /// 5. When both calculations complete, update results text view and stop spinner on main thread.
    ///
    /// - Parameter sender: The UIButton triggering this action
    @IBAction func doGroupButton(_ sender: UIButton) {
        // Multi-Threaded Application with appropriate yield for other tasks
        let startTime = Date()
        
        // Clear results text view before starting work
        self.resultsTextView.text = ""
        // Start animating spinner to show activity
        spinnerView.startAnimating()
        
        let queue = DispatchQueue.global(qos: .default)
        queue.async {
            // Fetch data from server (blocking 2 sec delay)
            let fetchData = self.fetchSomethingFromServer()
            
            // Process fetched data (blocking 2 sec delay)
            let processedData = self.processData(input: fetchData)
            
            var firstResult: String!
            var secondResult: String!
            let group = DispatchGroup()
            
            // Run first calculation in parallel within DispatchGroup
            queue.async(group: group) {
                firstResult = self.calculateFirstResult(processedData)
            }
            
            // Run second calculation in parallel within DispatchGroup
            queue.async(group: group) {
                secondResult = self.calculateSecondResult(processedData)
            }
            
            // Notify once both calculations complete
            group.notify(queue: queue) {
                // Create summary string for display
                let resultsSummary = "First: [\(firstResult!)]\nSecond: [\(secondResult!)]"
                
                // Update UI on main thread
                DispatchQueue.main.async {
                    self.resultsTextView.text = resultsSummary
                    self.spinnerView.stopAnimating()
                }
                
                // Log completion time
                let endTime = Date()
                print("Completed in \(endTime.timeIntervalSince(startTime)) seconds")
            }
        }
    }
}

