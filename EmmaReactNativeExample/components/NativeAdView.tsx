import EmmaSdk, { IN_APP_TYPE, NativeAd } from 'emma-react-native-sdk';
import React, { useEffect } from 'react';
import { Image, Linking, StyleSheet, Text, TouchableOpacity, useColorScheme, View } from 'react-native';

import Colors from './Colors';

interface Props {
  nativeAds: NativeAd[] | null;
}

const NativeAdView: React.FC<Props> = ({ nativeAds }) => {
  const nativeAd = nativeAds?.[0];
  const isDarkMode = useColorScheme() === 'dark';

  useEffect(() => {
    if (nativeAd) {
      EmmaSdk.sendInAppImpression({
        campaignId: nativeAd.id,
        type: IN_APP_TYPE.NATIVE_AD,
      });
    }
  }, [nativeAd]);

  if (!nativeAd) {
    return null;
  } else {
    const { fields } = nativeAd;
    const styles = getStyles(isDarkMode);
    const imageSource = { uri: fields['Main picture'] };

    return (
      <TouchableOpacity
        style={styles.container}
        accessibilityRole={'button'}
        onPress={() => Linking.openURL(fields.CTA)}
      >
        <Text style={styles.description}>Native Ad</Text>
        <View style={styles.nativeAd}>
          <Image style={styles.image} source={imageSource} />
          <Text style={styles.title}>{fields.Title}</Text>
          <Text style={styles.body}>{fields.Body}</Text>
        </View>
      </TouchableOpacity>
    );
  }
};

const getStyles = (isDarkMode: boolean) =>
  StyleSheet.create({
    container: {
      margin: 15,
    },
    image: {
      width: '100%',
      height: 200,
    },
    title: {
      fontSize: 14,
      fontWeight: '600',
      color: isDarkMode ? Colors.white : Colors.black,
    },
    body: {
      color: isDarkMode ? Colors.white : Colors.black,
    },
    description: {
      color: isDarkMode ? Colors.light : Colors.dark,
    },
    nativeAd: {
      flexDirection: 'column',
      alignItems: 'center',
      borderStyle: 'dashed',
      borderWidth: 1,
      borderColor: isDarkMode ? Colors.light : Colors.dark,
      padding: 5,
    },
  });

export default NativeAdView;
