import UIKit

class ImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        
        self.blurViewValue(value: 5)
        
        let overlayView = UIView(frame: self.bounds)
        overlayView.backgroundColor = .black
        overlayView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlayView.alpha = 0.4
        
        self.addSubview(overlayView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}


extension UIImageView {
    
    func blurViewValue(value: CGFloat) {
        guard let image = self.image,
            let blurFilter = CIFilter(name: "CIGaussianBlur"),
            let imageToBlur = CIImage(image: image)
            else {
                return
        }
        
        blurFilter.setValue(value, forKey: kCIInputRadiusKey)
        blurFilter.setValue(imageToBlur, forKey: "inputImage")
        
        let resultImage = blurFilter.value(forKey: "outputImage") as! CIImage
        var blurredImage = UIImage(ciImage: resultImage)
        let croppedImage:CIImage = resultImage.cropped(to: CGRect(x: 0, y: 0, width: imageToBlur.extent.size.width, height: imageToBlur.extent.size.height))
        
        blurredImage = UIImage(ciImage: croppedImage)
        self.image = blurredImage
    }
}
