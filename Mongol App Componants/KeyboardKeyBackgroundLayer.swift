import UIKit

//class KeyboardKeyBackgroundLayer: CALayer {
//    var highlighted: Bool = false {
//        didSet {
//            setNeedsDisplay()
//        }
//    }
//    weak var keyboardKey: KeyboardKey?
//    
//    override func drawInContext(ctx: CGContext) {
//        if let key = keyboardKey {
//            
//            let keyFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
//            let keyPath = UIBezierPath(roundedRect: keyFrame, cornerRadius: key.cornerRadius)
//            
//            // Shadow
//            let shadowColor = UIColor.grayColor()
//            CGContextSetShadowWithColor(ctx, CGSize(width: 0.0, height: 1.0), 1.0, shadowColor.CGColor)
//            CGContextSetFillColorWithColor(ctx, key.fillTintColor.CGColor)
//            CGContextAddPath(ctx, keyPath.CGPath)
//            CGContextFillPath(ctx)
//            
//            // Outline
//            CGContextSetStrokeColorWithColor(ctx, shadowColor.CGColor)
//            CGContextSetLineWidth(ctx, 0.5)
//            CGContextAddPath(ctx, keyPath.CGPath)
//            CGContextStrokePath(ctx)
//            
//            if highlighted {
//                CGContextSetFillColorWithColor(ctx, UIColor(white: 0.0, alpha: 0.1).CGColor)
//                CGContextAddPath(ctx, keyPath.CGPath)
//                CGContextFillPath(ctx)
//            }
//            
//        }
//    }
//}