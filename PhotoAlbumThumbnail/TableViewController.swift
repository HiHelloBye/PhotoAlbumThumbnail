import UIKit
import Photos

class TableViewController: UITableViewController {

    let photoManager = PhotoManager()

    var albums:PHFetchResult
        = PHFetchResult<PHAssetCollection>()
    
    override func awakeFromNib() {
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate   = self
        tableView.dataSource = self

    
        let photos = PHPhotoLibrary.authorizationStatus()

        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{


                    //Smart Album
                    //albums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
                    
                    //User created Album
                    self.albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                    
                } else {}
            })
        }

     
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        let collection   = albums[indexPath.row]
        let title:String = collection.localizedTitle!
        
        let assetsFetchResult = PHAsset.fetchAssets(in: collection, options: nil)
        let asset = assetsFetchResult.lastObject
        
        if asset != nil {
            cell.tableImage.image = photoManager.getAssetThumbnail(asset: asset!, width: 200, height: 200)
        }
        
        cell.tableLabel.text = title
        

        return cell
    }

}
