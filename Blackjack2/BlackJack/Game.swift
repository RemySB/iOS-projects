//
//  Game.swift
//  BlackJack
//
//  Created by Student on 2/19/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import UIKit

class Shoe{
    init(nDecks:Int){
        dealt=[]
        numDecks=nDecks
    }
    func dealCard()->Int{
        var theCard=0
        //generate a random number between 1 and 52*numDecks
        while(find(dealt,theCard) != nil){
            //regenerate theCard
        }
        dealt.append(theCard)
        return theCard%numDecks%4+1
    }
    func clearDealt(){
        dealt=[]
    }
    var dealt: [Int]
    var numDecks:Int
    
}

class Player{
    init(dealer: Bool,playerNum:Int){
        isDealer=dealer
        cashRemaining=100
        cardLabels = [UILabel](count:7,repeatedValue:UILabel())
        cards=[Int](count:6,repeatedValue:0)
        nCards=0
        curBet=0
        if(isDealer){
            cardLabels[0].text="Dealer"
        }
        else{
            cardLabels[0].text="Player " + toString(playerNum)
        }
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
        cards.insert(card, atIndex: cards.count)
        nCards++
    }
    
    func roundOver(winnings:Int){
        cards=[Int](count:6,repeatedValue:0)
        curBet=1 //each player automatically antes
        cashRemaining+=winnings
    }
    
    func refreshCardLabels(roundOver:Bool){
        for(var i=1;i<7;i++){
            if(cards[i-1]==1){
                cardLabels[i].text = "A"
            }
            else if(cards[i-1]==11){
                cardLabels[i].text = "J"
            }
            else if(cards[i-1]==12){
                cardLabels[i].text = "Q"
            }
            else if(cards[i-1]==13){
                cardLabels[i].text = "K"
            }
            else if(cards[i-1]==0){
                cardLabels[i].text = ""
            }
            else{
                cardLabels[i].text = toString(cards[i-1])
            }
        }
        if(isDealer){
            if(!roundOver){
                cardLabels[1].text = "?"
            }
        }
    }
    var isDealer:Bool
    var cardLabels:[UILabel]
    var cashRemaining:Int
    var curBet: Int
    var cards: [Int]
    var nCards:Int
    
    
}

class BlackJackGame{
    init(nPlayers:Int,nDecks:Int){
        deck=Shoe(nDecks: nDecks)
        numPlayers=nPlayers
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
    
    func checkForBusts(checkDealer:Bool)->Bool{
        return(checkDealer ? dealer.sumCards()>21 : players[curPlayerIndx].sumCards()>21)
    }
    
    func removePlayer(){//removes the current player
        players.removeAtIndex(curPlayerIndx)
    }
    
    func startGame(){
        for player in players{
            player.recieveCard(deck.dealCard())
            player.recieveCard(deck.dealCard())
        }
    }
    
    func winnerIs()->[Int]{ //returns an array of indexes of winning players.
        var winners:[Int]=[];
        for(var i=0;(i<players.count);i++){
            if((players[i].sumCards()<22) & (players[i].sumCards()>dealer.sumCards())){
                
            }
        }
        return winners
    }
    
    func endGame(){
        if(dealer.sumCards()<22){
            
        }
    }
    
    var players: [Player]=[]
    var numPlayers:Int
    var deck:Shoe
    var dealer=Player(dealer: true,playerNum: 0)
    var curPlayerIndx=0
    
    
}