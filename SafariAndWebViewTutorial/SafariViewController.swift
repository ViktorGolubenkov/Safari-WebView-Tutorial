//
//  SafariViewController.swift
//  SafariAndWebViewTutorial
//
//  Created by Viktor Golubenkov on 20.01.2021.
//

import UIKit
import SafariServices

class SafariViewController: UIViewController {

    @IBOutlet weak var showMeGoogleOutlet: UIButton!
    @IBOutlet weak var showMeWebViewOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func showMeGoogleButtonPressed(_ sender: UIButton) {
        if let url = URL(string: "https://www.google.com") {
            let safariViewController = SFSafariViewController(url: url)
            
            present(safariViewController, animated: true, completion: nil)
        }
    }
    @IBAction func showMeWebViewButtonPressed(_ sender: UIButton) {
    }
    
}

//      I just like playing with the button :)
extension SafariViewController {
    
    override func viewDidAppear(_ animated: Bool) {
//        adding style and shadows
        showMeGoogleOutlet.layer.cornerRadius = 12
        showMeGoogleOutlet.setTitleShadowColor(.black, for: .normal)
        
        showMeWebViewOutlet.layer.cornerRadius = 12
        showMeWebViewOutlet.setTitleShadowColor(.black, for: .normal)
        
//        Adding animation
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.showMeGoogleOutlet.center.y -= 555
            self.showMeGoogleOutlet.frame.size.width = 200
            
            self.showMeWebViewOutlet.center.y += 555
            self.showMeWebViewOutlet.frame.size.width = 200
        }
//        Start the animation everytime when the view appear
        animator.startAnimation(afterDelay: 0.5)
    }
    
}
