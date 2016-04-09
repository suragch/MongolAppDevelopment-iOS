//
//  KeyboardChooserKey.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 1/12/16.
//  Copyright © 2016 MongolSuragch. All rights reserved.
//
import UIKit


class KeyboardChooserKey: KeyboardKey {
    
    // MARK: - Properties
    
    private let imageLayer = CALayer()
    private let menuLayerBackbround = CAShapeLayer()
    private var menuItemLayers = [KeyboardKeyTextLayer]()
    
    
    // popup keyboard menu
    var menuItemRectSize = CGSizeZero
    let menuItemPadding: CGFloat = 15
    var menuItems: [String]? { // display string array
        didSet {
            print(menuItems)
            initializeMenuItemLayers()
            updateMenuLayers()
        }
    }
    let mongolFontName = "ChimeeWhiteMirrored"
    var menuFontSize: CGFloat = 17
    private var touchDownPoint = CGPointZero
    private var longTouchMovementWidthThreshold: CGFloat = 0 // updated according to menu item width
    private var oldSelectedItem = 0
    private let defaultMenuItemBackgroundColor = UIColor.clearColor().CGColor
    private let selectedMenuItemBackgroundColor = UIColor.grayColor().CGColor
    private var oldFrame = CGRectZero
    
    @IBInspectable var image: UIImage?
        {
        didSet {
            imageLayer.contents = image?.CGImage
            updateImageLayerFrame()
        }
    }
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override var frame: CGRect {
        didSet {
            
            // only update frames if non-zero and changed
            if frame != CGRectZero && frame != oldFrame {
                updateImageLayerFrame()
                updateMenuLayers()
                oldFrame = frame
            }
        }
    }
    
    func setup() {
        
        // image layer
        imageLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(imageLayer)
        
        // menu background
        menuLayerBackbround.contentsScale = UIScreen.mainScreen().scale
        menuLayerBackbround.path = popupMenuPath().CGPath
        menuLayerBackbround.strokeColor = self.borderColor.CGColor
        menuLayerBackbround.fillColor = self.fillColor.CGColor
        menuLayerBackbround.lineWidth = 0.5
        menuLayerBackbround.hidden = true
        layer.addSublayer(menuLayerBackbround)
        
        
    }
    
    func initializeMenuItemLayers() {
        
        // clear any old layers
        menuLayerBackbround.sublayers = nil
        menuItemLayers.removeAll()
        
        // add new layers
        if let items = menuItems {
            for _ in items {
                let textLayer = KeyboardKeyTextLayer()
                textLayer.contentsScale = UIScreen.mainScreen().scale
                menuLayerBackbround.addSublayer(textLayer)
                menuItemLayers.append(textLayer)
            }
        }
    }
    
    // MARK: - Update frames
    
    func updateImageLayerFrame() {
        
        if let unwrappedImage = image {
            imageLayer.frame = bounds
            
            // shrink image if larger than bounds
            if unwrappedImage.size.height > bounds.height || unwrappedImage.size.width > bounds.width {
                imageLayer.contentsGravity = kCAGravityResizeAspect
            } else {
                imageLayer.contentsGravity = kCAGravityCenter
            }
            
        }
        
    }
    
    func updateMenuLayers() {
        
        // background layer
        let attributedMenuItems = menuItemAttributedStrings()
        menuItemRectSize = maxMenuItemSize(attributedMenuItems)
        longTouchMovementWidthThreshold = menuItemRectSize.width + menuItemPadding
        menuLayerBackbround.frame = bounds
        menuLayerBackbround.path = popupMenuPath().CGPath
        
        
        // menu item layers
        var x: CGFloat = padding + menuItemPadding
        let y: CGFloat = -padding - menuItemPadding - menuItemRectSize.height
        var counter = 0
        for textLayer in menuItemLayers {
            textLayer.frame = CGRect(x: x, y: y, width: menuItemRectSize.width, height: menuItemRectSize.height)
            x = x + menuItemRectSize.width + menuItemPadding
            textLayer.string = attributedMenuItems[counter]
            counter += 1
        }

    }
    
    func menuItemAttributedStrings() -> [NSAttributedString] {
        
        // convert the string array to an attributed string array
        
        var attrStringArray = [NSAttributedString]()
        
        let myAttribute = [ NSFontAttributeName: UIFont(name: mongolFontName, size: menuFontSize )! ]
        
        if let items = menuItems {
            for displayName in items {
                
                let attrString = NSMutableAttributedString(string: "  " + displayName + "  ", attributes: myAttribute )
                attrStringArray.append(attrString)
                
            }
        }
        
        
        return attrStringArray
    }
    
    func maxMenuItemSize(attrStrings: [NSAttributedString]) -> CGSize {
        
        var maxWidth: CGFloat = 0
        var maxHeight: CGFloat = 0
        
        for attrString in attrStrings {
            let size = dimensionsForAttributedString(attrString)
            
            if size.height > maxWidth {
                maxWidth = size.height
            }
            if size.width > maxHeight {
                maxHeight = size.width
            }
        }
        
        return CGSize(width: maxWidth, height: maxHeight)
    }
    
