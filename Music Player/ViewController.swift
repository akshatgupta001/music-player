//
//  ViewController.swift
//  Music Player
//
//  Created by Akshat Gupta on 29/08/19.
//  Copyright © 2019 coded. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mp3Player:MusicPlayerManager?
    var timer:Timer?
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var trackName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mp3Player = MusicPlayerManager()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func playSong(_ sender: Any) {
        mp3Player?.play()
        startTimer()
        setTrackName()
    }
    
    @IBAction func pauseSong(_ sender: Any) {
        mp3Player?.pause()
        timer?.invalidate()
    }
    @IBAction func playNextSong(_ sender: Any) {
        mp3Player?.nextSong(songFinishedPlaying: false)
        startTimer()
        setTrackName()
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateViewsWithTimer(theTimer:)), userInfo: nil, repeats: true)
    }
    @objc func updateViewsWithTimer(theTimer: Timer){
        updateViews()
    }
    func updateViews(){
        //trackTime.text = mp3Player?.getCurrentTimeAsString()
        if let progress = mp3Player?.getProgress() {
            progressBar.progress = progress
        }
        if let t = mp3Player?.getCurrentTimeAsString(){
            time.text = t
        }
    }
    func setTrackName(){
        trackName.text = mp3Player?.getCurrentTrackName()
    }
}

