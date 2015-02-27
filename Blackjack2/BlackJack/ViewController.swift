//
//  ViewController.swift
//  BlackJack
//
//  Created by Student on 2/17/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var theGame: BlackJackGame=BlackJackGame()
    var nGames=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var betStepper: UIStepper!
    @IBOutlet weak var betButton: UIButton!
    @IBOutlet weak var playerCash: UILabel!
    @IBOutlet weak var dealerBet: UILabel!
    @IBOutlet weak var playerBet: UILabel!
    @IBOutlet weak var dealerCards: UICollectionView!
    @IBOutlet weak var playerCards: UICollectionView!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var drawButtons: UISegmentedControl!
    
    
    
    @IBAction func betButtonPressed() {
        betAllowedToggle()
        let betAmt = betStepper.value-betStepper.minimumValue
        theGame.bet(Int(betAmt))
        betStepper.minimumValue = betStepper.value
    }
    
    func drawAllowedToggle(){
        drawLabel.hidden = !drawLabel.hidden
        drawButtons.enabled = !drawButtons.enabled
    }
    
    func betAllowedToggle(){
        betButton.enabled = !betButton.enabled
        betStepper.enabled = !betStepper.enabled
        betStepper.hidden = !betStepper.hidden
    }
    
    func displayCards(roundOver:Bool){
        theGame.players[theGame.curPlayerIndx].refreshCardLabels(roundOver)
        theGame.dealer.refreshCardLabels(roundOver)
        for(var i=0; i < max(theGame.players[theGame.curPlayerIndx].cardLabels.count, theGame.dealer.cardLabels.count); ++i) {
            //dealerCards.cellForItemAtIndexPath(NSIndexPath(index: i))?.contentView.insertSubview(theGame.dealer.cardLabels[i],atIndex:0)
            dealerCards.cellForItemAtIndexPath(NSIndexPath(index: i))?.contentView.bringSubviewToFront(theGame.dealer.cardLabels[i])
            playerCards.cellForItemAtIndexPath(NSIndexPath(index: i))?.contentView.bringSubviewToFront(theGame.players[theGame.curPlayerIndx].cardLabels[i])
            
        }
    }
    
    func updateDisplayVals(roundOver:Bool){ //roundOver is true when displaying the outcome of the round, false when it's in progress
        displayCards(roundOver)
        playerCash.text="$"+String(theGame.players[theGame.curPlayerIndx].cashRemaining)
        dealerBet.text="$"+String(theGame.dealer.curBet)
    }
    
    func playGame(){
        
        
        nGames++
        if(nGames==5){
            theGame.deck.clearDealt()
            nGames=0
        }
        
        //prompt user to place a bet:
            
            betAllowedToggle()
            while(betButton.enabled){
                //wait
            }
            updateDisplayVals(false)
            //maybe draw a card? a few?
        
        
        
        updateDisplayVals(true)
    }
    
    


  
}

