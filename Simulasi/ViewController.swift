//
//  ViewController.swift
//  Simulasi
//
//  Created by Stefani Kurnia Permata Dewi on 13/10/19.
//  Copyright © 2019 Stefani Kurnia Permata Dewi. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyWave
import CoreHaptics

class ViewController: UIViewController{

    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var singerName: UILabel!
    @IBOutlet weak var playedTime: UILabel!
    @IBOutlet weak var sliderProgress: UISlider!
    @IBOutlet weak var waveView: SwiftyWaveView!
    @IBOutlet weak var lyrics: UILabel!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var vibrateSwitch: UISwitch!
    @IBOutlet weak var vibrateSwitchLabel: UILabel!
    @IBOutlet weak var lyricsSwitch: UISwitch!
    @IBOutlet weak var lyricsSwitchLabel: UILabel!
    
    var audioPlayer:AVAudioPlayer?
    var isPlaying = false
    var timer:Timer!
    
    // A haptic engine manages the connection to the haptic server.
    var engine: CHHapticEngine!
    
    // Maintain a variable to check for Core Haptics compatibility on device.
    lazy var supportsHaptics: Bool = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.supportsHaptics
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        trackTitle.text = "Laskar Pelangi"
        singerName.text = "Nidji"
        audioPlayer = initializePlayer()
        toggleSwitch()
        createEngine()
    }
    
    func toggleSwitch(){
        lyricsSwitch.addTarget(self, action: #selector(lyricsChange), for: .valueChanged)
        vibrateSwitch.addTarget(self, action: #selector(vibrateChange), for: .valueChanged)
    }
    
    private func initializePlayer() -> AVAudioPlayer?
    {
        guard let path = Bundle.main.path(forResource: "Laskar Pelangi Trim", ofType: "mp3")
        else {
            return nil
        }

        return try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
    }

    
    @IBAction func playButton(_ sender: Any)
    {
        if audioPlayer?.currentTime == 0.0{
            audioPlayer?.pause()
            playButtonOutlet.setImage(#imageLiteral(resourceName: "play"), for: .normal)
            isPlaying = false
            waveView.stop()
        }
        
        if isPlaying
            {
                audioPlayer?.pause()
                playButtonOutlet.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                isPlaying = false
                waveView.stop()
                engine.stop(completionHandler: .none)
                
            } else
            {
                isPlaying = true
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime),
                userInfo: nil, repeats: true)
                sliderProgress.value = 0.0
                sliderProgress.maximumValue = Float(audioPlayer!.duration)
                playButtonOutlet.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
                audioPlayer?.play()
                timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
                waveView.start()
                playHapticsFile(named: "AHAP/Laskar Pelangi")
        }
    }
    
    @objc func updateTime(){
        let currentTime = Int(audioPlayer!.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        playedTime.text = String(format: "%02d:%02d", minutes,seconds) as String
        
        //lyrics
        switch (minutes, seconds) {
            case (0,1): lyrics.text = "Lyric's here!"
            case (0,3...5): lyrics.text = "Intro"
            case (0,7...8): lyrics.text = "*"
            case (0,9): lyrics.text = "* *"
            case (0,10): lyrics.text = "* * *"
            case (0,11...15): lyrics.text = "Mimpi adalah kunci"
            case (0,16...20): lyrics.text = "Untuk kita menaklukkan dunia"
            case (0,21...26): lyrics.text = "Berlarilah tanpa lelah"
            case (0,27...32): lyrics.text = "Sampai engkau meraihnya"
            case (0,32...36): lyrics.text = "Laskar pelangi"
            case (0,38...42): lyrics.text = "Takkan terikat waktu"
            case (0,43...47): lyrics.text = "Bebaskan mimpimu di angkasa"
            case (0,48...56): lyrics.text = "Warnai bintang di jiwa"
            case (0,57...60): lyrics.text = "Menarilah dan terus tertawa"
            case (1,0...1): lyrics.text = "Menarilah dan terus tertawa"
            case (1,2...6): lyrics.text = "Walau dunia tak seindah surga"
            case (1,7...11): lyrics.text = "Bersyukurlah pada Yang Kuasa"
            case (1,12...18): lyrics.text = "Cinta kita di dunia"
            case (1,19...22): lyrics.text = "Selamanya"
            case (1,23...30): lyrics.text = "(Instrumen piano)"
            case (1,32):
                do {
                    waveView.stop()
                playButtonOutlet.setImage(#imageLiteral(resourceName: "play"), for: .normal)
                }
        default: lyrics.text = ""
        }
    }
       
    /// - Tag: CreateEngine
       func createEngine() {
           // Create and configure a haptic engine.
           do {
               engine = try CHHapticEngine()
           } catch let error {
               print("Engine Creation Error: \(error)")
           }
           
           if engine == nil {
               print("Failed to create engine!")
           }
           
           // The stopped handler alerts you of engine stoppage due to external causes.
           engine.stoppedHandler = { reason in
               print("The engine stopped for reason: \(reason.rawValue)")
               switch reason {
               case .audioSessionInterrupt: print("Audio session interrupt")
               case .applicationSuspended: print("Application suspended")
               case .idleTimeout: print("Idle timeout")
               case .systemError: print("System error")
               case .notifyWhenFinished: print("Playback finished")
               @unknown default:
                   print("Unknown error")
               }
           }
    
           // The reset handler provides an opportunity for your app to restart the engine in case of failure.
           engine.resetHandler = {
               // Try restarting the engine.
               print("The engine reset --> Restarting now!")
               do {
                   try self.engine.start()
               } catch {
                   print("Failed to restart the engine: \(error)")
               }
           }
       }
    
    /// - Tag: PlayAHAP
    func playHapticsFile(named filename: String) {
        
        // If the device doesn't support Core Haptics, abort.
        if !supportsHaptics {
            return
        }
        
        // Express the path to the AHAP file before attempting to load it.
        guard let path = Bundle.main.path(forResource: filename, ofType: "ahap") else {
            return
        }
        
        do {
            // Start the engine in case it's idle.
            try engine.start()
            
            // Tell the engine to play a pattern.
            try engine.playPattern(from: URL(fileURLWithPath: path))
            
        } catch { // Engine startup errors
            print("An error occured playing \(filename): \(error).")
        }
    }
    
    @objc func updateSlider() {
        guard let player = audioPlayer else { return }
        sliderProgress.value = Float(player.currentTime)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
    audioPlayer?.currentTime   = Float64(sliderProgress.value)
    }
    

//    @IBAction func stopButton(_ sender: Any)
//    {
//        audioPlayer?.stop()
//        audioPlayer?.currentTime = 0
//        isPlaying = false
//        waveView.stop()
//
//    }
    
    @objc func lyricsChange(switchState: UISwitch){
        if switchState.isOn{
            lyricsSwitchLabel.text = "lyric is ON"
            lyrics.isHidden = false
        }else{
            lyricsSwitchLabel.text = "lyric is OFF"
            lyrics.isHidden = true
        }
    }
    
    @objc func vibrateChange(switchState: UISwitch){
        if switchState.isOn{
            vibrateSwitchLabel.text = "Vibrate is ON"
            if audioPlayer?.isPlaying == true{
                playHapticsFile(named: "AHAP/Laskar Pelangi")
            }
        }else{
            vibrateSwitchLabel.text = "Vibrate is OFF"
            engine.stop(completionHandler: .none)
        }
    }
}

