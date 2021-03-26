package io.emma.reactnative

import io.emma.android.interfaces.EMMABatchNativeAdInterface
import io.emma.android.interfaces.EMMANativeAdInterface
import io.emma.android.interfaces.EMMARequestListener

interface EmmaNativeAdListener: EMMARequestListener, EMMANativeAdInterface, EMMABatchNativeAdInterface {}