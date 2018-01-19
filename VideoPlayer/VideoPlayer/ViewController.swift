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
    var observation: NSKeyValueObservation!
    var playerLayer: AVPlayerLayer!
    var isMuted = false
    var searchUrl: UISearchController!

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

        playerLayer = AVPlayerLayer(player: player.player)
        playerLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(playerLayer, at: 1)

        searchUrl = UISearchController(searchResultsController: nil)
        searchUrl.searchBar.delegate = self
        self.view.addSubview(searchUrl.searchBar)

        self.view.addSubview(playOrPuaseButton)
        self.view.addSubview(muteButton)

        observation = player.observe(\.timeControlStatus, changeHandler: { (newStatus, _) in
            switch newStatus.timeControlStatus {
            case .paused:
                self.playOrPuaseButton.removeTarget(nil, action: nil, for: .touchUpInside)
                self.playOrPuaseButton.addTarget(self, action: #selector(self.play), for: .touchUpInside)
            case .playing:
                self.playOrPuaseButton.removeTarget(nil, action: nil, for: .touchUpInside)
                self.playOrPuaseButton.addTarget(self, action: #selector(self.pause), for: .touchUpInside)
            default:
                break
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func play(_ sender: UIButton) {
        player.player.play()
        player.timeControlStatus = .playing
    }

    @objc func pause(_ sender: UIButton) {
        player.player.pause()
        player.timeControlStatus = .paused
    }

    @objc func mute(_ sender: UIButton) {
        self.isMuted = !isMuted
        player.player.isMuted = isMuted
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.placeholder = searchBar.text
        videoURL = URL(string: searchBar.text!)
        let playerItem = AVPlayerItem(url: videoURL!)
        player.player.replaceCurrentItem(with: playerItem)
        player.player.play()
        self.searchUrl.isActive = false
    }
}
