//
//  ExtensionImageView.swift
//  LBC_Test
//
//  Created by Antoine Antoniol on 21/04/2021.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()


extension UIImageView {

    //  MARK: - Extension UIImageView

        func loadImageUsingCacheWithUrlString(_ urlString: String) {
            self.image = nil
            if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
                self.image = cachedImage
                return
            }
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error ?? "")
                    return
                }
                DispatchQueue.main.async(execute: {
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                        self.image = downloadedImage
                    }
                })
            }).resume()
        }
    
    func setImageView(image:UIImageView,contentMode:UIView.ContentMode,clips:Bool,name:String){
        image.contentMode = contentMode
        image.clipsToBounds = clips
        image.image = UIImage(named:name)
    }
}
