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

class ViewController: UIViewController{

    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var singerName: UILabel!
    @IBOutlet weak var playedTime: UILabel!
    @IBOutlet weak var sliderProgress: UISlider!
    @IBOutlet weak var waveView: SwiftyWaveView!
    @IBOutlet weak var lyrics: UILabel!
    
    var audioPlayer:AVAudioPlayer?
    var isPlaying = false
    var timer:Timer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        trackTitle.text = "Laskar Pelangi"
        singerName.text = "Nidji"
        audioPlayer = initializePlayer()
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
                audioPlayer?.play()
                isPlaying = true
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime),
                userInfo: nil, repeats: true)
                
                sliderProgress.value = 0.0
                sliderProgress.maximumValue = Float(audioPlayer!.duration)
                audioPlayer?.play()
                timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
                waveView.start()
                
        }
    }
    
    @objc func updateTime()
    {
        let currentTime = Int(audioPlayer!.currentTime)
        let minutes = currentTime/60
        let seconds = currentTime - minutes * 60
        playedTime.text = String(format: "%02d:%02d", minutes,seconds) as String
        
        //lyrics
            if seconds >= 10 && seconds <= 15
            {
                lyrics.text = "Mimpi adalah kunci"
            }
            if seconds >= 16 && seconds <= 20
            {
                lyrics.text = "untuk kita menaklukkan dunia"
            }
            if seconds >= 21 && seconds <= 25
            {
                lyrics.text = "berlarilah tanpa lelah"
            }
            if seconds >= 26 && seconds <= 30
            {
                lyrics.text = "sampai engkau meraihnya"
            }
            if seconds >= 31 && seconds <= 36
            {
                lyrics.text = "laskar pelangi"
            }
            if seconds >= 37 && seconds <= 42
            {
                lyrics.text = "takkan terikat waktu"
            }
            if seconds >= 43 && seconds <= 47
            {
                lyrics.text = "bebaskan mimpimu di angkasa"
            }
            if seconds >= 48 && seconds <= 54
            {
                lyrics.text = "warnai bintang di jiwa"
            }
            if seconds >= 56 && seconds <= 59
            {
                lyrics.text = "menarilah dan terus tertawa"
            }
            if minutes >= 1, seconds >= 1 && minutes <= 1, seconds <= 6
            {
                lyrics.text = "walau dunia tak seindah surga"
            }
            if minutes >= 1, seconds >= 7 && minutes <= 1, seconds <= 11
            {
                lyrics.text = "bersyukurlah pada Yang Kuasa"
            }
            if minutes >= 1, seconds >= 12 && minutes <= 1, seconds <= 17
            {
                lyrics.text = "cinta kita di dunia..."
            }
            if minutes >= 1, seconds >= 18 && minutes <= 1, seconds <= 18
            {
                lyrics.text = ""
            }
            if minutes >= 1, seconds >= 19 && minutes <= 1, seconds <= 23
            {
                lyrics.text = "selamanya"
            }
            if minutes >= 1, seconds >= 24 && minutes <= 1, seconds <= 30
            {
                lyrics.text = ""
            }
            if minutes >= 1, seconds >= 31 && minutes <= 1, seconds <= 35
            {
                lyrics.text = "cinta kepada hidup"
            }
            if minutes >= 1, seconds >= 36 && minutes <= 1, seconds <= 40
            {
                lyrics.text = "memberikan senyuman abadi"
            }
            if minutes >= 1, seconds >= 41 && minutes <= 1, seconds <= 45
            {
                lyrics.text = "walau hidup kadang tak adil"
            }
            if minutes >= 1, seconds >= 46 && minutes <= 1, seconds <= 53
            {
                lyrics.text = "tapi cinta lengkapi kita..."
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
                lyrics.text = "laskar pelangi"
            }
            if minutes >= 2, seconds >= 10 && minutes <= 2, seconds <= 15
            {
                lyrics.text = "takkan terikat waktu"
            }
            if minutes >= 2, seconds >= 16 && minutes <= 2, seconds <= 20
            {
                lyrics.text = "jangan berhenti mewarnai"
            }
            if minutes >= 2, seconds >= 21 && minutes <= 2, seconds <= 29
            {
                lyrics.text = "jutaan mimpi di bumi..."
            }
            if minutes >= 2, seconds >= 30 && minutes <= 2, seconds <= 34
            {
                lyrics.text = "o! menarilah dan terus tertawa"
            }
            if minutes >= 2, seconds >= 35 && minutes <= 2, seconds <= 39
            {
                lyrics.text = "walau dunia tak seindah surga"
            }
            if minutes >= 2, seconds >= 40 && minutes <= 2, seconds <= 45
            {
                lyrics.text = "bersyukurlah pada Yang Kuasa"
            }
            if minutes >= 2, seconds >= 46 && minutes <= 2, seconds <= 51
            {
                lyrics.text = "cinta kita di dunia..."
            }
            if minutes >= 2, seconds >= 52 && minutes <= 2, seconds <= 53
            {
                lyrics.text = ""
            }
            if minutes >= 2, seconds >= 54 && minutes <= 2, seconds <= 58
            {
                lyrics.text = "menarilah dan terus tertawa"
            }
            if minutes >= 2, seconds >= 59 && minutes <= 3, seconds <= 4
            {
                lyrics.text = "walau dunia tak seindah surga"
            }
            if minutes >= 3, seconds >= 5 && minutes <= 3, seconds <= 9
            {
                lyrics.text = "bersyukurlah pada Yang Kuasa"
            }
            if minutes >= 3, seconds >= 10 && minutes <= 3, seconds <= 16
            {
                lyrics.text = "cinta kita di dunia..."
            }
            if minutes >= 3, seconds >= 17 && minutes <= 3, seconds <= 21
            {
                lyrics.text = "selamanya"
            }
            if minutes >= 2, seconds >= 22 && minutes <= 3, seconds <= 27
            {
                lyrics.text = ""
            }
            if minutes >= 3, seconds >= 28 && minutes <= 3, seconds <= 32
            {
                lyrics.text = "laskar pelangi"
            }
            if minutes >= 3, seconds >= 33 && minutes <= 3, seconds <= 39
            {
                lyrics.text = "takkan terikat waktu"
            }
            if minutes >= 3, seconds >= 40 && minutes <= 3, seconds <= 45
            {
                lyrics.text = ""
            }
        }
        
    
    @objc func updateSlider() {
        guard let player = audioPlayer else { return }
        sliderProgress.value = Float(player.currentTime)
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
    audioPlayer?.currentTime   = Float64(sliderProgress.value)
    }
    

    @IBAction func stopButton(_ sender: Any)
    {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
        isPlaying = false
        waveView.stop()
           
    }
    
}

