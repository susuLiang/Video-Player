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

    var videoURL: URL?
    var player = Player()
    var statusInt: Int?
    var observation: NSKeyValueObservation!
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
        button.addTarget(self, action: #selector(playOrPause), for: .touchUpInside)
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

        observation = player.observe(\.timeControlStatus, changeHandler: { (player, _) in
            self.statusInt = player.timeControlStatus.rawValue
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func playOrPause(_ sender: UIButton) {

        if statusInt == 0 {
            player.player.play()
            player.timeControlStatus = .playing
        } else if statusInt == 2 {
            player.player.pause()
            player.timeControlStatus = .paused
        }
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

        player.player.replaceCurrentItem(with: playerItem)

        player.player.play()

        statusInt = 2
        return true
    }

}
