# PhotoAlbumThumbnail
Show albums thumbnail image in TableView

![album](https://user-images.githubusercontent.com/28393778/43506642-a14ac074-95a5-11e8-8dc8-3c4435579aea.gif)


* If you want to show smart album in Tableview<br /> 
  use<br /> 
  albums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)<br /> 

* want to show user created album<br /> 
  use<br /> 
  albums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)<br /> 
  
 
the function blurViewValue<br /> 
referenced here https://github.com/Ramotion/preview-transition.git<br /> 
