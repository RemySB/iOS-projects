//
//  ViewController.swift
//  BlackJack
//
//  Created by Student on 2/17/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit


class Deck{
    init(){
        dealt=[]
    }
    internal func dealCard()->Int{
        var theCard=0
        //generate a random number between 1 and 52
        for(var i=0;i<dealt.count;++i){
            if(dealt[i]==theCard){
                i=0
                //generate a new random number between 1 and 52
            }
        }
        dealt.append(theCard)
        return theCard%4
    }
    internal func clearDealt(){
        dealt=[]
    }
    var dealt: [Int]
    
}

class Player{
    init(dealer: Bool){
        isDealer=dealer
        cashRemaining=100
        cards=[]
        curBet=0
    }
    
    
    
    func sumCards()->Int{
        var sum=0
        var ace=false
        for card in cards{
            if(card==1){
                ace=true
            }
            
            if(card<10){
                sum+=10
            }
            else{
                sum+=card
            }
        }
        
        if((sum<=11) & ace){ //if it will not put the player over, count ace as 11
            sum+=10 //ace already added 1 to sum
        }
        
        return sum
    }
    
    func recieveCard(card:Int){
        cards.append(card)
    }
    func clearCards(){
        cards=[]
    }
    var isDealer:Bool
    var cashRemaining:Int
    var curBet: Int
    var cards: [Int]
    
    
}



class ViewController: UIViewController {
    
    var theGame: BlackJackGame=BlackJackGame()
    var nGames=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        betButton.enabled=false
        BetField.enabled=false
        betButton.opaque=false
        Message.text="No game in progress!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var BetField: UITextField!
    @IBOutlet weak var betButton: UIButton!
    @IBOutlet weak var playerCash: UILabel!

    @IBOutlet weak var PlayerPicker: UIPickerView!
    @IBOutlet weak var playerScroll: UIPickerView!
    @IBOutlet weak var Message: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var dealerBet: UILabel!
    @IBOutlet weak var pot: UILabel!
    @IBOutlet weak var dealerCards: UICollectionView!
    
    
    @IBAction func PlayButtonPressed() {
        playButton.enabled=false
        playGame()
    }
    
    func betAllowedToggle(){
        betButton.enabled = !betButton.enabled
        BetField.enabled = !BetField.enabled
        betButton.opaque = !betButton.opaque
    }
    
    @IBAction func betButtonPressed() {
        betAllowedToggle()
        let betText = BetField.text.toInt()
        theGame.Bet(betText!)
    }
    
    func updateDisplayVals(gameOver:Bool){ //gameOver is true when displaying the outcome of the game, false when it's in progress
        //update cards
        
        
        
        dealerCash.text="$"+String(theGame.getDealer().cashRemaining)
        playerCash.text="$"+String(theGame.players[1].cashRemaining) //hardcoded for now, will change when implementing more players
        dealerBet.text="$"+String(theGame.getDealer().curBet)
        pot.text="Pot: $"+String(theGame.pot)
    }
    
    func playGame(){
        nGames++
        if(nGames==5){
            theGame.deck.clearDealt()
            nGames=0
        }
        theGame.startGame()
        updateDisplayVals(false)
        
        if((theGame.getDealer().sumCards()<22) & (theGame.players[1].sumCards()<22)){
            //prompt user to place a bet:
            Message.text="Place a bet!"
            Message.opaque=true
            betAllowedToggle()
            
            while(betButton.enabled){
                //wait
            }
            updateDisplayVals(false)
            //maybe draw a card? a few?
        }
        
        theGame.endGame()
        updateDisplayVals(true)
        Message.text="Game over!"
    }
    
    


  
}

