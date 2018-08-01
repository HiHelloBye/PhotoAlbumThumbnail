import Photos
import Foundation

class PhotoManager {
    
    let fetchOptions:PHFetchOptions = PHFetchOptions()
    
    // MARK: getThumbnail
    func getAssetThumbnail(asset: PHAsset, width:Int, height:Int) ->UIImage {
        
        let manager   = PHImageManager.default()
        let option    = PHImageRequestOptions()
        var thumbnail = UIImage()
        
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: width, height: height), contentMode: .aspectFit, options: option, resultHandler: {(result, info) -> Void in
            thumbnail = result!
        })
        return thumbnail
    }
    //end_of_getThumbnail
    
    
    //MARK: getAllPhotos
    
    func getAllPhotos() -> [PHAsset] {
        
        let imageManager   = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        var assets:[PHAsset] = [PHAsset()]
        
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        if let fetchResult:PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
            if fetchResult.count > 0 {
                for i in 0 ..< fetchResult.count {
                    imageManager.requestImage(for: fetchResult.object(at: i), targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: {
                        image, _ in
                        assets.append(fetchResult.object(at: i))
                    })
                }
                return assets
            }
            else {
                print("You have no images")
            }
        }
        
        return [PHAsset]()
    }
    
    //end_of_getAllPhotos
}
