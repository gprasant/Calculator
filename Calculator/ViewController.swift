//
//  ViewController.swift
//  Calculator
//
//  Created by Prasanth Guruprasad on 5/16/16.
//  Copyright © 2016 Prasanth Guruprasad. All rights reserved.
//

import UIKit
/* For the view grid, checkout this answer on StackOverflow
    http://stackoverflow.com/a/36415807/223656
 */
class ViewController: UIViewController
{
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var operandStack = [Double]()
    private let radConverter = round((M_PI / 180) * 10000)/10000

    var displayValue : Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }

    //MARK: - Outlets and Actions
    @IBOutlet weak var display: UILabel!

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsInTheMiddleOfTypingANumber {
            let displayText = display.text!
            display.text = displayText + digit

        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func appendDot(sender: UIButton) {
        // if displayText has Dot
            // return 
        if let displayText = display.text {
            if displayText.containsString(".") {
                return
            }
        }
        appendDigit(sender)
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
            case "sin":
                performOperation(trigSin)
            case "cos":
                performOperation(trigCos)
            case "π":
                performOperation(conjurePi)
            default: break

        }
    }

    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }

    //MARK: Helpers for actions
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

    private func performOperation(operation: () -> Double) {
        displayValue = operation();
        enter();
    }

    private func trigSin(degree: Double) -> Double {
        return sin(degree * radConverter)
    }

    private func trigCos(degree: Double) -> Double {
        return cos(degree * radConverter)
    }

    private func conjurePi() -> Double {
        return round(M_PI*10000)/10000;
    }
}

