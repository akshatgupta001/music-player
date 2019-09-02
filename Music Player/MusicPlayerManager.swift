//
//  MusicPlayerManager.swift
//  Music Player
//
//  Created by Akshat Gupta on 29/08/19.
//  Copyright © 2019 coded. All rights reserved.
//

import Foundation

import AVFoundation
protocol  MusicPlayerProtocol {
    func play() ->  Void
    func pause() -> Void
    func nextSong(songFinishedPlaying:Bool) -> Void
}
class MusicPlayerManager: NSObject, AVAudioPlayerDelegate, MusicPlayerProtocol {
    
    
    var player:AVAudioPlayer?
    var currentTrackIndex = 0
    var tracks:[String] = [String]()
    
    override init(){
        
            tracks = Bundle.main.paths(forResourcesOfType: "mp3", inDirectory: nil)
//            tracks = ["https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
//                       "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3"]
        print(tracks)
        super.init()
       queueTrack();
    }
    
    func queueTrack(){
        if (player != nil) {
            player = nil
        }

       let url = NSURL.fileURL(withPath: tracks[currentTrackIndex] as String)
        
       // let tempURL = URL.init(string: tracks[currentTrackIndex])
        let songData = NSData(contentsOf: url)
        do{
            player = try AVAudioPlayer.init(data: songData! as Data)
        }catch{
            print("wronf")
        }
        
       // let url = Bundle.main.url(forResource: tracks[currentTrackIndex], withExtension: "mp3")
//            do{
//                player = try AVAudioPlayer(contentsOf: url)
//                player?.delegate = self
//                player?.prepareToPlay()
//            }catch{
//                // show alert
//            }
        
    
      
       
    }
    
    func play() {
        
        if player?.isPlaying == false {
            player?.play()
        }
    }
    func pause(){
        if player?.isPlaying == true{
            player?.pause()
        }
    }
    
    func nextSong(songFinishedPlaying:Bool){
        var playerWasPlaying = false
        if player?.isPlaying == true {
            player?.stop()
            playerWasPlaying = true
        }
        
        currentTrackIndex = currentTrackIndex + 1
        if currentTrackIndex >= tracks.count {
            currentTrackIndex = 0
        }
        queueTrack()
        if playerWasPlaying || songFinishedPlaying {
            player?.play()
        }
    }
    
    func getCurrentTrackName() -> String {
       
        let components =  tracks[currentTrackIndex].components(separatedBy: "/")
        let trackName = components.last
        return trackName ?? "song"
    }
    
    func getCurrentTimeAsString() -> String {
        var seconds = 0
        var minutes = 0
        if let time = player?.currentTime {
            seconds = Int(time) % 60
            minutes = (Int(time) / 60) % 60
        }
        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
    
    func getProgress()->Float{
        var theCurrentTime = 0.0
        var theCurrentDuration = 0.0
        if let currentTime = player?.currentTime, let duration = player?.duration {
            theCurrentTime = currentTime
            theCurrentDuration = duration
        }
        return Float(theCurrentTime / theCurrentDuration)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag == true {
            nextSong(songFinishedPlaying: true)
        }
    }
}
