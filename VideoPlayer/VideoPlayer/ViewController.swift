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
    
//    let videoURL = URL(string: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8")
    var videoURL: URL?
    var player = AVPlayer()
    var playerLayer: AVPlayerLayer!
    
    var urlTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 10, y: 44, width: UIScreen.main.bounds.width - 20, height: 30)
        textField.backgroundColor = .white
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        urlTextField.delegate = self
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(playerLayer, at: 1)
        self.view.addSubview(urlTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        videoURL = URL(string: textField.text!)
        let playerItem = AVPlayerItem(url: videoURL!)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        return true
    }
    
}

