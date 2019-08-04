# react-native-image-metedata
It is can help you read and edit a metedata of the photo.
## Usage(iOS)
### Install
First you need to install react-native-image-metedata:
```
npm install react-native-image-metedata --save
```
### Adding automatically with react-native link
At the command line, in your project folder, type:
```
react-native link react-native-image-metedata
```
No need to worry about manually adding the library to your project.
### Adding Manually in XCode
In XCode, in the project navigator, right click Libraries ➜ Add Files to [your project's name] Go to node_modules ➜ react-native-iamge-metedata and add the .xcodeproj file  
In XCode, in the project navigator, select your project. Add the libReactNativeImageMeteDAta.a to your project's Build Phases ➜ Link Binary With Libraries. 

## Usage(Android)
### Install
First you need to install react-native-image-metedata:
```
npm install react-native-image-metedata --save
```
### Adding automatically with react-native link
At the command line, in your project folder, type:
```
react-native link react-native-image-metedata
```
## Example
### Get Image Metdata
You can get the metedata of photo by path with the following codes
```js
import RNIM from 'react-native-image-metedata'
RNIM.readMeteData('your absoult path').then((metedataInfo)=>{
    ...
})
```
And you need pay attention to the difference about JSON format from different platform.You can log your photo's metedata.
### Edit Image Metedata
#### iOS
```js
RNIM.readMeteData(`path`).then((metedataInfo)=>{
  metedataInfo['{TIFF}'].Artist = "Jobs"
  RNIM.editMeteDataPhotoForiOS(`path`,json).then((metedataInfo)=>{
        ...
  })
}
```
#### Android
You must set attributes by [Android ExifInterface](https://github.com/SleetShang/react-native-image-metedata/wiki/Android-Exif-Attribute)
```js
RNIM.readMeteData(`path`).then((metedataInfo)=>{
  let MeteData = {
    "Artist" : "Jobs",
    ...
  }
  RNIM.editMeteDataPhotoForAndroid(`path`,json).then((metedataInfo)=>{
        ...
  })
}
```

