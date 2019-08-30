//
//  CollectionViewController.swift
//  GameStart
//
//  Created by user on 04/08/2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    var item = ["1","2","3","4","5","6","7","8","9"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colCell", for: indexPath) as! CollectionViewCell2
        
        cell.mylabel.text = item[indexPath.item]
        cell.backgroundColor = UIColor.yellow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
