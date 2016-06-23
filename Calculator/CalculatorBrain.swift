//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Prasanth Guruprasad on 5/31/16.
//  Copyright © 2016 Prasanth Guruprasad. All rights reserved.
//

import Foundation

class CalculatorBrain {
    enum Op {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }

    var opStack = [Op]()
}