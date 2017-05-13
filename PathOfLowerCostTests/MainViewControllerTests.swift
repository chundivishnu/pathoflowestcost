//
//  MainViewControllerTests.swift
//  PathOfLowerCost
//
//  Created by Mr.Ved on 5/13/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import XCTest

@testable import PathOfLowerCost

class MainViewControllerTests: XCTestCase {
    
    var mainVC: MainViewController!
    var inputTF: UITextField!
    var outputLabel: UILabel!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        mainVC = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        _ = mainVC.view
        
        inputTF = mainVC.inputTextField
        outputLabel = mainVC.outputLabel
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_createsEmptyGridArrayWithNonNumericInput() {
        let inputValue = "1,2,3,a,5"
        let outputValue = mainVC.gridArrayFromString(input: inputValue)
        let expectedOutputValue: [[Int]] = [[Int]](repeating:[Int](repeating:Int(), count: 0), count: 0)
        
        XCTAssertEqual(outputValue.description, expectedOutputValue.description)
    }
    
    func testInit_createsEmptyGridArrayWithNonInput() {
        let inputValue = ""
        let outputValue = mainVC.gridArrayFromString(input: inputValue)
        let expectedOutputValue: [[Int]] = [[Int]](repeating:[Int](repeating:Int(), count: 0), count: 0)
        
        XCTAssertEqual(outputValue.description, expectedOutputValue.description)
    }
    
    func testInit_lengthOfFirstLineDeterminesRowLengthAndMissingNumbersInLaterLinesAreZero() {
        let inputValue = "1,2,3,4,5 6,7,8"
        let outputValue = mainVC.gridArrayFromString(input: inputValue)
        let expectedOutputValue: [[Int]] = [[1, 2, 3, 4, 5], [6, 7, 8, 0, 0]]
        
        XCTAssertEqual(outputValue.description, expectedOutputValue.description)
    }
    
    func testInit_createAGridWithNegativeValues() {
        let inputValue = "6,3,-5,9 -5,2,4,10 3,-2,6,10 6,-1,-2,10"
        let outputValue = mainVC.gridArrayFromString(input: inputValue)
        let expectedOutputValue: [[Int]] = [[6, 3, -5, 9], [-5, 2, 4, 10], [3, -2, 6, 10], [6, -1, -2, 10]]
        
        XCTAssertEqual(outputValue.description, expectedOutputValue.description)
    }
    
    //MARK: - Sample 3 with no path < 50
    func testInit_sample3() {
        inputTF.text = "19,10,19,10,19 21,23,20,19,12 20,12,20,11,10"
        mainVC.goButton.sendActions(for: UIControlEvents.touchUpInside)
        let outputValue = outputLabel.text
        let expectedOutputValue = "Output:\nNo\n48\n[1, 1, 1]"
        XCTAssertEqual(outputValue, expectedOutputValue)
    }
    
    //MARK: - Sample 6 Non numeric input
    func testInit_nonNumericDataDisplayInvalidGrid() {
        inputTF.text = "5,4,H 8,M,7 5,7,5"
        mainVC.goButton.sendActions(for: UIControlEvents.touchUpInside)
        let outputValue = outputLabel.text
        let expectedOutputValue = "Output:\nInvalid Grid"
        XCTAssertEqual(outputValue, expectedOutputValue)
    }
    
    //MARK: - Sample 7 No input
    func testInit_noInputDisplayInvalidGrid() {
        inputTF.text = ""
        mainVC.goButton.sendActions(for: UIControlEvents.touchUpInside)
        let outputValue = outputLabel.text
        let expectedOutputValue = "Output:\nInvalid Grid"
        XCTAssertEqual(outputValue, expectedOutputValue)
    }
    
    //MARK: - Sample 9 one value > 50
    func testInit_sample9() {
        inputTF.text = "60,3,3,6 6,3,7,9 5,6,8,3"
        mainVC.goButton.sendActions(for: UIControlEvents.touchUpInside)
        let outputValue = outputLabel.text
        let expectedOutputValue = "Output:\nYes\n14\n[3, 2, 1, 3]"
        XCTAssertEqual(outputValue, expectedOutputValue)
    }
    
    //MARK: - Sample 10 Negative values
    func testInit_sample10() {
        inputTF.text = "6,3,-5,9 -5,2,4,10 3,-2,6,10 6,-1,-2,10"
        mainVC.goButton.sendActions(for: UIControlEvents.touchUpInside)
        let outputValue = outputLabel.text
        let expectedOutputValue = "Output:\nYes\n0\n[2, 3, 4, 1]"
        XCTAssertEqual(outputValue, expectedOutputValue)
    }
}
