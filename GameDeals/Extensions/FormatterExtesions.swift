import Foundation

extension Double {
    func formattedCurrency(localeIdentifier: String = "pt_br") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: localeIdentifier)
        
        return formatter.string(from: NSNumber(value: self)) ?? "-1,11"
    }
}
