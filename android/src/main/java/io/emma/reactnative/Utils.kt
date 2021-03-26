package io.emma.reactnative

import android.content.Context
import android.content.pm.PackageManager
import android.content.res.Resources
import android.os.Handler
import android.os.Looper
import androidx.annotation.DrawableRes


/**
 * Created by adrian on 08/11/2020.
 * Copyright (c) 2020 EMMA Solutions SL. All rights reserved
 */

object Utils {

    fun isValidField(field: Any?): Boolean {
        field?.let {
            return if (field is String) field.isNotEmpty() else true
        }
        return false
    }

    @DrawableRes
    fun getNotificationIcon(context: Context, imageName: String): Int {
        val res: Resources = context.resources
        return res.getIdentifier(imageName, "drawable", context.packageName)
    }

    fun getAppName(context: Context): String? {
        val ai = try {
            context.packageManager.getApplicationInfo(context.packageName, 0)
        } catch (e: PackageManager.NameNotFoundException) {
            null
        }
        return if (ai != null) context.packageManager.getApplicationLabel(ai).toString() else null
    }

    fun getClassFromStr(classStr: String): Class<*>? {
         return try {
            Class.forName(classStr)
        } catch (ex: ClassNotFoundException) {
            null
        }
    }

    fun runOnMainThread(runnable: Runnable) {
        if (Looper.getMainLooper().thread === Thread.currentThread()) runnable.run() else {
            val handler = Handler(Looper.getMainLooper())
            handler.post(runnable)
        }
    }
}
