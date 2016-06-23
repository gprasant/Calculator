//
//  ViewController.swift
//  Calculator
//
//  Created by Prasanth Guruprasad on 5/16/16.
//  Copyright © 2016 Prasanth Guruprasad. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddleOfTypingANumber: Bool = false
    var operandStack = [Double]()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            var displayText = display.text!
            display.text = displayText + digit

        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter();
        }
        switch operation {
            case "×":
                performOperation { $0 * $1 }
            case "÷":
                performOperation { $1 / $0 }
            case "+":
                performOperation { $0 + $1 }
            case "−":
                performOperation { $1 - $0 }
            case "√":
                performOperation(sqrt)
            default: break

        }
    }

    private func performOperation(operation: (Double, Double) -> Double) {
        if (operandStack.count >= 2) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast() )
            enter();
        }
    }

    private func performOperation(operation: (Double) -> Double) {
        if (operandStack.count >= 1) {
            displayValue = operation(operandStack.removeLast())
            enter();
        }
    }

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
            print("operandStack = \(operandStack)")
    }

    var displayValue : Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

