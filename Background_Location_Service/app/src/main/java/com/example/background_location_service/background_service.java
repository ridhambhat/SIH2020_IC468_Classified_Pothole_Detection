package com.example.background_location_service;

import android.app.Activity;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Binder;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import androidx.core.app.NotificationCompat;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationServices;

import java.io.IOException;

import android.app.Service;
import android.content.*;
import android.os.*;
import android.widget.Toast;
//
//public class background_service extends Service {
//
//    public Context context = this;
//    public Handler handler = null;
//    public static Runnable runnable = null;
//
//    @Override
//    public IBinder onBind(Intent intent) {
//        return null;
//    }
//
//    @Override
//    public void onCreate() {
//        Toast.makeText(this, "Service created!", Toast.LENGTH_LONG).show();
//        Log.d("Start Service : ","gogogog");
//
//        handler = new Handler();
//        runnable = new Runnable() {
//            public void run() {
//                Toast.makeText(context, "Service is still running", Toast.LENGTH_LONG).show();
//                handler.postDelayed(runnable, 10000);
//            }
//        };
//
//        handler.postDelayed(runnable, 15000);
//    }
//
//    @Override
//    public void onDestroy() {
//        /* IF YOU WANT THIS SERVICE KILLED WITH THE APP THEN UNCOMMENT THE FOLLOWING LINE */
//        //handler.removeCallbacks(runnable);
//        Toast.makeText(this, "Service stopped", Toast.LENGTH_LONG).show();
//    }
//
//    @Override
//    public void onStart(Intent intent, int startid) {
//        Toast.makeText(this, "Service started by user.", Toast.LENGTH_LONG).show();
//    }
//}
//

public class background_service extends Service {

    private final IBinder binder=new LocalBinder();


    public class LocalBinder extends Binder {
        public background_service getService() {
            return background_service.this;
        }
    }

    private static final int NOTIF_ID = 001;
    private static final String NOTIF_CHANNEL_ID = "personal_notifications";
    public static boolean check=false;
    public static long count=0;
    public Context myContext=this;
    private TextView projection;
    public boolean r;
    private static FusedLocationProviderClient mFusedLocationClient;
    // public static String st;



    @Override
    public  IBinder onBind(Intent intent) {
        return binder;
    }



    @Override
    public int onStartCommand(Intent intent, int flags, int startId){

        //Tasks
        startForeground();
        //LocalBroadcastManager.getInstance(this).registerReceiver(broadcastReceiver, new IntentFilter("updateToDb"));
        mFusedLocationClient = LocationServices.getFusedLocationProviderClient(this);
        Log.d("Background Service", "service started");
        myContext = this;
        Tick();
        return super.onStartCommand(intent, flags, startId);
    }

    private void startForeground() {
        Intent notificationIntent = new Intent(this, MainActivity.class);

        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0,
                notificationIntent, 0);

        createNotificationChannel();

        startForeground(NOTIF_ID, new NotificationCompat.Builder(this,
                NOTIF_CHANNEL_ID) // don't forget create a notification channel first
                .setOngoing(true)
                .setSmallIcon(R.drawable.ic_my_location_black_24dp)
                .setContentTitle(("Road Health System"))
                .setContentText("Collecting road data")
                .setContentIntent(pendingIntent)
                .build());
    }



    private void createNotificationChannel()
    {
        if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.O)
        {
            CharSequence name="Pothole Detection";
            String description="Collecting Data";
            int importance= NotificationManager.IMPORTANCE_DEFAULT;

            NotificationChannel notificationChannel = new NotificationChannel(NOTIF_CHANNEL_ID, name, importance);
            notificationChannel.setDescription(description);
            NotificationManager notificationManager= (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
            notificationManager.createNotificationChannel(notificationChannel);

        }

    }

    private BroadcastReceiver broadcastReceiver=new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Log.d("reached", "onReceive: your service add data reached");
            String type=intent.getStringExtra("type");
            String from=intent.getStringExtra("from");
            String dt=intent.getStringExtra("dt");
            String text=intent.getStringExtra("text");
            String filepath="";
            if (type=="Call")
                filepath=intent.getStringExtra("filepath");
            String method="add";
            Context ctx=getApplicationContext();
//            BackgroundTask backgroundTask=new BackgroundTask(ctx);
//            backgroundTask.execute(method,type,from,dt,text,filepath);
        }
    };

    public void Tick()
    {
        mFusedLocationClient.getLastLocation().addOnSuccessListener(location -> {
            if (location != null) {
                String lt = Double.toString(location.getLatitude());
                String ln = Double.toString(location.getLongitude());
                Log.d("LATLONG", "lt = "+lt+" ln = "+ln);

//                Intent in = new Intent("update_loc_data");
//                in.putExtra("hc", hc);
//                in.putExtra("lt", lt);
//                in.putExtra("ln", ln);
//                in.putExtra("dt", dt);

            }
        });
    }


}







