//
//  ViewController.swift
//  AdaptiveCardsTest
//
//  Created by Sebastian Florez on 10/14/17.
//  Copyright © 2017 UHub Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardView2: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var hostConfig:String = "{}"
        var cardData:String = "{}"
        var cardData2:String = "{}"
        
        if let filepath = Bundle.main.path(forResource: "hostconfig", ofType: "json") {
            do {
                hostConfig = try String(contentsOfFile: filepath)
            } catch {
                // contents could not be loaded
            }
        }
        
        if let filepath = Bundle.main.path(forResource: "card", ofType: "json") {
            do {
                cardData = try String(contentsOfFile: filepath)
            } catch {
                // contents could not be loaded
            }
        }
        
        if let filepath = Bundle.main.path(forResource: "card2", ofType: "json") {
            do {
                cardData2 = try String(contentsOfFile: filepath)
            } catch {
                // contents could not be loaded
            }
        }
        
        let hostconfigParseResult = ACOHostConfigParseResult()
        let cardParseResult = ACOAdaptiveCard.fromJson(cardData)
        if(cardParseResult!.isValid)
        {
            let renderResult = ACRRenderer.render(cardParseResult?.card, config: hostconfigParseResult.config, frame: cardView.frame)
            
            if (renderResult?.succeeded)!
            {
                let adcVc = renderResult?.viewcontroller
                self.add(adaptiveCard: adcVc!, to: cardView)
            }
        }
        
        let cardParseResult2 = ACOAdaptiveCard.fromJson(cardData2)
        if(cardParseResult2!.isValid)
        {
            let renderResult = ACRRenderer.render(cardParseResult2?.card, config: hostconfigParseResult.config, frame: cardView2.frame)
            
            if (renderResult?.succeeded)!
            {
                let adcVc = renderResult?.viewcontroller
                self.add(adaptiveCard: adcVc!, to: cardView2)
            }
        }
    }
    
    private func add(adaptiveCard:UIViewController, to container:UIView){
        let topConstraint = NSLayoutConstraint(item: adaptiveCard.view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: container, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: adaptiveCard.view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: container ,attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: adaptiveCard.view, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: container ,attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: adaptiveCard.view, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: container ,attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        
        self.addChildViewController(adaptiveCard)
        container.addSubview(adaptiveCard.view)
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        container.layoutIfNeeded()
        adaptiveCard.didMove(toParentViewController: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

