//
//  Game.swift
//  BlackJack
//
//  Created by Student on 2/19/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation

class BlackJackGame{
    init(){
        players.append(Player(dealer: true))
        players.append(Player(dealer: false))
    }
    
    func getDealer()->Player{
        return players.first!
    }
    
    func Bet(amt:Int){
        for player in players{
            if(!player.isDealer){
                player.curBet=amt
            }
            else{
                player.curBet=1
            }
            player.cashRemaining -= player.curBet
            pot+=player.curBet
        }
    }
    
    func startGame(){
        for player in players{
            player.recieveCard(deck.dealCard())
            player.recieveCard(deck.dealCard())
        }
    }
    
    func endGame(){
        var highscore=0
        var winner=Player(dealer: false) //just initializing this so it can be used later
        
        for player in players{
            if((player.sumCards()<22) & (player.sumCards()>highscore)){
                highscore=player.sumCards()
                winner=player
            }
            player.cards=[]
            player.curBet=0
        }
        winner.cashRemaining+=pot
        pot=0
    }
    
    var players: [Player]=[]//made this an array rather than individual players because we will be adding more players later
    var pot=0
    var deck=Deck()
    
    
}