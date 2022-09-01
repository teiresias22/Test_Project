//
//  ViewController.swift
//  AVAudioTest
//
//  Created by Joonhwan Jeon on 2022/09/01.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate{
    var audioPlayer = AVAudioPlayer()
    var audioFile: URL!
    let maxVolume: Float = 10.0
    var progressTimer: Timer!
    
    let timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)
    
    @IBOutlet weak var audioTitle: UILabel!
    @IBOutlet weak var progressPlay: UIProgressView!
    @IBOutlet weak var currentTimeText: UILabel!
    @IBOutlet weak var endTimeText: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var volumeSet: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioFile = Bundle.main.url(forResource: "Pengsoo", withExtension: "mp3")
        
        initplay()
    }
    
    func initplay(){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        volumeSet.maximumValue = maxVolume
        volumeSet.value = 3.0
        progressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = volumeSet.value
        
        endTimeText.text = convertNSTimeInterval12String(audioPlayer.duration)
        currentTimeText.text = convertNSTimeInterval12String(0)
        setPlayButtons(true, pause: false, stop: false)
    }
    
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool){
        playBtn.isEnabled = play
        pauseBtn.isEnabled = pause
        stopBtn.isEnabled = stop
    }
    
    func convertNSTimeInterval12String(_ time:TimeInterval) -> String {
        let min = Int(time/60)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioTitle.text = "팽수로 하겠습니다"
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        currentTimeText.text = convertNSTimeInterval12String(0)
        setPlayButtons(true, pause: false, stop: false)
        progressTimer.invalidate() // 타이머 무효화
    }
    
    @IBAction func slideVolume(_ sender: UISlider) {
        audioPlayer.volume = volumeSet.value
    }
    
    @objc func updatePlayTime(){
        currentTimeText.text = convertNSTimeInterval12String(audioPlayer.currentTime)
        progressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    //재생이 종료되었을때 호출함
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate() // 타이머 무효화
        setPlayButtons(true, pause: false, stop: false)
    }
}
