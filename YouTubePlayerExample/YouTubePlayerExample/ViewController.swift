//
//  ViewController.swift
//  YouTubePlayerExample
//
//  Created by Giles Van Gruisen on 1/31/15.
//  Copyright (c) 2015 Giles Van Gruisen. All rights reserved.
//
//  Last Update: 2020/04/17
//

import UIKit
import YouTubePlayer

class ViewController: UIViewController, YouTubePlayerDelegate {

    @IBOutlet var playerView: YouTubePlayerView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var currentTimeButton: UIButton!
    @IBOutlet var durationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        playerView.delegate = self
    }

    @IBAction func play(sender: UIButton) {
        if playerView.ready {
            if playerView.playerState != YouTubePlayerState.Playing {
                playerView.play()
                playButton.setTitle("Pause", for: .normal)
            } else {
                playerView.pause()
                playButton.setTitle("Play", for: .normal)
            }
        }
    }

    @IBAction func prev(sender: UIButton) {
        playerView.previousVideo()
    }

    @IBAction func next(sender: UIButton) {
        playerView.nextVideo()
    }

    @IBAction func loadVideo(sender: UIButton) {
        playerView.playerVars = [
            "playsinline": "1",
            "controls": "0",
            "showinfo": "0"
            ] as YouTubePlayerView.YouTubePlayerParameters
        playerView.loadVideoID("YnwrJFvReac")
    }

    @IBAction func loadPlaylist(sender: UIButton) {
        playerView.loadPlaylistID("PLa9lDny5Nkudcs3XS-IofaeMxLfGjCowZ")
    }
    
    @IBAction func currentTime(sender: UIButton) {
        playerView.getCurrentTime() { result in
            let title = "Current Time: \(result ?? 0.0)"
            self.currentTimeButton.setTitle(title, for: .normal)
        }
    }
    
    @IBAction func duration(sender: UIButton) {
        playerView.getDuration() { result in
            let title = "Duration: \(result ?? 0.0)"
            self.durationButton.setTitle(title, for: .normal)
        }
    }

    func showAlert(message: String) {
        self.present(alertWithMessage(message: message), animated: true, completion: nil)
    }

    func alertWithMessage(message: String) -> UIAlertController {
        let alertController =  UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))

        return alertController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: YouTubePlayerDelegate
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        playButton.setTitle("Play", for: .normal)
    }
    
    func playerStateChanged(_ videoPlayer: YouTubePlayerView, playerState: YouTubePlayerState) {
        if playerState == YouTubePlayerState.Playing {
            playButton.setTitle("Pause", for: .normal)
        } else if (playerState == YouTubePlayerState.Paused) || (playerState == YouTubePlayerState.Ended) {
            playButton.setTitle("Play", for: .normal)
        }
    }
    
    func playerQualityChanged(_ videoPlayer: YouTubePlayerView, playbackQuality: YouTubePlaybackQuality) {
        
    }
    
}
