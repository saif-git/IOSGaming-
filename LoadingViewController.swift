//
//  LoadingViewController.swift
//  GameStart
//
//  Created by user on 29/07/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    // MARK : - OUTLETS
    @IBOutlet weak var txtlabel: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var bgImages: UIImageView!
    // MARK : - Functions
    var index: Int = 0 {
        didSet {
            btn.isEnabled = index < moviesArray.count - 1 ? true : false
            let title = index < moviesArray.count - 1 ? "next" : "Done"
            btn.setTitle(title, for: .normal)
            let data = moviesArray[index]
            // transition of image
            UIView.transition(with: bgImages,
                              duration: 0.75,
                              options: .transitionCrossDissolve,
                              animations: {
                                //every UI update should be main thread
                                DispatchQueue.main.async {
                                    self.bgImages.image = data.Image ?? UIImage()
                                    self.txtlabel.text = data.description
                                    self.pageControl.currentPage = self.index
                                } },
                              completion: nil)

        }
    }
    var moviesArray : [(Image:UIImage?,description: String)] = []
    
    let shazam = (Image:UIImage(named: "shazam"),description: "whhdkjhjkdfhjkjkewfjhwehjfjhewgggggrg4")
    let alita = (Image:UIImage(named: "Alita"),description: "whhdkjhjkdfhjkjkewfjhwehjfjhewgggggrg4")
    let dumbo = (Image:UIImage(named: "dumbo"),description: "whhdkjhjkdfhjkjkewfjhwehjfjhewgggggrg4")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func NextClick(_ sender: Any) {
        index = index+1
    }
    
    // MARK: - Custom Functions
    func initView() {
        moviesArray.append(shazam)
        moviesArray.append(alita)
        moviesArray.append(dumbo)
        let data = moviesArray[index]
        bgImages.image = data.Image ?? UIImage()
        txtlabel.text = data.description
        pageControl.currentPage = index
        
    }

}
