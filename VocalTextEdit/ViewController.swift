//
//  ViewController.swift
//  VocalTextEdit
//
//  Created by Jason Hilimire on 3/30/17.
//  Copyright © 2017 Peanut Apps. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSSpeechSynthesizerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        speechSynthesizer.delegate = self
        speakButton.isEnabled = true
        stopButton.isEnabled = false
        progressIndicator.isHidden = true
    }
    let speechSynthesizer = NSSpeechSynthesizer()
    @IBOutlet var textView: NSTextView!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var progressIndicator: NSProgressIndicator!
    var contents: String? {
        get {
            return textView.string
        }
        set {
            textView.string = newValue
        }
    }
    @IBAction func speakButtonClicked(sender: NSButton) {
        if let contents = textView.string, !contents.isEmpty {
            speechSynthesizer.startSpeaking(contents)
        } else {
            speechSynthesizer.startSpeaking("The document is empty.")
        }
        speakButton.isEnabled = false
        stopButton.isEnabled = true
        progressIndicator.isHidden = false
    }
    @IBAction func stopButtonClicked(sender: NSButton) {
        speechSynthesizer.stopSpeaking()
    }
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        speakButton.isEnabled = true
        stopButton.isEnabled = false
        progressIndicator.isHidden = true
    }
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, willSpeakWord characterRange: NSRange, of string: String) {
        progressIndicator.doubleValue = (Double(characterRange.location + characterRange.length) / Double(string.characters.count)) * 100
    }
}
