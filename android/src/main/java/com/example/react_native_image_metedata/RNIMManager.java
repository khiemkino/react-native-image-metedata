package com.example.react_native_image_metedata;

import android.media.ExifInterface;
import android.util.Log;

import com.drew.imaging.ImageMetadataReader;

import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.Tag;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.JavaScriptModule;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.uimanager.ViewManager;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;


/**
 * Created by luckyxmobile on 2017/8/23.
 */

public class RNIMManager extends ReactContextBaseJavaModule {
    private static final String MOUDLE_NAME = "ReactNativeImageMeteData";
    public RNIMManager(ReactApplicationContext reactContext) {
        super(reactContext);
    }
    @Override
    public String getName() {
        return MOUDLE_NAME;
    }

    @ReactMethod
    public void readMeteData(String imagePath,final Promise promise) {
        try {
            File imageFile = new File(imagePath);
            Metadata metadata = ImageMetadataReader.readMetadata(imageFile);
            WritableMap meteDataMap = Arguments.createMap();
            for (Directory directory : metadata.getDirectories()) {
                WritableMap directoryMap = Arguments.createMap();
                for (Tag tag : directory.getTags()) {
                    directoryMap.putString(tag.getTagName(),tag.toString());
                }
                meteDataMap.putMap(directory.getName(),directoryMap);
            }
            promise.resolve(meteDataMap);
        } catch (Exception e) {
            promise.reject(e.toString());
        }
    }
    @ReactMethod
    public void editMeteDataPhotoForAndroid(String imagPath,ReadableMap metedataRM,final Promise promise){
        try{
            ExifInterface exifInterface = new ExifInterface(imagPath);
            HashMap<String,Object> metedataHM= metedataRM.toHashMap();
            Iterator iter = metedataHM.entrySet().iterator();
            while(iter.hasNext()){
                Map.Entry entry = (Map.Entry) iter.next();
                exifInterface.setAttribute(entry.getKey().toString(),entry.getValue().toString());
            }
            exifInterface.saveAttributes();
        } catch(Exception e){
            promise.reject(e.toString());
        }
    }
}
