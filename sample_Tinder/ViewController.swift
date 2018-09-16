//
//  ViewController.swift
//  sample_Tinder
//
//  Created by staff on 2018/09/10.
//  Copyright © 2018年 staff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var basicCard: UIView!
    @IBOutlet weak var likeImageView: UIImageView!
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var person3: UIView!
    @IBOutlet weak var person4: UIView!
    
    var centerOfCard: CGPoint!
    var people = [UIView]()
    var selectedCardCount: Int = 0
    
    let name = ["ほのか","あかり","ゆか","カルロス"]
    var likedName = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = basicCard.center
        people.append(person1)
        people.append(person2)
        people.append(person3)
        people.append(person4)
    }
    
    // segueを実行する時の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PushList" {
            // destination = segueの遷移先のこと
            let vc = segue.destination as! ListViewController
            vc.likedName = likedName
        }
    }
    
    func resetCard() {
        basicCard.center = self.centerOfCard
        basicCard.transform = .identity
    }
    
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        //        どれくらいスワイプしたかの位置情報をpointで取得
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        people[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        // 角度を変える
        // 中心からどのくらい離れているかの値
        let xFromCenter = card.center.x - view.center.x
        // 45度に傾けさせる
        card.transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        people[selectedCardCount].transform = CGAffineTransform(rotationAngle: xFromCenter / (view.frame.width / 2) * -0.785)
        
        // 右にスワイプしたときgood
        if xFromCenter > 0 {
            likeImageView.image = #imageLiteral(resourceName: "good")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.red
        // 左にスワイプしたときbad
        } else if xFromCenter < 0 {
            likeImageView.image = #imageLiteral(resourceName: "bad")
            likeImageView.alpha = 1
            likeImageView.tintColor = UIColor.blue
        }
        
        if sender.state == UIGestureRecognizerState.ended {
            // 左にスワイプ
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.resetCard()
                    // 現在選択されているカードのcenter
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 300, y: self.people[self.selectedCardCount].center.y)
                })
                likeImageView.alpha = 0
                selectedCardCount += 1
                // 最後のカードがスワイプされた時の処理
                if selectedCardCount >= people.count {
                    // sender = 遷移する時に渡す遷移元の情報
                    performSegue(withIdentifier: "PushList", sender: self)
                }
                return
                
                // 右にスワイプ
            } else if card.center.x > self.view.frame.width - 75 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.resetCard()
                    self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x + 300, y: self.people[self.selectedCardCount].center.y)
                })
                likeImageView.alpha = 0
                likedName.append(name[selectedCardCount])
                selectedCardCount += 1
                if selectedCardCount >= people.count {
                    performSegue(withIdentifier: "PushList", sender: self)
                }
                return
            }
            
            //            元に戻る処理
            UIView.animate(withDuration: 0.2, animations: {
                self.resetCard()
                // 位置を元に戻す
                self.people[self.selectedCardCount].center = self.centerOfCard
                // 角度を元に戻す
                self.people[self.selectedCardCount].transform = .identity
            })
            likeImageView.alpha = 0
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.resetCard()
            self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x + 500, y: self.people[self.selectedCardCount].center.y)
        })
        likeImageView.alpha = 0
        likedName.append(name[selectedCardCount])
        selectedCardCount += 1
        if selectedCardCount >= people.count {
            performSegue(withIdentifier: "PushList", sender: self)
        }
    }
    
    @IBAction func dislikedButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.resetCard()
            // 現在選択されているカードのcenter
            self.people[self.selectedCardCount].center = CGPoint(x: self.people[self.selectedCardCount].center.x - 500, y: self.people[self.selectedCardCount].center.y)
        })
        likeImageView.alpha = 0
        selectedCardCount += 1
        // 最後のカードがスワイプされた時の処理
        if selectedCardCount >= people.count {
            // sender = 遷移する時に渡す遷移元の情報
            performSegue(withIdentifier: "PushList", sender: self)
        }
    }
}

