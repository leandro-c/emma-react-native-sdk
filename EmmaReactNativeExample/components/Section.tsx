import React from 'react';
import { StyleSheet, Text, useColorScheme, View } from 'react-native';

import Colors from './Colors';

interface Props {
  title: string;
  subtitle?: string;
}

export const Section: React.FC<Props> = ({ children, title, subtitle }) => {
  const isDarkMode = useColorScheme() === 'dark';
  const styles = getStyles(isDarkMode);
  return (
    <View style={styles.sectionContainer}>
      <View style={styles.titleContainer}>
        <Text style={styles.sectionTitle}>{title}</Text>
        <Text style={styles.sectionSubtitle}>{subtitle}</Text>
      </View>
      <Text style={styles.sectionDescription}>{children}</Text>
    </View>
  );
};

const getStyles = (isDarkMode: boolean) =>
  StyleSheet.create({
    sectionContainer: {
      marginTop: 32,
      paddingHorizontal: 10,
    },
    titleContainer: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      alignItems: 'baseline',
    },
    sectionTitle: {
      fontSize: 24,
      fontWeight: '600',
      color: isDarkMode ? Colors.white : Colors.black,
    },
    sectionSubtitle: {
      color: isDarkMode ? Colors.light : Colors.dark,
    },
    sectionDescription: {
      marginTop: 8,
      marginBottom: 8,
      fontSize: 18,
      fontWeight: '400',
      flexDirection: 'column',
      color: isDarkMode ? Colors.light : Colors.dark,
    },
  });

export default Section;
