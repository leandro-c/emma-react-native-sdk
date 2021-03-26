import React from 'react';
import { StyleSheet, Text, TouchableOpacity, useColorScheme, View } from 'react-native';

import Colors from './Colors';

interface Props {
  title: string;
  onPress: any;
  disabled?: any;
}

const Button: React.FC<Props> = ({ title, onPress, disabled }) => {
  const isDarkMode = useColorScheme() === 'dark';
  const styles = getStyles(isDarkMode, disabled);
  return (
    <View style={styles.container} pointerEvents={disabled ? 'none' : 'auto'}>
      <TouchableOpacity onPress={disabled ? null : onPress}>
        <Text style={styles.text}>{title}</Text>
      </TouchableOpacity>
    </View>
  );
};

const getStyles = (isDarkMode: boolean, disabled: any) =>
  StyleSheet.create({
    container: {
      flexGrow: 1,
      flexShrink: 1,
      backgroundColor: isDarkMode ? Colors.primaryBright : Colors.primary,
      opacity: disabled ? 0.5 : 1,
      paddingVertical: 10,
      paddingHorizontal: 15,
      margin: 3,
      alignItems: 'center',
    },
    veil: {
      opacity: 0.3,
    },
    text: {
      color: isDarkMode ? Colors.black : Colors.white,
      textTransform: 'uppercase',
      fontWeight: 'bold',
      flexWrap: 'nowrap',
    },
  });

export default Button;
