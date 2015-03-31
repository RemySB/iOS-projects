//
//  Game.swift
//  BlackJack
//
//  Created by Student on 2/19/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation

class Shoe{
    init(nDecks:Int){
        dealt=[]
        numDecks=nDecks
    }
    func dealCard()->Int{
        var theCard=0
        theCard = Int(arc4random_uniform(52*UInt32(numDecks)))
        while(find(dealt,theCard) != nil){
            theCard = Int(arc4random_uniform(52*UInt32(numDecks)))
        }
        dealt.append(theCard)
        return theCard%numDecks%4 + 1 //number generated is btwn 0 and n-1
    }
    func clearDealt(){
        dealt=[]
    }
    var dealt: [Int]
    var numDecks:Int
    
}

class Player{
    init(isdealer: Bool, name: String){
        isDealer = isdealer
        cashRemaining = 100
        curBet = 0
    }
    
    func sumCards()->Int{
        var sum=0
        var ace=false
        for card in cards{
            if(card==1){
                ace=true
            }
            
            if(card>10){
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
        cardChars.append(cardToChar(card))
        if(sumCards()>=21){
            out = true
        }
    }
    
    func roundOver(winnings:Int){
        cards=[Int]()
        cashRemaining+=winnings
        if(cashRemaining<=0){
            out=true
        }
        curBet=1 //each player automatically antes
        cashRemaining-=1
    }
    
    func cardToChar(card: Int)->String{
        if(card==1){
            return "A"
        }
        else if(card==11){
            return "J"
        }
        else if(card==12){
            return "Q"
        }
        else if(card==13){
            return "K"
        }
        else{
            return toString(card)
        }
    }
    var isDealer:Bool
    var cardChars = [String]()
    var cashRemaining:Int
    var curBet: Int
    var cards = [Int]()
    var out = false
    
    
}

class BlackJackGame{
    init(nPlayers:Int,nDecks:Int){
        deck=Shoe(nDecks: nDecks)
        players.append(Player(isdealer: false, name: "AI player"))
        for(var i=1;i<=nPlayers;i++){
            players.append(Player(isdealer: false, name: ("Player " + toString(i))))
        }
        initialDeal()
    }
    
    func initialDeal(){
        dealer.recieveCard(deck.dealCard())
        dealer.recieveCard(deck.dealCard())
        dealer.cardChars[0] = "?"
        
        for player in players{
            player.recieveCard(deck.dealCard())
            player.recieveCard(deck.dealCard())
        }
    }
    
    func bet(amt:Int){
        players[curPlayerIndx].curBet+=amt
        players[curPlayerIndx].cashRemaining -= amt
        
        if(dealer.sumCards()<10){
            dealer.curBet=1
        }
        else if(dealer.sumCards()<16){
            dealer.curBet=2
        }
        else{
            dealer.curBet=3
        }
        
    }
    
    func dealerHit()->Bool{
        if(dealer.sumCards()<17){
            dealer.recieveCard(deck.dealCard())
            return true
        }
        return false
    }
    
    
    func winnerIs()->[Int]{ //returns an array of indexes of winning players.
        var winners:[Int]=[]
        for(var i=0;(i<players.count);i++){
            if((players[i].sumCards()<22) & (players[i].sumCards()>dealer.sumCards())){
                
            }
        }
        return winners
    }
    
    var players = [Player]()
    var deck:Shoe
    var dealer=Player(isdealer: true, name: "Dealer")
    var curPlayerIndx=0
    
    
}