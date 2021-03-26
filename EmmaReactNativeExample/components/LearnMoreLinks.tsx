import React from 'react';
import { Linking, StyleSheet, Text, TouchableOpacity, useColorScheme, View } from 'react-native';

import Colors from './Colors';

const links = [
  {
    id: 'main',
    title: 'EMMA SDK',
    link: 'https://developer.emma.io/',
    description: 'Documentation & Support',
  },
  {
    id: 'ios',
    title: 'iOS',
    link: 'https://github.com/EMMADevelopment/eMMa-iOS-SDK',
    description: 'EMMA SDK for iOS',
  },
  {
    id: 'android',
    title: 'Android',
    link: 'https://github.com/EMMADevelopment/EMMA-Android-SDK',
    description: 'EMMA SDK for Android',
  },
  {
    id: 'cordova',
    title: 'Cordova',
    link: 'https://github.com/EMMADevelopment/Cordova-Plugin-EMMA-SDK',
    description: 'EMMA SDK for Cordova',
  },
  {
    id: 'ionic',
    title: 'Ionic',
    link: 'https://github.com/EMMADevelopment/EMMAIonicExample',
    description: 'EMMA SDK for Ionic',
  },
  {
    id: 'flutter',
    title: 'Flutter',
    link: 'https://github.com/EMMADevelopment/emma_flutter_sdk',
    description: 'EMMA SDK for Flutter',
  },
  {
    id: 'xamarin',
    title: 'Xamarin',
    link: 'https://github.com/EMMADevelopment/EMMA-Xamarin-SDK',
    description: 'EMMA SDK for Xamarin',
  },
];

const LinkList = () => {
  const isDarkMode = useColorScheme() === 'dark';
  const styles = getStyles(isDarkMode);
  return (
    <View style={styles.container}>
      {links.map(({ id, title, link, description }) => {
        return (
          <React.Fragment key={id}>
            <View style={styles.separator} />
            <TouchableOpacity
              accessibilityRole={'button'}
              onPress={() => Linking.openURL(link)}
              style={styles.linkContainer}
            >
              <Text style={styles.link}>{title}</Text>
              <Text style={styles.description}>{description}</Text>
            </TouchableOpacity>
          </React.Fragment>
        );
      })}
    </View>
  );
};

const getStyles = (isDarkMode: boolean) =>
  StyleSheet.create({
    container: {
      marginTop: 32,
      paddingHorizontal: 24,
    },
    linkContainer: {
      flexWrap: 'wrap',
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'center',
      paddingVertical: 8,
    },
    link: {
      flex: 2,
      fontSize: 18,
      fontWeight: '400',
      color: isDarkMode ? Colors.primaryBright : Colors.primary,
    },
    description: {
      flex: 3,
      paddingVertical: 16,
      fontWeight: '400',
      fontSize: 18,
      color: isDarkMode ? Colors.light : Colors.dark,
    },
    separator: {
      backgroundColor: isDarkMode ? Colors.dark : Colors.light,
      height: 1,
    },
  });

export default LinkList;
