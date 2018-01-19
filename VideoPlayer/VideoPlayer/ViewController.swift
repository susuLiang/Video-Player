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

class Player: NSObject {

    let player: AVPlayer = AVPlayer()

    @objc dynamic var timeControlStatus: AVPlayerTimeControlStatus = .waitingToPlayAtSpecifiedRate

}

class ViewController: UIViewController {

//    let videoURL = URL(string: "http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8")
    var videoURL: URL?
    var player = Player()
    var playerLayer: AVPlayerLayer!
    var isMuted = false

    var urlTextField: UITextField = {
        let textField = UITextField()
        textField.frame = CGRect(x: 10, y: 44, width: UIScreen.main.bounds.width - 20, height: 30)
        textField.backgroundColor = .white
        return textField
    }()

    var playOrPuaseButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 10, y: UIScreen.main.bounds.height - 100, width: 100, height: 50)
        button.backgroundColor = .white
        button.setTitle("Pause", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pause), for: .touchUpInside)
        return button
    }()

    var muteButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: UIScreen.main.bounds.width - 110, y: UIScreen.main.bounds.height - 100, width: 100, height: 50)
        button.backgroundColor = .white
        button.setTitle("Mute", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(mute), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        urlTextField.delegate = self

        playerLayer = AVPlayerLayer(player: player.player)
        playerLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(playerLayer, at: 1)

        self.view.addSubview(urlTextField)
        self.view.addSubview(playOrPuaseButton)
        self.view.addSubview(muteButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        print(keyPath)
    }

    @objc func pause(_ sender: UIButton) {
        player.player.pause()
        sender.setTitle("Pause", for: .normal)
        player.timeControlStatus = .paused
        sender.removeTarget(nil, action: nil, for: .allEvents)
        sender.addTarget(self, action: #selector(play), for: .touchUpInside)
    }

    @objc func play(_ sender: UIButton) {
        player.player.play()
        sender.setTitle("Play", for: .normal)
        player.timeControlStatus = .playing
        sender.removeTarget(nil, action: nil, for: .allEvents)
        sender.addTarget(self, action: #selector(pause), for: .touchUpInside)
    }

    @objc func mute(_ sender: UIButton) {
        self.isMuted = !isMuted
        player.player.isMuted = isMuted
    }

}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        videoURL = URL(string: textField.text!)
        let playerItem = AVPlayerItem(url: videoURL!)
        let observation = player.observe(\Player.timeControlStatus, changeHandler: { (new, old) in
            print(new)
            print(old)

        })
//        player.addObserver(self, forKeyPath:  , options: [ .new, .old], context: nil)
        player.player.replaceCurrentItem(with: playerItem)

        player.player.play()
        return true
    }

}
