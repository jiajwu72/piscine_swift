//
//  ChatBotController.swift
//  exo
//
//  Created by jiajun wu on 22/10/2019.
//  Copyright © 2019 Jiajun WU. All rights reserved.
//

import UIKit
import ForecastIO
import  RecastAI
import JSQMessagesViewController

struct User {
    let id:String
    let name:String
}

class ChatBotController: JSQMessagesViewController {

    
    let user2:User=User(id: "2", name: "bot")
    let user1:User=User(id: "1", name: "timi")

    var messages=[JSQMessage]()
    let bot = RecastAIClient(token : "4c2c4e6447ecbdc03e06ca74e8497155", language: "fr")
    let darkSkyClient = DarkSkyClient(apiKey: "a265eff50f4af5817a0cac58a3afa3a7")
    var hasError:Bool=false
    var botMsg:String=""
    var finish:Bool=false
    var currentUser:User{
        return user1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.messages=getMessages()
        self.senderId=currentUser.id
        self.senderDisplayName=currentUser.name
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        messages.append(message!)
        
        if message?.senderId == currentUser.id{
            print("bot say")
            DispatchQueue.main.async {
                self.makeRequest(request: (message?.text)!)
            }
        }
        //print(messages.count)
        finishSendingMessage()
    }
    
    func makeRequest(request:String) {
        defer {
            print("finish tapping")
        }
        if request != ""{
            self.bot.textConverse(request, successHandler: recastResponse, failureHandle: recastError)
            
        } else {
            //self.botMsg = "Request can't be empty"
            let botMessage=JSQMessage(senderId: self.user2.id, displayName: self.user2.name, text: "Error")
            self.messages.append(botMessage!)
            self.collectionView.reloadData()
        }
        
        //print(self.botMsg as String)
    }
    
    func recastError(error: Error) {
        self.hasError = true
        let botMessage=JSQMessage(senderId: self.user2.id, displayName: self.user2.name, text: "Error")
        self.messages.append(botMessage!)
        self.collectionView.reloadData()
        //print(error)
    }
    
    func recastResponse(response: ConverseResponse){
        print("REPONSE = \(response)")
        if let myRes = response.entities?["location"] as? [[String : Any]]{
            let lat = myRes[0]["lat"] as! Double?
            let lng = myRes[0]["lng"] as! Double?
            
            let myLoc = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
            self.darkSkyClient.getForecast(location: myLoc, completion: { result in
                switch result {
                case .success(let value, _):
                    let formatted = myRes[0]["formatted"] as! String?
                    DispatchQueue.main.async {
                        //self.botMsg = "\(formatted!) is \((value.hourly!.summary)!)"
                        let botMessage=JSQMessage(senderId: self.user2.id, displayName: self.user2.name, text: "\(formatted!) is \((value.hourly!.summary)!)")
                        self.messages.append(botMessage!)
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    let botMessage=JSQMessage(senderId: self.user2.id, displayName: self.user2.name, text: "Error")
                    self.messages.append(botMessage!)
                    self.collectionView.reloadData()
                    //print("Error")
                }
            })
        } else {
            if (response.intents?.count != 0) {
                if let myRes = response.intents as? [[String : Any]] {
                    if let mySlug = myRes[0]["slug"] as? String{
                        print(mySlug)
                        DispatchQueue.main.async {
                            //self.botMsg = mySlug
                            let botMessage=JSQMessage(senderId: self.user2.id, displayName: self.user2.name, text: "Error")
                            self.messages.append(botMessage!)
                            self.collectionView.reloadData()
                            //self.finish=true
                        }
                    }

                }
            } else {
                //self.botMsg = "Error"
                let botMessage=JSQMessage(senderId: self.user2.id, displayName: self.user2.name, text: "Error")
                self.messages.append(botMessage!)
                self.collectionView.reloadData()
                //self.finish=true
                //print("Error")
            }
        }
    }
    
}

extension ChatBotController{
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(messages.count)
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        let cell=messages[indexPath.row]
        //print(cell)
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let bubbleFactory=JSQMessagesBubbleImageFactory()
        
        let message=messages[indexPath.row]
        if (currentUser.id==message.senderId){
            return bubbleFactory?.outgoingMessagesBubbleImage(with: .green)
        }else{
            return bubbleFactory?.incomingMessagesBubbleImage(with: .blue)
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let msg=messages[indexPath.row]
        let msgName=msg.senderDisplayName
        return NSAttributedString(string: msgName!)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
}

extension ChatBotController{
    func getMessages()->[JSQMessage] {
        var messages=[JSQMessage]()
        let message1=JSQMessage(senderId: "1", displayName: "timi", text: "hi")
        let message2=JSQMessage(senderId: "2", displayName: "bot", text: "hello")
        messages.append(message1!)
        messages.append(message2!)
        return messages
    }
}
