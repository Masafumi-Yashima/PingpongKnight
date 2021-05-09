//
//  ViewController.swift
//  PingpongKnight
//
//  Created by YashimaMasafumi on 2021/05/09.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        let scene = GameScene(size: skView.frame.size)
        skView.presentScene(scene)
        //マルチタップを無効にする
        skView.isMultipleTouchEnabled = false
        // Do any additional setup after loading the view.
    }


}

