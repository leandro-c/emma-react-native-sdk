import React from 'react';
import { ImageBackground, StyleSheet, Text } from 'react-native';

import Colors from './Colors';

const Header = () => {
  return (
    <ImageBackground
      accessibilityRole={'image'}
      source={require('../assets/images/logo.png')}
      style={styles.background}
      imageStyle={styles.logo}
    >
      <Text style={styles.text}>Welcome to EMMA</Text>
    </ImageBackground>
  );
};

const styles = StyleSheet.create({
  background: {
    paddingBottom: 40,
    paddingTop: 96,
    paddingHorizontal: 32,
    backgroundColor: Colors.primary,
  },
  logo: {
    opacity: 0.2,
    overflow: 'visible',
    resizeMode: 'center',
  },
  text: {
    fontSize: 40,
    fontWeight: '600',
    textAlign: 'center',
    color: Colors.white,
  },
});

export default Header;
