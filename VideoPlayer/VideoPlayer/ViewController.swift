//
//  ViewController.swift
//  VideoPlayer
//
//  Created by Susu Liang on 2018/1/19.
//  Copyright © 2018年 Susu Liang. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    let videoURL = URL(string: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8")
    
    let urlTextField: UITextField = {
        
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.addSublayer(playerLayer)
        player.play()
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

