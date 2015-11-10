//
//  MailboxViewController.swift
//  Week 3 - Mailbox
//
//  Created by designgrappler on 11/5/15.
//  Copyright © 2015 designgrappler. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!

    @IBOutlet weak var messageFrame: UIView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    
    @IBOutlet weak var menuFrame: UIView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!

    
    // setting original position
    var messageOriginalCenter: CGPoint!
    var leftIconOriginalCenter: CGPoint!
    var rightIconOriginalCenter: CGPoint!
    var parentOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //scrollView.contentSize = CGSize(width: 320, height: 1367)
        scrollView.contentSize = feedView.image!.size
        
        //var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "openCloseMenu:")
        //edgeGesture.edges = UIRectEdge.Left
        //parentView.addGestureRecognizer(edgeGesture)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
        @IBAction func swipeMessage(sender: UIPanGestureRecognizer) {
            
        // Absolute (x,y) coordinates in parent view
        let point = sender.locationInView(view)
        
        // Relative change in (x,y) coordinates from where gesture began.
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        // when gesture starts
        if sender.state == UIGestureRecognizerState.Began {
            messageOriginalCenter = messageView.center
            leftIconOriginalCenter = archiveIcon.center
            rightIconOriginalCenter = listIcon.center
            
        // while gesture is active
        } else if sender.state == UIGestureRecognizerState.Changed {
            messageView.center = CGPoint(x: messageOriginalCenter.x + translation.x, y: messageOriginalCenter.y)
            laterIcon.center = CGPoint(x: rightIconOriginalCenter.x + translation.x, y: rightIconOriginalCenter.y)
            listIcon.center = CGPoint(x: rightIconOriginalCenter.x + translation.x, y: rightIconOriginalCenter.y)
            archiveIcon.center = CGPoint(x: leftIconOriginalCenter.x + translation.x, y: leftIconOriginalCenter.y)
            deleteIcon.center = CGPoint(x: leftIconOriginalCenter.x + translation.x, y: leftIconOriginalCenter.y)
            
            // swipe message left
            if translation.x < 0 && translation.x >= -60 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageFrame.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 0
                })
                
            } else if translation.x < -60 && translation.x >= -240 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageFrame.backgroundColor = UIColor(red: 255/255, green: 211/255, blue: 30/255, alpha: 1)
                    self.laterIcon.alpha = 1
                    self.listIcon.alpha = 0
                })
                
            } else if translation.x < -240 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageFrame.backgroundColor = UIColor(red: 216/255, green: 166/255, blue: 117/255, alpha: 1)
                    self.laterIcon.alpha = 0
                    self.listIcon.alpha = 1
                })
            
            // swipe message right
            } else if translation.x > 0 && translation.x <= 60 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageFrame .backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 0
                })
        
            } else if translation.x > 60 && translation.x <= 240 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageFrame.backgroundColor = UIColor(red: 98/255, green: 217/255, blue: 98/255, alpha: 1)
                    self.archiveIcon.alpha = 1
                    self.deleteIcon.alpha = 0
                })

            } else if translation.x > 240 {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.messageFrame.backgroundColor = UIColor(red: 238/255, green: 84/255, blue: 10/255, alpha: 1)
                    self.archiveIcon.alpha = 0
                    self.deleteIcon.alpha = 1
                })
            }
            
            
        // when gesture ends
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if translation.x < -260 {
                self.messageView.alpha = 0
                self.listIcon.alpha = 0
                self.menuFrame.hidden = false
                self.rescheduleView.hidden = true
                self.listView.hidden = false
                
            } else if translation.x > -260 && translation.x < -60 {
                self.messageView.alpha = 0
                self.laterIcon.alpha = 0
                self.menuFrame.hidden = false
                self.rescheduleView.hidden = false
                self.listView.hidden = true
                
            } else if translation.x > 260 {
                self.messageView.alpha = 0
                self.deleteIcon.alpha = 0
                delay(0.3, closure: { () -> () in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.feedView.center.y -= 86
                    })
                })
                
            } else if translation.x > 60 && translation.x <= 260 {
                self.messageView.alpha = 0
                self.archiveIcon.alpha = 0
                delay(0.3, closure: { () -> () in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.feedView.center.y -= 86
                    })
                })
            }
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.messageView.center =  self.messageOriginalCenter
                self.laterIcon.center = self.rightIconOriginalCenter
                self.listIcon.center = self.rightIconOriginalCenter
                self.archiveIcon.center = self.leftIconOriginalCenter
                self.deleteIcon.center = self.leftIconOriginalCenter
                }, completion: { (Bool) -> Void in
                    //                self.messageBackgroundView.backgroundColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
                    
            })
            
        }
    }


    @IBAction func closeRescheduleView(sender: UITapGestureRecognizer) {
        self.menuFrame.hidden = true
        self.rescheduleView.hidden = true
        self.listView.hidden = true
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.feedView.center.y -= 86
            }) { (Bool) -> Void in
                self.messageView.alpha = 1
                delay(0.5, closure: { () -> () in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.feedView.center.y += 86
                    })
                })
        }
    }

    @IBAction func closeListView(sender: UITapGestureRecognizer) {
        self.menuFrame.hidden = true
        self.rescheduleView.hidden = true
        self.listView.hidden = true
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.feedView.center.y -= 86
            }) { (Bool) -> Void in
                self.messageView.alpha = 1
                delay(0.5, closure: { () -> () in
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        self.feedView.center.y += 86
                    })
                    
                })
        }
    }

    @IBAction func openCloseMenu(sender: AnyObject) {
        // Absolute (x,y) coordinates in parent view
        parentOriginalCenter = parentView.center

        if self.parentView.center.x == 160 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.parentView.center = CGPoint(x: 300, y: self.view.center.y)
            })
                
        }
        
        if self.parentView.center.x == 320 {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.parentView.center = CGPoint(x: 0, y: self.view.center.y)
            })
        }
    
    }
    
// the END
}
