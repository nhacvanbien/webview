package com.example.musicplayer

import android.app.Notification
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.drawable.BitmapDrawable
import android.net.Uri
import android.os.Binder
import android.os.IBinder
import android.util.Log
import androidx.core.app.NotificationCompat
import com.google.android.exoplayer2.C
import com.google.android.exoplayer2.ExoPlayer
import com.google.android.exoplayer2.MediaItem
import com.google.android.exoplayer2.Player
import com.google.android.exoplayer2.audio.AudioAttributes
import com.google.android.exoplayer2.ui.PlayerNotificationManager
import com.google.android.exoplayer2.util.NotificationUtil.IMPORTANCE_LOW

class PlayerService : Service() {
    private val serviceBinder: IBinder = ServiceBinder()

    var exoPlayer: ExoPlayer? = null
    private lateinit var notificationManager: PlayerNotificationManager

    override fun onCreate() {
        super.onCreate()

        //assign variables
        exoPlayer = ExoPlayer.Builder(applicationContext).build()

        //Audio focus attributes
        val audioAttributes = AudioAttributes.Builder()
            .setUsage(C.USAGE_MEDIA)
            .setContentType(C.AUDIO_CONTENT_TYPE_MUSIC)
            .build()
        exoPlayer?.setAudioAttributes(audioAttributes, true)

        //notification manager
        val channelId = "Music channel"
        val notificationId = 111
        notificationManager =
            PlayerNotificationManager.Builder(this, notificationId, channelId)
                .setMediaDescriptionAdapter(descriptionAdapter)
                .setChannelImportance(IMPORTANCE_LOW)
                .setSmallIconResourceId(com.google.android.exoplayer2.ui.R.drawable.exo_notification_small_icon)
                .setChannelDescriptionResourceId(R.string.app_name)
                .setNextActionIconResourceId(com.google.android.exoplayer2.ui.R.drawable.exo_ic_skip_next)
                .setPauseActionIconResourceId(com.google.android.exoplayer2.ui.R.drawable.exo_icon_pause)
                .setPlayActionIconResourceId(com.google.android.exoplayer2.ui.R.drawable.exo_icon_play)
                .setChannelNameResourceId(R.string.app_name)

                .setNotificationListener(object : PlayerNotificationManager.NotificationListener {
                    override fun onNotificationCancelled(
                        notificationId: Int,
                        dismissedByUser: Boolean
                    ) {
                        super.onNotificationCancelled(notificationId, dismissedByUser)
                        stopSelf()
                    }

                    override fun onNotificationPosted(
                        notificationId: Int,
                        notification: Notification,
                        ongoing: Boolean
                    ) {
                        super.onNotificationPosted(notificationId, notification, ongoing)
                        if (ongoing) {
                            startForeground(notificationId, notification);
                        } else {
                            stopForeground(false)
                        }
                    }
                })
                .build()

        notificationManager.run {
            setPlayer(exoPlayer)
            setPriority(NotificationCompat.PRIORITY_MAX)
            setUseRewindAction(false)
            setUseFastForwardAction(false)
        }
    }

    private val descriptionAdapter = object : PlayerNotificationManager.MediaDescriptionAdapter {
        override fun getCurrentContentTitle(player: Player): CharSequence {
            return player.currentMediaItem?.mediaMetadata?.title ?: "Title"
        }

        override fun createCurrentContentIntent(player: Player): PendingIntent? {
            //intent to open the app when clicked
            return null
        }

        override fun getCurrentContentText(player: Player): CharSequence? {
            return null
        }

        override fun getCurrentLargeIcon(
            player: Player,
            callback: PlayerNotificationManager.BitmapCallback
        ): Bitmap? {
            return null
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        play()
        return START_STICKY
    }

    override fun onBind(intent: Intent): IBinder {
        return serviceBinder
    }

    fun play() {
        val mediaItems = listOf(
            MediaItem.fromUri(Uri.parse("asset:///sample1.mp3")),
            MediaItem.fromUri(Uri.parse("asset:///sample.mp3"))
        )
        exoPlayer?.setMediaItems(mediaItems, 0, 0)
        exoPlayer?.prepare()
        exoPlayer?.play()
    }

    override fun onDestroy() {
        exoPlayer?.release()
        notificationManager.setPlayer(null)
        exoPlayer = null
    }

    inner class ServiceBinder : Binder() {
        fun getService(): PlayerService {
            return this@PlayerService
        }
    }
}
