import Foundation

class TipCalculator {

  var billAmount: Double
  
  init(amount: Double) {
    self.billAmount = amount
  }
  
  func calculateTip(tipPercentage: Double) -> Double {
    return billAmount * tipPercentage
  }
  
  func calculateTotalBill(tipPercentage: Double) -> Double {
    return billAmount + calculateTip(tipPercentage)
  }
  
  func calculateTotalBillFormattedAsCurrency(tipPercentage: Double) -> String {
    var formatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    let totalBill = calculateTotalBill(tipPercentage)
    return formatter.stringFromNumber(totalBill)!
  }
  
  var fifteenPercentTip: String {
    return calculateTotalBillFormattedAsCurrency(0.15)
  }
  
  var eighteenPercentTip: String {
    return calculateTotalBillFormattedAsCurrency(0.18)
  }
  
  var twentyPercentTip: String {
    return calculateTotalBillFormattedAsCurrency(0.20)
  }

}

// This code is just to check if everything is working.
let tipCalculator = TipCalculator(amount: 20)
tipCalculator.billAmount = 100
tipCalculator.calculateTip(0.20) // returns 4.0
tipCalculator.calculateTotalBill(0.20) // returns 24.0
tipCalculator.calculateTotalBillFormattedAsCurrency(0.20)
tipCalculator.fifteenPercentTip
tipCalculator.eighteenPercentTip
tipCalculator.twentyPercentTip
