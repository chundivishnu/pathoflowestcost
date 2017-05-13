//
//  ViewController.swift
//  PathOfLowerCost
//
//  Created by Mr.Ved on 5/9/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var goButton: UIButton!
    @IBOutlet var outputLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didTapOnGoButton(_ sender: Any) {
        inputTextField.resignFirstResponder()
        let potentialGridContents:[[Int]] = gridArrayFromString(input: inputTextField.text!)
        if gridContentsAreValid(contents: potentialGridContents) {
            loadGrid(contents: potentialGridContents)
        } else {
            outputLabel.text = "Output:\nInvalid Grid"
        }
        
    }
    func loadGrid(contents: [[Int]]) {
        let validGrid = Grid(values: contents)
        let visitor = GridVisitor(grid: validGrid)
        let bestPath = visitor.getBestPathForGrid()
        
        var outputString = "Output:\n"
        
        if bestPath.isSuccessful() {
            outputString.append("Yes\n")
        } else {
            outputString.append("No\n")
        }
        outputString.append("\(bestPath.getTotalCost())\n")
        outputString.append(formatPath(path: bestPath))
        outputLabel.text = outputString
    }
    
    func gridContentsAreValid(contents: [[Int]]) -> Bool {
        if contents.count < 1 || contents.count > 10 || contents[0].count < 1 || contents[0].count > 100 {
            return false
        } else {
            return true
        }
    }
    
    func formatPath(path: PathState) -> String {
        var builder = [Int]()
        let rows: [Int] = path.getRowsTraversed()
        
        for i in 0..<rows.count {
            builder.append(rows[i])
        }
        return builder.description
    }
    
    // MARK: - Grid Utils
    func gridArrayFromString(input: String) -> [[Int]] {
        if !input .isEmpty {
            let rows: [String] = input.components(separatedBy: " ")
            let firstColumns: [String] = rows[0].components(separatedBy: ",")
            
            var output: [[Int]] = [[Int]](repeating:[Int](repeating:Int(), count: firstColumns.count), count: rows.count)
            for row in 0 ..< rows.count {
                let columns: [String] = rows[row].components(separatedBy: ",")
                for column in 0 ..< columns.count {
                    if column < output[0].count {
                        if Int(columns[column]) != nil {
                            output[row][column] = Int(columns[column])!
                        } else {
                            return [[Int]](repeating:[Int](repeating:Int(), count: 0), count: 0)
                        }
                    }
                }
            }
            return output
        } else {
            return [[Int]](repeating:[Int](repeating:Int(), count: 0), count: 0)
        }
    }
    
    // MARK: - UITextFieldDelegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

