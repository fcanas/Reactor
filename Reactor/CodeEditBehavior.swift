import UIKit

var CodeEditBehaviorKey :Int = 0

struct Expansion {
    let value :String
    let insertionIndex :Int
}

let PairedDelimiters = [
    "{":Expansion(value: "{\n\t\n}", insertionIndex: 3),
    "[":Expansion(value: "[]", insertionIndex: 1),
    "(":Expansion(value: "()", insertionIndex: 1),
    "'":Expansion(value: "''", insertionIndex: 1),
    "\"":Expansion(value: "\"\"", insertionIndex: 1),
]

class CodeEditBehavior: NSObject, UITextViewDelegate {
    var scaleFactor :CGFloat = 1.3
    init(textView: UITextView) {
        super.init()
        objc_setAssociatedObject(textView, &CodeEditBehaviorKey, self, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        textView.delegate = self
        style(textView)
    }
    
    class func addToTextView(textView: UITextView) {
        CodeEditBehavior(textView: textView)
    }
    
    private func style(textView: UITextView) {
        textView.backgroundColor = UIColor(red: 1, green: 0.988, blue: 0.922, alpha: 1.0)
        textView.font = UIFont(name: "Menlo-Regular", size: 14)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if let expansion = PairedDelimiters[text] {
            if let startingPosition = textView.positionFromPosition(textView.beginningOfDocument, offset: range.location) {
            
            textView.replaceRange(textView.textRangeFromPosition(startingPosition, toPosition: textView.positionFromPosition(startingPosition, offset: range.length)), withText: expansion.value)
            
            if let insertionPosition = textView.positionFromPosition(startingPosition, offset: expansion.insertionIndex) {
                textView.selectedTextRange = textView.textRangeFromPosition(insertionPosition, toPosition: insertionPosition)
            }
            return false
            }
        }
        return true
    }
}