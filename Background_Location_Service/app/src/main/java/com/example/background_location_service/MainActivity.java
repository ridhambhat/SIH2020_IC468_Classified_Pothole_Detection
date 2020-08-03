package com.example.background_location_service;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {


    private SensorManager sensorManager;
    private static Context ctx;
    public static final int REQUEST_ID_MULTIPLE_PERMISSIONS = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ctx = this;
        Intent intent = new Intent(ctx, background_service.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        Log.d("Service :: ", " started");
        startService(intent);
        Log.d("Permission","Asked");
        while(!checkAndRequestPermissions());
//        Log.d("Permission","Granted");
//        Intent intent = new Intent(ctx, background_service.class);
//        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
//        Log.d("Service :: ", " started");
//        startService(intent);
    }

    private  boolean checkAndRequestPermissions() {

        int permissioncoarselocation = ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION);
        int permissionfinelocation=ContextCompat.checkSelfPermission(this,Manifest.permission.ACCESS_FINE_LOCATION);

        List<String> listPermissionsNeeded = new ArrayList<>();

        if (permissionfinelocation != PackageManager.PERMISSION_GRANTED) {
            listPermissionsNeeded.add(Manifest.permission.ACCESS_FINE_LOCATION);
        }
        if ((permissioncoarselocation != PackageManager.PERMISSION_GRANTED)&&(Build.VERSION.SDK_INT>=Build.VERSION_CODES.P)) {
            listPermissionsNeeded.add(Manifest.permission.ACCESS_COARSE_LOCATION);
        }

        if (!listPermissionsNeeded.isEmpty()) {
            ActivityCompat.requestPermissions(this, listPermissionsNeeded.toArray(new String[listPermissionsNeeded.size()]),REQUEST_ID_MULTIPLE_PERMISSIONS);
            return false;
        }
        return true;
    }


}
