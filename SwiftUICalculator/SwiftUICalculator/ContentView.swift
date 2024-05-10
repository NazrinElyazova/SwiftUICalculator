//
//  ContentView.swift
//  SwiftUICalculator
//
//  Created by Nazrin on 01.04.24.
//

import SwiftUI

enum CalculationButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case multiplication = "*"
    case division = "/"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiplication, .division, .equal:
            return .orange
            
        case .clear, .negative, .percent:
            return Color(.lightGray)
            
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}
struct ContentView: View {
    let buttons: [[CalculationButton]] = [
        [.clear, .negative, .percent, .division],
        [.seven, .eight, .nine, .multiplication],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                //TEXT DISPLAY
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundStyle(.white)
                }.padding()
                ForEach(buttons, id: \.self) {
                    row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) {
                            item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item),
                                           height: self.buttonHeight()).background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item) / 2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalculationButton) {
        switch button {
            
        case .add, .subtract, .multiplication, .division, .equal:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            
            else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            
            else if button == .division {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            
            else if button == .multiplication {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            
            else if button == .equal {
                
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperation {
                    
                case .add: self.value = "\(runningValue + currentValue)"
                    
                case .subtract:  self.value = "\(runningValue - currentValue)"
                    
                case .multiply:  self.value = "\(runningValue * currentValue)"
                    
                case .divide:  self.value = "\(runningValue / currentValue)"
                    
                case .none:
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
            
        case .decimal, .negative, .percent:
            break
            
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalculationButton) -> CGFloat {
        if item == .zero {
            return (UIScreen.main.bounds.width - (4*12)) / 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}
#Preview {
    ContentView()
}