    func dimensionsForAttributedString(attrString: NSAttributedString) -> CGSize {
        
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var width: CGFloat = 0
        let line: CTLineRef = CTLineCreateWithAttributedString(attrString)
        width = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, nil))
        
        // make width an even integer for better graphics rendering
        width = ceil(width)
        if Int(width)%2 == 1 {
            width += 1.0
        }
        
        return CGSize(width: width, height: ceil(ascent+descent))
    }
    
    // MARK: - Gesture recognizer
    
    override func longPressBegun(guesture: UILongPressGestureRecognizer) {
        
        // ignore long press if this is the only keyboard
        if menuItemLayers.count == 0 {
            return
        }
        
        // initialize menu item background colors
        for itemLayer in menuItemLayers {
            itemLayer.backgroundColor = defaultMenuItemBackgroundColor
        }
        oldSelectedItem = 0
        menuItemLayers[0].backgroundColor = selectedMenuItemBackgroundColor
        
        touchDownPoint = guesture.locationInView(self)
        
        menuLayerBackbround.hidden = false
        
    }
    
    override func longPressStateChanged(guesture: UILongPressGestureRecognizer) {
        
        // ignore long press if this is the only keyboard
        if menuItemLayers.count == 0 {
            return
        }
        
        let touchPoint = guesture.locationInView(self)
        let dx = touchPoint.x - touchDownPoint.x
        
        // set the color for the selected item
        let selectedItem = Int(floor((dx + longTouchMovementWidthThreshold / 2) / longTouchMovementWidthThreshold))
        if selectedItem != oldSelectedItem  {
            
            if oldSelectedItem >= 0 && oldSelectedItem < menuItemLayers.count {
                menuItemLayers[oldSelectedItem].backgroundColor = defaultMenuItemBackgroundColor
            }
            
            if selectedItem >= 0 && selectedItem < menuItemLayers.count {
                
                menuItemLayers[selectedItem].backgroundColor = selectedMenuItemBackgroundColor
                
            }
            
            oldSelectedItem = selectedItem
        }
        
    }
    
    override func longPressEnded() {
        
        // ignore long press if this is the only keyboard
        if menuItemLayers.count == 0 {
            return
        }
        
        menuLayerBackbround.hidden = true
        
        if let items = menuItems {
            if oldSelectedItem >= 0 && oldSelectedItem < items.count {
                print("New keyboard selected: \(items[oldSelectedItem])")
                delegate?.keyNewKeyboardChosen(items[oldSelectedItem])
            }
        }
        
        
    }
    
    // tap event (do when finger lifted) -- This is canceled if long press occurs
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        
        delegate?.keyKeyboardTapped()
        
    }
    

    // MARK: - Path
    
    func popupMenuPath() -> UIBezierPath {
        
        //  ------------------
        // |                  |
        // |                  |
        // |   popup area     |
        // |                  |
        // |                  |
        // |                  |
        // *      ------------
        // | key |
        // |     |
        //  -----
        //
        // * starting point close to (0,0)
        // working clockwise
        
        let numberOfItems = CGFloat(self.menuItems?.count ?? 0)
        let contentWidth = numberOfItems * menuItemRectSize.width + (numberOfItems - 1) * menuItemPadding // sum of item rects plus inner padding
        var x: CGFloat = 0
        var y: CGFloat = 0
        
        
        // create a new path
        let path = UIBezierPath()
        
        // starting point for the path (on left side)
        x = padding
        path.moveToPoint(CGPoint(x: x, y: y))
        
        // top-left corner
        x = x + self.cornerRadius
        y = -padding - 2*self.menuItemPadding - self.menuItemRectSize.height + self.cornerRadius
        path.addArcWithCenter(
            CGPoint(x: x, y: y),
            radius: self.cornerRadius,
            startAngle: CGFloat(M_PI), // straight left
            endAngle: CGFloat(3*M_PI_2), // straight up
            clockwise: true)
        
        // top-right corner
        x = x - 2*self.cornerRadius + 2*self.menuItemPadding + contentWidth
        path.addArcWithCenter(
            CGPoint(x: x, y: y),
            radius: self.cornerRadius,
            startAngle: CGFloat(3*M_PI_2), // straight up
            endAngle: CGFloat(0), // straight right
            clockwise: true)
        
        // mid-right corner
        y = -padding - self.cornerRadius
        path.addArcWithCenter(
            CGPoint(x: x, y: y),
            radius: self.cornerRadius,
            startAngle: CGFloat(0), // straight right
            endAngle: CGFloat(M_PI_2), // straight down
            clockwise: true)
        
        // mid-bottom upper corner
        x = bounds.width - padding + self.cornerRadius
        y = -padding + self.cornerRadius
        path.addArcWithCenter(
            CGPoint(x: x, y: y),
            radius: self.cornerRadius,
            startAngle: CGFloat(3*M_PI_2), // straight up
            endAngle: CGFloat(M_PI), // straight left
            clockwise: false)
        
        // mid-bottom lower corner
        x = x - 2*self.cornerRadius
        y = bounds.height - padding - self.cornerRadius
        path.addArcWithCenter(
            CGPoint(x: x, y: y),
            radius: self.cornerRadius,
            startAngle: CGFloat(0), // straight right
            endAngle: CGFloat(M_PI_2), // straight down
            clockwise: true)
        
        // bottom-left corner
        x = padding + self.cornerRadius
        path.addArcWithCenter(
            CGPoint(x: x, y: y),
            radius: self.cornerRadius,
            startAngle: CGFloat(M_PI_2), // straight down
            endAngle: CGFloat(M_PI), // straight left
            clockwise: true)
        
        
        path.closePath() // draws the final line to close the path
        
        return path
    }
}