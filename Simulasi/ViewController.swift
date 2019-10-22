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
        guard let path = Bundle.main.path(forResource: "Laskar Pelangi", ofType: "mp3")
        else {
            return nil
        }

        return try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
    }

    
    @IBAction func playButton(_ sender: Any)
    {
        if isPlaying
            {
                audioPlayer?.pause()
                isPlaying = false
                waveView.stop()
            } else
            {
                isPlaying = true
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime),
                userInfo: nil, repeats: true)
                sliderProgress.value = 0.0
                sliderProgress.maximumValue = Float(audioPlayer!.duration)
                
                audioPlayer?.play()
                timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
                waveView.start()
                playHapticsFile(named: "AHAP/Laskar Pelangi")
        }
    }
    
    @objc func updateTime()
    {
        let currentTime = Int(audioPlayer!.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        playedTime.text = String(format: "%02d:%02d", minutes,seconds) as String
        
        //lyrics
            if seconds >= 0 && seconds <= 9 {
                lyrics.text = ""
            }
            if seconds >= 10 && seconds <= 15
            {
                lyrics.text = "Mimpi adalah kunci"
            }
            if seconds >= 16 && seconds <= 20
            {
                lyrics.text = "Untuk kita menaklukkan dunia"
            }
            if seconds >= 21 && seconds <= 25
            {
                lyrics.text = "Berlarilah tanpa lelah"
            }
            if seconds >= 26 && seconds <= 30
            {
                lyrics.text = "Sampai engkau meraihnya"
            }
            if seconds >= 31 && seconds <= 36
            {
                lyrics.text = "Laskar pelangi"
            }
            if seconds >= 37 && seconds <= 42
            {
                lyrics.text = "Takkan terikat waktu"
            }
            if seconds >= 43 && seconds <= 47
            {
                lyrics.text = "Bebaskan mimpimu di angkasa"
            }
            if seconds >= 48 && seconds <= 54
            {
                lyrics.text = "Warnai bintang di jiwa"
            }
            if seconds >= 56 && seconds <= 59
            {
                lyrics.text = "Menarilah dan terus tertawa"
            }
            if minutes >= 1, seconds >= 1 && minutes <= 1, seconds <= 6
            {
                lyrics.text = "Walau dunia tak seindah surga"
            }
            if minutes >= 1, seconds >= 7 && minutes <= 1, seconds <= 11
            {
                lyrics.text = "Bersyukurlah pada Yang Kuasa"
            }
            if minutes >= 1, seconds >= 12 && minutes <= 1, seconds <= 17
            {
                lyrics.text = "Cinta kita di dunia"
            }
            if minutes >= 1, seconds >= 18 && minutes <= 1, seconds <= 18
            {
                lyrics.text = ""
            }
            if minutes >= 1, seconds >= 19 && minutes <= 1, seconds <= 23
            {
                lyrics.text = "Selamanya"
            }
            if minutes >= 1, seconds >= 24 && minutes <= 1, seconds <= 30
            {
                lyrics.text = ""
            }
            if minutes >= 1, seconds >= 31 && minutes <= 1, seconds <= 35
            {
                lyrics.text = "Cinta kepada hidup"
            }
            if minutes >= 1, seconds >= 36 && minutes <= 1, seconds <= 40
            {
                lyrics.text = "Memberikan senyuman abadi"
            }
            if minutes >= 1, seconds >= 41 && minutes <= 1, seconds <= 45
            {
                lyrics.text = "Walau hidup kadang tak adil"
            }
            if minutes >= 1, seconds >= 46 && minutes <= 1, seconds <= 53
            {
                lyrics.text = "Tapi cinta lengkapi kita"
            }
            if minutes >= 1, seconds >= 54 && minutes <= 1, seconds <= 60
            {
                lyrics.text = "ooo…"
            }
            if minutes >= 2, seconds >= 0 && minutes <= 2, seconds <= 4
            {
                lyrics.text = "ooo…"
            }
            if minutes >= 2, seconds >= 5 && minutes <= 2, seconds <= 9
            {
                lyrics.text = "Laskar pelangi"
            }
            if minutes >= 2, seconds >= 10 && minutes <= 2, seconds <= 15
            {
                lyrics.text = "Takkan terikat waktu"
            }
            if minutes >= 2, seconds >= 16 && minutes <= 2, seconds <= 20
            {
                lyrics.text = "Jangan berhenti mewarnai"
            }
            if minutes >= 2, seconds >= 21 && minutes <= 2, seconds <= 29
            {
                lyrics.text = "Jutaan mimpi di bumi"
            }
            if minutes >= 2, seconds >= 30 && minutes <= 2, seconds <= 34
            {
                lyrics.text = "O! menarilah dan terus tertawa"
            }
            if minutes >= 2, seconds >= 35 && minutes <= 2, seconds <= 39
            {
                lyrics.text = "Walau dunia tak seindah surga"
            }
            if minutes >= 2, seconds >= 40 && minutes <= 2, seconds <= 45
            {
                lyrics.text = "Bersyukurlah pada Yang Kuasa"
            }
            if minutes >= 2, seconds >= 46 && minutes <= 2, seconds <= 51
            {
                lyrics.text = "Cinta kita di dunia"
            }
            if minutes >= 2, seconds >= 52 && minutes <= 2, seconds <= 53
            {
                lyrics.text = ""
            }
            if minutes >= 2, seconds >= 54 && minutes <= 2, seconds <= 58
            {
                lyrics.text = "Menarilah dan terus tertawa"
            }
            if minutes >= 2, seconds >= 59 && minutes <= 3, seconds <= 4
            {
                lyrics.text = "Walau dunia tak seindah surga"
            }
            if minutes >= 3, seconds >= 5 && minutes <= 3, seconds <= 9
            {
                lyrics.text = "Bersyukurlah pada Yang Kuasa"
            }
            if minutes >= 3, seconds >= 10 && minutes <= 3, seconds <= 16
            {
                lyrics.text = "Cinta kita di dunia"
            }
            if minutes >= 3, seconds >= 17 && minutes <= 3, seconds <= 21
            {
                lyrics.text = "Selamanya"
            }
            if minutes >= 2, seconds >= 22 && minutes <= 3, seconds <= 27
            {
                lyrics.text = ""
            }
            if minutes >= 3, seconds >= 28 && minutes <= 3, seconds <= 32
            {
                lyrics.text = "Laskar pelangi"
            }
            if minutes >= 3, seconds >= 33 && minutes <= 3, seconds <= 39
            {
                lyrics.text = "Takkan terikat waktu"
            }
            if minutes >= 3, seconds >= 40 && minutes <= 3, seconds <= 45
            {
                lyrics.text = ""
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
            lyricsSwitchLabel.text = "Lyrics is ON"
            lyrics.isHidden = false
        }else{
            lyricsSwitchLabel.text = "Lyrics is OFF"
            lyrics.isHidden = true
        }
    }
    
    @objc func vibrateChange(switchState: UISwitch){
        if switchState.isOn{
            vibrateSwitchLabel.text = "Vibrate is ON"
        }else{
            vibrateSwitchLabel.text = "Vibrate is OFF"
        }
    }
}

