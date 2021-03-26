const path = require('path');

module.exports = {
  dependency: {
    platforms: {
      ios: { podspecPath: path.join(__dirname, 'emma-react-native-sdk.podspec') },
      android: {
        packageImportPath: 'import io.emma.reactnative.EmmaReactNativePackage;',
        packageInstance: 'new EmmaReactNativePackage()',
      },
    },
  },
};
