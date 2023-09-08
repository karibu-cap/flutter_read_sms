package com.karibu_capital.flutter_read_sms

import android.app.Activity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.provider.Telephony
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterReadSmsPlugin */
class FlutterReadSmsPlugin: FlutterPlugin, EventChannel.StreamHandler, BroadcastReceiver(), ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity

  private var channel : EventChannel? = null

  private var eventSink: EventChannel.EventSink? = null
  /**
   * context object to get the current context and register
   * the broadcast receiver
   */
  private lateinit var context: Context
  private lateinit var activity: Activity


  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    context = flutterPluginBinding.applicationContext
    context.registerReceiver(this,IntentFilter("android.provider.Telephony.SMS_RECEIVED"))
    channel = EventChannel(flutterPluginBinding.binaryMessenger,"stream_incoming_sms")
    channel!!.setStreamHandler(this)
  }

  override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
    eventSink = events
  }

  override fun onCancel(arguments: Any?) {
    eventSink = null
  }

  @RequiresApi(Build.VERSION_CODES.KITKAT)
  override fun onReceive(context: Context, intent: Intent) {
    if (intent.action == Telephony.Sms.Intents.SMS_RECEIVED_ACTION) {
      val messages = Telephony.Sms.Intents.getMessagesFromIntent(intent)
      val sb = StringBuilder() // StringBuilder to concatenate message bodies.
      val response = HashMap<String, String>()

      for (message in messages) {
        val sender = message.displayOriginatingAddress
        val body = message.displayMessageBody
        val timestamp = message.timestampMillis

        sb.append(body) // Append the body to the StringBuilder.
        response.apply {
          put("sender",sender)
          put("timeReceived",timestamp.toString())
        }
        Log.d("SMS", "Sender: $sender, Body: $body, Timestamp: $timestamp")
      }

      val concatenatedBody = sb.toString() // Get the concatenated body.
      response.apply {
        put("body",concatenatedBody)
      }
      Log.d("SMS", "Concatenated Body: $concatenatedBody")
      eventSink?.success(response)
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = null
    eventSink = null
  }

  override fun onAttachedToActivity(p0: ActivityPluginBinding) {
    activity = p0.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
  }
}
