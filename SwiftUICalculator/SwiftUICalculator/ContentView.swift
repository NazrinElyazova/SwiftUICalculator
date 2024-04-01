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

struct ContentView: View {
    let buttons: [[CalculationButton]] = [
        [.clear, .negative, .percent, .division],
        [.seven, .eight, .nine, .multiplication],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                //TEXT DISPLAY
                HStack {
                    Spacer()
                    Text("0")
                        .bold()
                        .font(.system(size: 53))
                        .foregroundStyle(.white)
                }.padding()
                ForEach(buttons, id: \.self) {
                    row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) {
                            item in
                            Button(action: {
                                
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
    func buttonWidth(item: CalculationButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}
#Preview {
    ContentView()
}
