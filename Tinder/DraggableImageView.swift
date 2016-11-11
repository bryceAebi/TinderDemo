//
//  DraggableImageView.swift
//  Tinder
//
//  Created by Bryce Aebi on 11/10/16.
//  Copyright © 2016 Assist. All rights reserved.
//

import UIKit

class DraggableImageView: UIView {

    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet var contentView: UIView!
    var isSwipedOff: Bool = false
    var imageCenter: CGPoint!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        // standard initialization logic
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)


    }
    
    @IBAction func onPan(_ sender: UIPanGestureRecognizer) {
        if panGestureRecognizer.state == UIGestureRecognizerState.began {
            imageCenter = profileImageView.center
        } else if panGestureRecognizer.state == UIGestureRecognizerState.changed {
            let translation = panGestureRecognizer.translation(in: self.contentView)
            if translation.x > 80{
                self.isSwipedOff = true
                UIView.animate(withDuration: 0.1, animations: {
                    self.profileImageView.center = CGPoint(x: 800, y: self.imageCenter.y)
                    
                    }, completion: { (isComplete: Bool) in
                        
                })
            }else if translation.x < -80{
                self.isSwipedOff = true
                UIView.animate(withDuration: 0.1, animations: {
                    self.profileImageView.center = CGPoint(x: -800, y: self.imageCenter.y)
                    
                    }, completion: { (isComplete: Bool) in
                        
                })
            }else{
                
                self.profileImageView.center = CGPoint(x: imageCenter.x + translation.x, y: imageCenter.y)
                UIView.animate(withDuration: 0.0, animations: {
                    let conversionValue = translation.x/152
                    let rotationValue = conversionValue * (.pi/4)
                    print("Conversion Value: \(conversionValue)")
                    print("Degrees: \(rotationValue * (.pi/4))")
                    self.profileImageView.transform = CGAffineTransform(rotationAngle: rotationValue)
                })
            }

        } else if panGestureRecognizer.state == UIGestureRecognizerState.ended {
            if !self.isSwipedOff {
                self.profileImageView.center = self.imageCenter
                self.profileImageView.transform = CGAffineTransform(rotationAngle: 0)
            }
        }
    }
    
    
    
}
