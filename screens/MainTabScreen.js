import React from 'react';

import { createMaterialBottomTabNavigator } from '@react-navigation/material-bottom-tabs';
import { createStackNavigator } from '@react-navigation/stack';

import Icon from 'react-native-vector-icons/Ionicons';

import HomeScreen from './HomeScreen';
import HistoryScreen from './HistoryScreen';
import MainScreen from './MainScreen';
// import ProfileScreen from './ProfileScreen';

const HomeStack = createStackNavigator();
const DetailsStack = createStackNavigator();

const Tab = createMaterialBottomTabNavigator();

const MainTabScreen = () => (
    <Tab.Navigator
      initialRouteName="Home"
     // shifting={true}
      labeled={true}
      activeColor="#FFF"
      inactiveColor="#000"
      backgroundColor='teal'
      barStyle={{backgroundColor:'#009387'}}      
    >
      <Tab.Screen
        name="Home"
        title="Home"
        component={HomeStackScreen}
        options={{
          tabBarLabel: 'Home',
         // tabBarColor: '#009387',
          tabBarIcon: ({ color }) => (
            <Icon name="ios-home" color={color} size={26} />
          ),
        }}
      />
      <Tab.Screen
        name="History"
        title="History"
        component={DetailsStackScreen}
        options={{
          tabBarLabel: 'History',
         // tabBarColor: 'coral',
          tabBarIcon: ({ color }) => (
            <Icon name="ios-aperture" color={color} size={26} />
          ),
        }}
      />
      
    </Tab.Navigator>
);

export default MainTabScreen;

const HomeStackScreen = ({navigation}) => (
<HomeStack.Navigator screenOptions={{
        headerStyle: {
        backgroundColor: '#009387',
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
        fontWeight: 'bold'
        }
    }}>
    <HomeStack.Screen name="Main" component={MainScreen} options={{
        title:'SISDP U Ground Truth App',
        headerLeft: () => (
            <Icon.Button name="ios-menu" size={25} backgroundColor="#009387" onPress={() => navigation.openDrawer()}></Icon.Button>
        )
        }} />
        <HomeStack.Screen name="Home" component={HomeScreen} options={{
        title:'Collect Ground Truth Data',
        headerLeft: () => (
            <Icon.Button name="ios-arrow-back" size={25} backgroundColor="#009387" onPress={() => navigation.navigate("Main")}></Icon.Button>
        )
        }} />
</HomeStack.Navigator>
);

const DetailsStackScreen = ({navigation}) => (
<DetailsStack.Navigator screenOptions={{
        headerStyle: {
        backgroundColor: '#009387',
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
        fontWeight: 'bold'
        }
    }}>
        <DetailsStack.Screen name="History" component={HistoryScreen} options={{
        headerLeft: () => (
            <Icon.Button name="ios-menu" size={25} backgroundColor="#009387" onPress={() => navigation.openDrawer()}></Icon.Button>
        )
        }} />
</DetailsStack.Navigator>
);
  