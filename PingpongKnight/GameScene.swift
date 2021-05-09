//
//  GameScene.swift
//  PingpongKnight
//
//  Created by YashimaMasafumi on 2021/05/09.
//

import SpriteKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    //ゲームオーバーフラグ
    var gameoverFlg = false
    //ポイント
    var count:NSInteger = 0
    //ラベル
    let gameoverLabel = SKLabelNode(fontNamed: "Hiragino Kaku Gothic ProN")//ゲームオーバーを表示するラベル
    let pointLabel = SKLabelNode(fontNamed: "Hiragino Kaku Gothic ProN")//得点を表示するラベル
    
    //オブジェクト
    var ball = SKSpriteNode(imageNamed: "ball")
    var armRight = SKSpriteNode(imageNamed: "rightarm")
    var armLeft = SKSpriteNode(imageNamed: "leftarm")
    var back = SKSpriteNode(imageNamed: "back")
    var wallRight = SKSpriteNode(imageNamed: "wallright")
    var wallLeft = SKSpriteNode(imageNamed: "wallleft")
    var triangleRight = SKSpriteNode(imageNamed: "triangleright")
    var triangleLeft = SKSpriteNode(imageNamed: "triangleleft")
    var monster1 = SKSpriteNode(imageNamed: "monster1a")
    var monster2 = SKSpriteNode(imageNamed: "monster2a")
    var monster3 = SKSpriteNode(imageNamed: "monster3a")
    let playSound = SKAction.playSoundFileNamed("click.mp3", waitForCompletion: false)//効果音
    
    override func didMove(to view: SKView) {
        //背景
        back.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        back.size = self.size
        self.addChild(back)
        //重力の設定とcontactDelegateの設定
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -3)
        self.physicsWorld.contactDelegate = self
    }
}
