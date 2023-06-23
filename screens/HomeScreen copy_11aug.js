import React ,{ useEffect }from 'react';
import { SafeAreaView,View, Text, FlatList, StyleSheet, 
  StatusBar,Alert,ScrollView,TextInput,ActivityIndicator,
  Modal,ImageBackground } from 'react-native';
import { useTheme } from '@react-navigation/native';

import Icon from 'react-native-vector-icons/Feather';
import RNLocation from 'react-native-location';
import { openDatabase } from 'react-native-sqlite-storage';

//  import SearchableDropdown from 'react-native-searchable-dropdown';
// import {Picker} from '@react-native-picker/picker';
import RNPicker from "search-modal-picker";

import { TouchableOpacity } from 'react-native';
import {launchCamera} from 'react-native-image-picker';
import * as ImageManipulator from '@pontusab/react-native-image-manipulator';
import { back } from 'react-native/Libraries/Animated/src/Easing';

// var db = SQLite.openDatabase({
//   name: 'testdbik.db', createFromLocation: '~www/testdbik.db', },
//   () => { },
//   error => {
//      console.log("error while opening DB: " + error);
//   });

//for ios check https://medium.com/swlh/integrating-a-prepopulated-sqlite-into-react-native-fdb90cf8cfa7

const db=openDatabase({name:'sisdpgt.db',createFromLocation:1},function () {
  console.log('--getting sisdpgt database----');
  //this.setState({isLoading: true});
  },
  function () {
    console.log('--error----');
    //this.setState({isLoading: true});    
  });

const HomeScreen = ({navigation}) => {

 const [isModalVisible, setIsModalVisible] = React.useState(false);  

  const [lulc, setLulc] = React.useState({
    level1: [],
    level2: [],
    level3: [],
    level4: [],
    selLevel1:'',
    selLevel2:'',
    selLevel3:'',
    selLevel4:'',
  });
  const [searchresult, setSearchresult] = React.useState({
    flatlistitems:[],
    searchTxt:'',
    seltexttemp:'',
    selclass:'',
    sell1:'',
    sell2:'',
    sell3:'',
    sell4:''
  });
  const [statelist,setStatelist]=React.useState({
     states:[],
     district:[]
  }
  );
  const [capturedImg,setCapturedImg]=React.useState({ 
    outimages:[],   
    image: [],
    imagebase64:[]
  });
  const [gpsloc,setGpsloc]=React.useState({
    loctext:'Waiting Location Information...',
    location: null,
    accvalue:0,    
    capLocation1: null,
    cappic1time:'',
    capLocation2: null,
    cappic2time:'',
    capLocText:'',
    latitude1:'',
    latitude2:'',
    longitude1:'',
    longitude2:'',
    accuracy1:'',
    accuracy2:'',    
  });
  const [data, setData] = React.useState({
    rem: '',    
    selLevel1:'',
    selLevel2:'',
    selLevel3:'',
    selLevel4:'',
    selState:'',
    selDist:'',
    searchclass:'',
    errorMessage: null,    
    isLoading: false,
  });
  const { colors } = useTheme();

  const theme = useTheme();
  
const getStatelist=()=>{
  db.transaction(
    tx => {    
      tx.executeSql("select distinct(statename) from districtlist", [],(tx, results)  =>{        
      var temp = [];  
      for (let i = 0; i < results.rows.length; ++i) {
        let item={
          id:i,
          name:results.rows.item(i).statename
          // label:results.rows.item(i).statename,
          // value:results.rows.item(i).statename
        }
  /*       let item=<Picker.Item label={results.rows.item(i).statename} value={results.rows.item(i).statename}  key={i}/> */
        temp.push(item);
        }     
       // console.log(temp);        
     setStatelist({states:temp,district:[]});
 
//console.log(statelist);
      },
      (t,error)=>{console.log(error+ " error in db - Statelist");           }
      );
    },
    function(error){console.log(error);
    },
    function (e) {      console.log('--getting state list data----');
      }
    );
};
const getDistList=(statename)=>{
  db.transaction(
    tx => {      
      tx.executeSql("select distinct(distname) from districtlist where statename=?", [statename],(tx, results)  =>{
        var temp = [];
    //    console.log(results);
    //    console.log(tx);
     //   console.log(results.rows.length);
      for (let i = 0; i < results.rows.length; ++i) {
        let item={
          id:i,
          name:results.rows.item(i).distname
        }
        temp.push(item);
        }             
     setStatelist({...statelist,district:temp});
//console.log(temp);
      },(t,error)=>{   console.log(error+ " error in db - Distlist");           }
      );
    },
    function(error){console.log(error);
    },
    function () {      console.log('--getting district list data----');
      }
    );
};

const getLULCSchema=()=>{
  db.transaction(
    tx => {      
      tx.executeSql("select distinct(LevelI) from classification", [],(tx, results)  =>{
        var temp = [];
      for (let i = 0; i < results.rows.length; ++i) {
        let item={
          id:i,
          name:results.rows.item(i).LevelI
        }
        temp.push(item);
      //	temp.push(results.rows.item(i));
      //	console.log(item);
      }
      
     setLulc({
      ...lulc,
        level1: temp,
        level2:[],
        level3:[],       
        level4:[]
      });
     // console.log(lulc.level1);
      },(t,error)=>{
        console.log(error+ " error in db");
        
      // this.setState({
      //   isLoading: false,
      //   FlatListItems: [],
      // });
         }
      );
    },
    function(error){
      console.log(error);
    },
    function () {
      console.log('--getting data----');
      //this.setState({isLoading: true});
      }
    );

}
const getLULCSchemaLevel2=(level1)=>{
  db.transaction(
    tx => {      
      tx.executeSql("select distinct(LevelII) from classification where LevelI=?", [level1],(tx, results)  =>{
        var temp = [];
      for (let i = 0; i < results.rows.length; ++i) {
        let item={
          id:i,
          name:results.rows.item(i).LevelII
        }
        temp.push(item);
        }
        let lastitem={
          id:results.rows.length,
          name:'None'
        }      
       temp.push(lastitem);

     setLulc({
      ...lulc,
        level2: temp,
        level3:[],
        level4:[]
      });
      console.log(lulc.level2);
      },(t,error)=>{        console.log(error+ " error in db - Level2");           }
      );
    },
    function(error){console.log(error);
    },
    function () {      console.log('--getting data----');
      }
    );
}

const getLULCSchemaLevel3=(level2)=>{
  db.transaction(
    tx => {      
      tx.executeSql("select distinct(LevelIII) from classification where LevelII=?", [level2],(tx, results)  =>{
        var temp = [];
      for (let i = 0; i < results.rows.length; ++i) {
        let item={
          id:i,
          name:results.rows.item(i).LevelIII
        }
        temp.push(item);
          }
          let lastitem={
            id:results.rows.length,
            name:'None'
          }      
         temp.push(lastitem);
     setLulc({
      ...lulc,
        level3: temp,
        level4:[]
      });
      console.log(lulc.level3);
      },(t,error)=>{console.log(error+ " error in db - Level3");           }
      );
    },
    function(error){console.log(error);
    },
    function () {console.log('--getting data----');
      }
    );
}
const getLULCSchemaLevel4=(level3)=>{
  db.transaction(
    tx => {      
      tx.executeSql("select distinct(RegionalDescription) from classification where LevelIII=?", [level3],(tx, results)  =>{
        var temp = [];
      for (let i = 0; i < results.rows.length; ++i) {
        let item={
          id:i,
          name:results.rows.item(i).RegionalDescription
        }
        temp.push(item);
          }
          let lastitem={
            id:results.rows.length,
            name:'None'
          }      
         temp.push(lastitem);
     setLulc({
      ...lulc,
        level4: temp
      });
      console.log(lulc.level4);
      },(t,error)=>{        console.log(error+ " error in db - Level4");           }
      );
    },
    function(error){console.log(error);
    },
    function () {      console.log('--getting data----');
      }
    );
}
  const getLocation = () => {
    RNLocation.configure({
      distanceFilter: 3.0,
      desiredAccuracy: {
        ios: "best",
        android: "highAccuracy"
      },
      // Android only
      androidProvider: "auto",
      interval: 10000, // Milliseconds
      fastestInterval: 10000, // Milliseconds
      maxWaitTime: 10000, // Milliseconds
      // iOS Only
      activityType: "other",
      allowsBackgroundLocationUpdates: false,
      pausesLocationUpdatesAutomatically: true,
      showsBackgroundLocationIndicator: false,
    })
     
    RNLocation.requestPermission({
      ios: "whenInUse",
      android: {
        detail: "fine"
      }
    }).then(granted => {
        if (granted) {   
          //console.log('callin _startUpdatingLocation') ;      
          _startUpdatingLocation();       
        }
      });
  };
  
 const _startUpdatingLocation = () => {
  let  locationSubscription = RNLocation.subscribeToLocationUpdates(
      locations => {
       // this.setState({ location: locations[0] });
        
        let location= locations[0];
          //  let loctext1='';
      // let loctext = "Waiting Location Information...";
        let latvalue="";
        let lonvalue="";
        let accvalue="";
          latvalue = parseFloat(location.latitude).toFixed(5);
          lonvalue = parseFloat(location.longitude).toFixed(5);
          accvalue = parseFloat(location.accuracy).toFixed(0);
        let  loctext = 'You are at Lat: ' + latvalue + ' Lon: ' + lonvalue + ' (Acc:' + accvalue + ' m)';
        console.log('get location');
        //console.log('_startUpdatingLocation');
        console.log("here "+loctext);
        //console.log(data);
        setGpsloc({
            ...gpsloc,
            location: locations[0],
            accvalue:accvalue,
            loctext:loctext
        })
        // setData({
        //     ...data,
        //     location: locations[0],
        //     accvalue:accvalue,
        //     loctext:loctext
        //   })
      }
    );
  };
  // const _stopUpdatingLocation = () => {
  //   console.log('stop');
  //   this.locationSubscription && this.locationSubscription();
  //  // this.setState({ location: null });
  //   setData({
  //     ...data,
  //     location: null
  //   })
  // };
  const searchLULCclass=()=>{
   let value=data.searchclass;
   db.transaction(
    tx => {      
      tx.executeSql("select LevelI,LevelII,LevelIII,RegionalDescription from classification where (LevelI like ?) || (LevelII like ?) || (LevelIII like ?) || (RegionalDescription like ?)", [`%${value}%`,`%${value}%`,`%${value}%`,`%${value}%`],(tx, results)  =>{
        var temp = [];
      //  for (let i = 0; i < results.rows.length; ++i) {        
      //   temp.push(results.rows.item(i));
      //     }
          
          if(results.rows.length==0){
            Alert.alert("Alert","No Search Results!");			
            temp=[];
            setSearchresult(
              {...searchresult,
                flatlistitems:temp
              }
            )
          }
          else{					
          for (let i = 0; i < results.rows.length; ++i){
            let item=results.rows.item(i);
          //	item['isSelect']=false;
            item['selectedClass']=styles.list;
            item['id']=i;
            temp.push(item);
          //	temp.push(results.rows.item(i));
          //	console.log(item);
          setSearchresult(
            {...searchresult,
              flatlistitems:temp
            }
          )
          setIsModalVisible(true);
          }
          }          
          
         // console.log(temp);
      },(t,error)=>{        console.log(error+ " error in db - search");           }
      );
    },
    function(error){console.log(error);
    },
    function () {      console.log('--getting search data----');
      }
    );
  }
  const listViewItemSeparator = () => {
		return (
		  <View style={{ height: 0.5, width: '100%', backgroundColor: '#808080' }} />
		);
	  };
    const selectItem = seldata => {
     // console.log(data);
     // let sel_id=data.id;
      // searchresult.flatlistitems.forEach((value,key) => {
       // console.log(value.id);
              // if(value.id!=sel_id){
              //   //	if(key!=index){					
              //     //searchresult.FlatListItems[key]
              //     data.selectedClass=styles.list;
              //     }
              //     else{					
              //       data.selectedClass=styles.selected;
              //     }
         //   console.log(data);        
      //});
       let searchTxt='Selected Class- \nLevel I : '+seldata.LevelI+'\nLevel II : '+seldata.LevelII+'\nLevel III : '+seldata.LevelII+'\nRegionalDescription : '+seldata.RegionalDescription;
       let seltexttemp='Selected Class - Level I : '+seldata.LevelI+' Level II : '+seldata.LevelII+' Level III : '+seldata.LevelII+' RegionalDescription : '+seldata.RegionalDescription;
        setSearchresult(
        {...searchresult,
          searchTxt:searchTxt,
          seltexttemp:seltexttemp,
          sell1:seldata.LevelI,
          sell2:seldata.LevelII,
          sell3:seldata.LevelIII,
          sell4:seldata.RegionalDescription
        }
      )
      // console.log(searchTxt)
  }

  
const resizeandSave = async (uri) => {
      
          let resizedresult= await ImageManipulator.manipulateAsync(
              uri,
              [{ resize: { height:600 } }],//image resized to 500 height
              { compress: 1, format: "jpeg", base64: true }
          );
          let d = new Date();
          let timestamp=d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate()+" "+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
         let capLoc = gpsloc.location;
         capLoc = 'Lon: ' + parseFloat(capLoc.longitude).toFixed(6) + ', Lat: ' + parseFloat(capLoc.latitude).toFixed(6) + ', Acc: ' + parseFloat(capLoc.accuracy).toFixed(0) + ' m';
         let newimage= capturedImg.image.push(resizedresult.uri);
         let newimage64=capturedImg.imagebase64.push(resizedresult.base64);

        //  setData(image => [...image, newimage]);
        //  setData(imagebase64 => [...imagebase64, newimage64]);
         
         console.log("image Length:"+ capturedImg.image.length);

            if (capturedImg.image.length == 1) {
                //latvalue = parseFloat(capLoc.latitude).toFixed(6);
                //lonvalue = parseFloat(capLoc.longitude).toFixed(6);
                //accvalue = parseFloat(capLoc.accuracy).toFixed(0);
                //  this.setState({accuracy:accvalue});                 
             //   console.log(capLoc);
                setCapturedImg({ 
                  ...capturedImg, 
                  image: newimage,
                  imagebase64:newimage64,
                });
                 // setData({
              //   ...data,      
              setGpsloc({
                ...gpsloc,
                  capLocation1: capLoc ,
                  latitude1:gpsloc.location.latitude,
                  longitude1:gpsloc.location.longitude,
                  accuracy1:gpsloc.location.accuracy,
                  cappic1time: timestamp,
                  capLocText: "Captured Location Coordinates:\n1. " + capLoc,                 
                })
                // console.log("**");
                // console.log(data);
                // renderImages();
              //  console.log("Your Captured Location Coordinates are ", capLoc);
            }
            else if (capturedImg.image.length == 2) {
              // let capLoc = data.location;
              // capLoc = 'Lon: ' + parseFloat(capLoc.longitude).toFixed(6) + ', Lat: ' + parseFloat(capLoc.latitude).toFixed(6) + ', Acc: ' + parseFloat(capLoc.accuracy).toFixed(0) + ' m';
            
              setCapturedImg({ 
                ...capturedImg,  
                image: newimage,
                imagebase64:newimage64,
              });
              // setData({
              //   ...data,      
              setGpsloc({
                ...gpsloc,              
                capLocation2: capLoc,
                latitude2:gpsloc.location.latitude,
                longitude2:gpsloc.location.longitude,
                accuracy2:gpsloc.location.accuracy,
                cappic2time: timestamp,
                capLocText: gpsloc.capLocText+"\n2. " + capLoc,
              })
              // console.log("***"+data);
              // renderImages();
              //latvalue = parseFloat(capLoc.latitude).toFixed(6);
              //lonvalue = parseFloat(capLoc.longitude).toFixed(6);
              //accvalue = parseFloat(capLoc.accuracy).toFixed(0);
              //  this.setState({accuracy:accvalue});                        
             // console.log("Your Captured Location Coordinates for image 2:  ", capLoc);              
          }
          renderImages();    
};
  const askPermissionsAsync = async () => {
    await Permissions.askAsync(Permissions.CAMERA);
    await Permissions.askAsync(Permissions.CAMERA_ROLL);
    // you would probably do something to verify that permissions
    // are actually granted, but I'm skipping that for brevity
  };  

  const pickImage = async () => {
     // askPermissionsAsync();
     // this.setState({ loading: true });
       if(capturedImg.image.length<2){
          let result = await launchCamera({
         // allowsEditing: false,
          quality:1,
          //cameraType:back,
          maxHeight:600,
          //maxWidth:100,
          includeBase64:true}, 
          (response) => {
            //console.log('Response = ', response);        
            if (response.didCancel) {
              console.log('User cancelled image picker');
            } else if (response.errorCode) {
              console.log('ImagePicker Error: ', response.errorCode);
            } else if (response.customButton) {
              console.log('User tapped custom button: ', response.customButton);
            } else {
            // console.log(response.assets[0].uri);
               resizeandSave(response.assets[0].uri);
           }
      //this.setState({ loading: false });
    //  this.setState({loading:false});
              // You can also display the image using data:
              // const source = { uri: 'data:image/jpeg;base64,' + response.data };
          
            //  this.setState({ loading: false });
      });     
          
  //     console.log("camera launched");   
      
      } 
      else
      {
          alert("Maximum 2 photos can be uploaded at a time");
      }
  
  };

const deleteImage= val=> {
  console.log('delete');
  console.log(val);
  Alert.alert(
      'Confirm Delete',
      'Do you really want to remove this picture?',
      [
          { text: 'Cancel', onPress: () => console.log('Cancel Pressed!') },
          { text: 'Yes', onPress: () => {
            let newimage=capturedImg.image;
            let remindex='';
            for (let i = 0; i < capturedImg.image.length; i++) {
              if (capturedImg.image[i]==val){
                console.log('selected image');
                newimage.splice(i,1);
                remindex=i;
              }
              else{

              }
            }
                // let img=capturedImg.image.filter(function (img) {
                //   return img !== val;
                // });     
                // console.log('newimagearray')     ;      
                // console.log(newimage);
                setCapturedImg({
                  ...capturedImg,
                  image:newimage,
                  //imagebase64:

                });
                  //console.log('image array after delete');
                //  console.log(capturedImg.image);
                  if (capturedImg.image.length == 0) {
                      // setData({ 
                      //   ...data,
                      setGpsloc({
                        ...gpsloc,
                        capLocation1: null ,
                        capLocation2: null,
                        cappic1time: null ,
                        cappic2time: null,
                        capLocText: "" });
                  }
                  else if (capturedImg.image.length == 1) {
                    let caploctext= gpsloc.capLocText;
                    caploctext=caploctext.split(/\n[2]/);
                   // console.log(caploctext[0]);
                    // setData({ 
                      //   ...data,
                    setGpsloc({
                      ...gpsloc,
                     // image: img,
                      capLocation2: null ,
                      cappic2time: null ,
                      capLocText: caploctext[0] });
                   // console.log("Captured Location Coordinates :  ", null);
                }
              }
          },
      ],
      { cancelable: true }
  );
}

const imagePress=(val)=>{
  console.log(val+" clicked");
 // setData({...data, selImg: val });
  //this.setModalVisible(true);
}
//const outimages=[];

const renderImages = () => {
    console.log(capturedImg.image.length+" img length");
    let outimages = [];
    //let remainder = 4 - (this.state.devices % 4);
    capturedImg.image.map((item, index) => {
        outimages.push(
          <TouchableOpacity 
          key={index} onPress={imagePress.bind(this, item)}>
               <ImageBackground
                key={index}
                source={{ uri: item }}
                resizeMode="contain"
                // onPress={() => this._imagePress(index)}
                style={{ width: 70, height: 60, borderWidth: 1, marginLeft: 10 }}
                >
                <TouchableOpacity onPress={deleteImage.bind(this, item)}>
                    <Text style={styles.deleteImage}>&times;</Text>
                </TouchableOpacity>
              </ImageBackground>
              </TouchableOpacity>
              );
            });
    //return images;
    setCapturedImg({
      ...capturedImg,
      outimages:outimages
    })
};
const saveDataClicked = () => {
  if ((capturedImg.image.length == 0) || (searchresult.selclass=='') || (data.selState=='') || (data.selDist=='')) 
  {
        alert("Please Fill the Form completely and Capture atleast one Picture to save the Data!")
    }
    else {
         Alert.alert(
            'Confirm' ,
            'Do you want to save the data for sending it Later?',
            [
                { text: 'Cancel', onPress: () => console.log('Cancel Pressed!') },
                {
                    text: 'Yes', onPress: () => {
                      setData({...data, isLoading: true });  	
                        //this.setState({ loading: true });                        
                        saveData('Pending');
                    }
                },
            ],
            { cancelable: true }
        );           
    }

}
const sendDataClicked = () => {
  if ((capturedImg.image.length == 0) || (searchresult.selclass=='') || (data.selState=='') || (data.selDist=='')) 
     {
          alert("Please Fill the Form completely and Capture one Picture to send the Data!")
      }
      else {
          Alert.alert(
              'Confirm' ,
              'Do you really want to send the data to server?',
              [
                  { text: 'Cancel', onPress: () => console.log('Cancel Pressed!') },
                  {
                      text: 'Yes', onPress: () => {                        
                        setData({...data, isLoading: true });  	
                         // this.setState({ loading: true });
                          saveData('Sent');
                      }
                  },
              ],
              { cancelable: true }
          );           
      }

}

const saveData=async(type)=>{

  //const addedby= AsyncStorage.getItem('userName');
  let addedby='test';
  console.log('added:');
  console.log(addedby);

  let d = new Date();

  let timestamp=d.getDate()+"-"+(d.getMonth()+1)+"-"+d.getFullYear()+" "+d.getHours()+":"+d.getMinutes()+":"+d.getSeconds();
  console.log(data.selState.name);
  console.log(data.selDist.name);
  console.log(data.selLevel1);
  console.log(data.selLevel2);console.log(data.selLevel3);
  console.log(data.selLevel4);console.log(data.rem);
  console.log(gpsloc.cappic1time);console.log(gpsloc.cappic2time);
  console.log(gpsloc.latitude1);console.log(gpsloc.latitude2);
  console.log(gpsloc.longitude1);console.log(gpsloc.longitude2);
  console.log(gpsloc.accuracy1);
  console.log(gpsloc.accuracy2);
  console.log(data.type);

  let photob640=capturedImg.imagebase64[0];
  let photob641='';
  let numimg=capturedImg.image.length;
  if(numimg>1)  
  photob641=capturedImg.imagebase64[1];
  let i=0;
  db.transaction((tx) => {
    tx.executeSql(
      'INSERT INTO geotagTbl (timestamp,addedby,selstate,seldist,l1class,l2class,l3class,regdisc,otherclass,num_img,photob640,pic1time,latitude1,longitude1,accuracy1,photob641,pic2time,latitude2,longitude2,accuracy2,obssts) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',         
      [timestamp,addedby,data.selState.name,data.selDist.name,data.selLevel1,data.selLevel2,data.selLevel3,data.selLevel4,data.rem,numimg,photob640,
        gpsloc.cappic1time,gpsloc.latitude1,gpsloc.longitude1,gpsloc.accuracy1,photob641,gpsloc.cappic2time,gpsloc.latitude2,
        gpsloc.longitude2,gpsloc.accuracy2,'Pending'], 
    // [projcode,sts,geotag,rem,latitude1,longitude1,accuracy1,pic1time,timestamp,addedby],
      (tx,results) => {
        //console.log(results);
        i=results.insertId;

        console.log(' data inserted into geotagTbl. saved');    
        
        console.log(type);
        if (type=='Sent')  {
          //send data to server
          sendToServer(i);

        }
        else if (type=='Pending') {          
          //setData({...data, isLoading: false });  	
          Alert.alert("Success","Data successfully saved in History");
          resetForm();
          //return to home screen


        }
      
   },(t,error)=>{
     console.log(error);
   });
     }, function(e){
      console.log('error in inserting:');
       console.log(e);
     }, function (f) {
    //console.log(f+'--here---');
    }
  );

}

const resetForm = () => {
  
  setSearchresult(
    {
      selclass:''
    }
  );  
  setCapturedImg({  
    image: [],
    imagebase64:[],
  });
  setData({
    ...data,
    selLevel1:'',
    selLevel2:'',
    selLevel3:'',
    selLevel4:'',
    searchclass:'',
    rem: '',
    capLocText:'',
    capLocation1: null,
    capLocation2: null,
    cappic1time:'',
    cappic2time:'',
    latitude1:'',
    latitude2:'',
    longitude1:'',
    longitude2:'',
    accuracy1:'',
    accuracy2:'',
    isLoading:false    
  });

}

const sendToServer =async(id)=>
{
  //(tx, results)
  console.log('id:  '+id);
  let obs_data=[];
  db.transaction((tx) => {
    tx.executeSql("select * from geotagTbl where id=?", [id], 
    (_, { rows }) =>{
      obs_data=rows.item(0);
      //console.log('output : ')
    //console.log(obs_data);
    // console.log(obs_data[0].latitude1);
  
    fetch(global.server_url+'mobile_upload_gt.php',{
    method: 'POST',
    headers: {
      'Accept':  'application/json',
      'Content-Type': 'application/json',
    },
    body:JSON.stringify(obs_data)
    })
    .then(response => response.json())
    .then(response => {     
    // console.log(response);      
    //console.log(response.success);     
    //this.setState({ loading: false });
    // this.setState({
    //   isLoading: false
    // }); 
    if (response.success == "true") {
      console.log('geotagTbl uploaded with id '+id);
      
      //setData({...data, isLoading: false }); 
      
      resetForm();  
      //Alert.alert("Success",response.updateInfo);
      Alert.alert("Success",response.updateInfo,
        [{ text: 'OK', onPress: () => {   
                     
      setData({...data, isLoading: false });  
					db.transaction(tx => {
						tx.executeSql("update geotagTbl set obssts=(?) where id = ?", ['Sent',id],(tx, results)  =>{
							//	console.log(results);		
                navigation.navigate("Main");			
                 						
							},(t,error)=>{                
								console.log(error);
								console.log(t);								
							})							
					}); 
                   // this.resetModalForm();   
          }},
         ],{ cancelable: false }
        ); 
      //Insert family data now
     // this.sendFamilyData(response.hh_code);  
    }
    else { 
      setData({...data, isLoading: false });  
      console.log(response);
      Alert.alert("Error","Error in Sending Data to server\n"+response.lastError);
    }    
   
    })
    .catch(error=>{
      setData({...data, isLoading: false }); 
    console.log(error);
    Alert.alert("Error","Could not connect to the server. Try again after some time.");   
    });  
    });
    });
}

  useEffect(() => {
    // write your code here, it's like componentWillMount
    getLULCSchema();
    getLocation();
    getStatelist();
    db.transaction((tx) => {
          tx.executeSql(
            "create table if not exists geotagTbl ( id INTEGER PRIMARY KEY AUTOINCREMENT,timestamp text,addedby text, selstate text,seldist text,l1class text, l2class text, l3class text, regdisc text, otherclass text,num_img int, photob640 text,pic1time text, latitude1 numeric,longitude1 numeric,accuracy1 numeric,photob641 text,  pic2time text, latitude2 numeric,longitude2 numeric,accuracy2 numeric,obssts text);",     
            [], (tx) => {
              console.log('----created---');
         },(t,error)=>{
          console.log(error);
        });
        }
        , null, function () {
          console.log('--  created table--?--');
          }
        );
},[]);

    return ((data.isLoading) ? (
      <View style={styles.loading} >
          <ActivityIndicator size="large" color="#0000ff"/>
      </View>
    
    ): (
      
      <View style={styles.container}>
        <StatusBar barStyle= { theme.dark ? "light-content" : "dark-content" }/>
        {/* <Text style={{color: colors.text}}>Home Screen</Text> */}
      {/* <Button
        title="Go to details screen"
        onPress={() => navigation.navigate("Details")}
      /> */}
      <ScrollView style={styles.scrollContainer} keyboardShouldPersistTaps='always'>
            <SafeAreaView style={styles.stsform}>
            
          <Text style={styles.headerText}>LULC Classes</Text>
          <Text style={styles.getStartedText}>Search</Text>
          <View style={styles.hBox}>
              <TextInput
               // multiline={true}
               // numberOfLines={2}
                placeholder="Search LULC class"
                style={styles.searchTextinput}
                editable={true}
                maxLength={60}
            value={data.searchclass}           
                onChangeText={value => {
                //  console.log('changed ');
                 // rem=rem.replace(/[`~!@#$%^&*_|+\=?;:'",.<>\{\}\[\]\\\/]/gi, '') });
                  setData({
                      ...data,
                      searchclass: value.replace(/[`~!@#$%^&*_|+\=?;:'",.<>\{\}\[\]\\\/]/gi, '') })
                  //});
            
            //      this.setState({ rem:rem.replace(/[`~!@#$%^&*_|+\=?;:'",.<>\{\}\[\]\\\/]/gi, '') });
                }}
              />
              <TouchableOpacity onPress={searchLULCclass}>
                  <Text style={styles.gobutton}>
                  Go
                </Text>
              </TouchableOpacity>
              </View>
          <Text style={styles.headerTextsmall}>or</Text>

              <Text style={styles.getStartedText}>Select Level I</Text>
              <RNPicker
              dataSource={lulc.level1}
              dummyDataSource={lulc.level1}
              defaultValue={false}
              pickerTitle={"Select Level I"}
              showSearchBar={true}
              disablePicker={false}
              changeAnimation={"none"}
              searchBarPlaceHolder={"Search....."}
              showPickerTitle={true}
              placeHolderText={"Select Level I LULC Class"}
              searchBarContainerStyle={styles.searchBarContainerStyle}
              pickerStyle={styles.pickerStyle}
              pickerItemTextStyle={styles.listTextViewStyle}
              selectedLabel={data.selLevel1}
              //placeHolderLabel={this.state.placeHolderText}
              selectLabelTextStyle={styles.selectLabelTextStyle}
              placeHolderTextStyle={styles.placeHolderTextStyle}
              dropDownImageStyle={styles.dropDownImageStyle}
            // dropDownImage={require("./res/ic_drop_down.png")}
              selectedValue={(index, item) => {
                        getLULCSchemaLevel2(item.name);
                            // setLulc({
                            //   ...lulc,
                            //   level2:[],
                            //   level3:[],
                            //   level4:[]
                            // });
                            
                        setData({
                              ...data,
                              searchclass:'',
                              selLevel1:item.name ,                             
                              selLevel2:'',
                              selLevel3:'',
                              selLevel4:'',
                            });
                            let searchTxt='Selected Class - Level I : '+item.name;
                            //+' Level II : '+data.selLevel2+' Level III : '+data.selLevel3+' RegionalDescription : '+data.selLevel4;
      
                            setSearchresult({
                              selclass:searchTxt,
                              searchTxt:''});



              }}
            />
          <Text style={styles.getStartedText}>Select Level II</Text>

          <RNPicker
              dataSource={lulc.level2}
              dummyDataSource={lulc.level2}
              defaultValue={false}
              pickerTitle={"Select Level II"}
              showSearchBar={true}
              disablePicker={false}
              changeAnimation={"none"}
              searchBarPlaceHolder={"Search....."}
              showPickerTitle={true}
              placeHolderText={"Select Level II LULC Class"}
              searchBarContainerStyle={styles.searchBarContainerStyle}
              pickerStyle={styles.pickerStyle}
              pickerItemTextStyle={styles.listTextViewStyle}
              selectedLabel={data.selLevel2}
              //placeHolderLabel={this.state.placeHolderText}
              selectLabelTextStyle={styles.selectLabelTextStyle}
              placeHolderTextStyle={styles.placeHolderTextStyle}
              dropDownImageStyle={styles.dropDownImageStyle}
            // dropDownImage={require("./res/ic_drop_down.png")}
              selectedValue={(index, item) => {
                      getLULCSchemaLevel3(item.name);
                            // setLulc({
                            //   ...lulc,
                            //   level3:[],
                            //   level4:[]
                            // });
                        setData({
                              ...data,
                              searchclass:'',
                             // selLevel1:item ,                             
                              selLevel2:item.name,
                              selLevel3:'',
                              selLevel4:'',
                            });    
                            let searchTxt='Selected Class - Level I : '+data.selLevel1+' Level II : '+item.name;
                            //+' Level III : '+data.selLevel3+' RegionalDescription : '+data.selLevel4;
      
                            setSearchresult({
                              selclass:searchTxt,
                              searchTxt:''});
              }}
            />
        <Text style={styles.getStartedText}>Select Level III</Text>
        <RNPicker
              dataSource={lulc.level3}
              dummyDataSource={lulc.level3}
              defaultValue={false}
              pickerTitle={"Select Level III"}
              showSearchBar={true}
              disablePicker={false}
              changeAnimation={"none"}
              searchBarPlaceHolder={"Search....."}
              showPickerTitle={true}
              placeHolderText={"Select Level III LULC Class"}
              searchBarContainerStyle={styles.searchBarContainerStyle}
              pickerStyle={styles.pickerStyle}
              pickerItemTextStyle={styles.listTextViewStyle}
              selectedLabel={data.selLevel3}
              //placeHolderLabel={this.state.placeHolderText}
              selectLabelTextStyle={styles.selectLabelTextStyle}
              placeHolderTextStyle={styles.placeHolderTextStyle}
              dropDownImageStyle={styles.dropDownImageStyle}
            // dropDownImage={require("./res/ic_drop_down.png")}
              selectedValue={(index, item) => {
                getLULCSchemaLevel4(item.name);
                            // setLulc({
                            //   ...lulc,
                            //   level4:[]
                            // });
                        setData({
                              ...data,
                              searchclass:'',
                             // selLevel1:item ,                             
                             // selLevel2:item,
                              selLevel3:item.name,
                              selLevel4:'',
                            });    

                            let searchTxt='Selected Class - Level I : '+data.selLevel1+' Level II : '+data.selLevel2+' Level III : '+item.name;
                            //+' RegionalDescription : '+data.selLevel4;
      
                            setSearchresult({
                              selclass:searchTxt,
                              searchTxt:''});    
              }}
            />
            <Text style={styles.getStartedText}>Select Regional Descriptor</Text>
            <RNPicker
              dataSource={lulc.level4}
              dummyDataSource={lulc.level4}
              defaultValue={false}
              pickerTitle={"Select Level IV"}
              showSearchBar={true}
              disablePicker={false}
              changeAnimation={"none"}
              searchBarPlaceHolder={"Search....."}
              showPickerTitle={true}
              placeHolderText={"Select Level IV LULC Class"}
              searchBarContainerStyle={styles.searchBarContainerStyle}
              pickerStyle={styles.pickerStyle}
              pickerItemTextStyle={styles.listTextViewStyle}
              selectedLabel={data.selLevel4}
              //placeHolderLabel={this.state.placeHolderText}
              selectLabelTextStyle={styles.selectLabelTextStyle}
              placeHolderTextStyle={styles.placeHolderTextStyle}
              dropDownImageStyle={styles.dropDownImageStyle}
            // dropDownImage={require("./res/ic_drop_down.png")}
              selectedValue={(index, item) => {
                    setData({
                              ...data,
                              searchclass:'',
                             // selLevel1:item ,                             
                             // selLevel2:item,
                             // selLevel3:'',
                              selLevel4:item.name,
                            });  
                            
                            let searchTxt='Selected Class - Level I : '+data.selLevel1+' Level II : '+data.selLevel2+' Level III : '+data.selLevel3+' RegionalDescription : '+item.name;
      
                            setSearchresult({
                              selclass:searchTxt,
                              searchTxt:''});  
                            
              }}
            />
             
              <Text style={styles.getStartedText}>Other Class (Specify)</Text>
              <TextInput
               // multiline={true}
               // numberOfLines={2}
                placeholder="Other Class"
                style={styles.multiinputText}
                editable={true}
                maxLength={60}
                value={data.rem}           
                onChangeText={rem => {
                //  console.log('changed ');
                 // rem=rem.replace(/[`~!@#$%^&*_|+\=?;:'",.<>\{\}\[\]\\\/]/gi, '') });
                  setData({
                      ...data,
                      rem: rem.replace(/[`~!@#$%^&*_|+\=?;:'",.<>\{\}\[\]\\\/]/gi, '') })
                  //});
            
            //      this.setState({ rem:rem.replace(/[`~!@#$%^&*_|+\=?;:'",.<>\{\}\[\]\\\/]/gi, '') });
                }}
              />
              <Text style={styles.selclassText}>{searchresult.selclass}</Text>
              <View style={styles.cameracontainer}>
                  <Icon.Button
                    size={30} 
                    name="camera"
                    backgroundColor="teal"//"#3b5998"
                  onPress={() => {
                    console.log("accvalue is "+gpsloc.accvalue);              // if (accvalue>30)     
                  if (gpsloc.accvalue>2000)             
                      alert('Accuracy of GPS is more than 2km. Please wait for sometime for accuracy to improve. Ensure you are under open sky!');
                  else
                      //this.props.navigation.navigate('Camera');
                        // this._handleCamera();
                      pickImage();
                    }}>
                    Capture Photos
                  </Icon.Button>
                  {capturedImg.outimages}
                {/* {renderImages()} */}
                </View>
                <Text style={styles.caplocText}>{gpsloc.capLocText}</Text> 
            </SafeAreaView>
            
          </ScrollView>
            
      <Text style={styles.gpsText}>{gpsloc.loctext}</Text>
      <View style={styles.btncontainer}>

                      <View style={styles.buttonCol}>
                        <TouchableOpacity
                          onPress={saveDataClicked}
                          style={styles.buttonSave}>
                          <Text style={styles.btnText}>Save for Later</Text>
                        </TouchableOpacity>
                      </View>
                      <View style={styles.buttonCol}>
                        <TouchableOpacity
                          onPress={sendDataClicked}
                          style={styles.buttonSave}>
                          <Text style={styles.btnText}>Send now</Text>
                        </TouchableOpacity>
                      </View>
              </View>
          <Modal animationType="slide" style={styles.modalContainer}
              transparent={true}
              visible={isModalVisible}
              onRequestClose={() => {
                Alert.alert("Modal has been closed.");
                setIsModalVisible(false);
          }}
          >  
              <View style={styles.modalView}>
                    <Text style={{fontSize:16}} >Search Results</Text>  
                    <View style={styles.flatlistView}>
                   <FlatList style={styles.flatlist}
                      data={searchresult.flatlistitems}
                     // ItemSeparatorComponent={listViewItemSeparator}
                      keyExtractor={(item, id) => id.toString()}
                      renderItem={ data =>// this.renderItem(item)}		
                      //extraData={this.state}
                      <TouchableOpacity key={data.item.id}
                        style={[data.item.selectedClass]}      
                       onPress={() => selectItem(data.item)}>
                        <View  style={styles.rowcontainer}>
                          <Text>{data.item.LevelI} > {data.item.LevelII} > {data.item.LevelIII} > {data.item.RegionalDescription}</Text>
                        </View>      
                      </TouchableOpacity> }
                    />
                    </View>
                    <Text style={styles.searchBox}>{searchresult.searchTxt}</Text>
                    <View style={styles.hBox}>
                    <TouchableOpacity onPress={() => {
                             setIsModalVisible(false);
                            // alert('Form has been closed.');
                            }}   style={[styles.widget, {height:40,backgroundColor: 'orange' }]}>
                          <Text  style={styles.btnText}>{'Close'}</Text>             
                    </TouchableOpacity>
                    <TouchableOpacity onPress={() => {
                      setSearchresult(
                        {selclass:searchresult.seltexttemp}
                      );                     
                        setData({
                              ...data,
                              //searchclass:'',
                            selLevel1:searchresult.sell1 ,                             
                            selLevel2:searchresult.sell2, 
                            selLevel3:searchresult.sell3,
                            selLevel4:searchresult.sell4,
                            });

                             setIsModalVisible(false);
                            // alert('Form has been closed.');
                    }}   style={[styles.widget, {height:40,backgroundColor: 'teal' }]}>
                          <Text  style={styles.btnText}>{'Select Class'}</Text>             
                    </TouchableOpacity>
                    </View>
              </View>                      
          </Modal>          
      </View>)
    );
};

export default HomeScreen;

const styles = StyleSheet.create({
  container: {
    flex: 1, 
    alignItems: 'center', 
    justifyContent: 'center',
    //backgroundColor:'rgba(0,0,0,0.5)'
  }, 
  loading: {
    position: 'absolute',
    left: 0,
    right: 0,
    top: 0,
    bottom: 0,
    opacity: 0.5,
    backgroundColor: 'gray',
    justifyContent: 'center',
    alignItems: 'center'
  },
  scrollContainer:{
    flex: 1, 
    height:'100%',
    width:'100%',
  },
  modalContainer:{
    backgroundColor: 'rgba(0,0,0,0.5)',
    flex:1,
  },
  
  modalView: {
    flex:1,
    backgroundColor: '#Fff',
    borderRadius: 5,
    borderWidth: 1,
    borderColor: "#000",
    borderStyle: "solid",
    marginLeft: 15,
    marginTop: 50,
    marginRight: 15,
    marginBottom: 30,
    paddingTop: 40,
    paddingBottom: 40,
    paddingLeft: 10,
    paddingRight: 10,
    alignItems: "center",
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 2
    },
    shadowOpacity: 0.25,
    shadowRadius: 4,
    elevation: 5
  },
  statecontainer:{
    paddingTop:10,
    paddingBottom:6,
    borderWidth: 1,
    borderColor: 'gray',
  },
  searchBox:{
  //borderWidth:1
  },
  hBox:{    
    //flex: 1,
    paddingLeft:0,
    paddingRight:10,
    paddingTop:0,
    paddingBottom:0,
    marginTop:0,
    flexDirection: 'row',
    //backgroundColor: 'lightgray',
    alignItems: 'center',
    justifyContent:'space-between'
  },
  gobutton:{
    padding:8,
    fontSize: 18,
    borderRadius:5,
    textAlign:'center',
    backgroundColor:"teal",//"#3b5998",
    color:'white',
    width:70
    },               
  stsform: {
    flex: 1,
    width: '100%',
    paddingTop: 0,
    backgroundColor: 'white',
    borderWidth: 0,
    borderColor: 'gray',
    justifyContent: 'flex-start',
  },
  headerText:{
    fontSize: 16,
    color: 'green',
    lineHeight: 24,
    marginLeft: 10,
    paddingTop:10,
    marginBottom: 5,
  },
  headerTextsmall:{
    fontSize: 14,
    color: 'green',
    lineHeight: 14,
    marginLeft: 10,
    paddingTop:10,
    marginBottom: 10,
  },
  caplocText:{
    fontSize:12,
    paddingBottom:30,
    textAlign: 'left',
    marginLeft: 10,
   

  },
  getStartedText: {
    fontSize: 14,
    color: 'black',
    lineHeight: 18,
    textAlign: 'left',
    marginLeft: 10,
    //marginTop:4,
    },
    selclassText:{
      fontWeight:'bold',
      fontSize: 14,
      color: 'teal',
      lineHeight: 16,
      textAlign: 'left',
      marginLeft: 10,
      marginBottom:10,
      marginTop:10,
    },
    gpsText: {
      width:'100%',
      fontSize: 12,
      color: 'gray',
      lineHeight: 16,
      textAlign: 'left',
      paddingLeft:10,
      marginLeft: 10,
      marginRight: 10,
      marginBottom: 0,
      paddingBottom:0,
      backgroundColor: '#fff',
      borderTopColor:'black',
      borderTopWidth:1,
     // borderWidth: 1,
      // width:200,
      // Set border Hex Color Code Here.
      borderColor: '#000',
  },
  multiinputText: {
   // width:'100%',
    textAlign: 'left',
    paddingLeft:10,
    marginLeft: 10,
    marginRight: 10,
    marginTop: 4,
    marginBottom: 0,
    height: 40,
    borderWidth: 1,
    fontSize: 14,
    // width:200,
    // Set border Hex Color Code Here.
    borderColor: '#000',
    // Set border Radius.
    borderRadius: 5,
  },
  searchTextinput:{ 
    paddingLeft:10,
    marginLeft: 10,
    marginRight: 10,
    marginTop: 4,
    marginBottom: 0,
    height: 40,
    borderWidth: 1,
    fontSize: 14,
    borderColor: '#000',
    borderRadius: 5,
    flex:1
  },
  cameracontainer:{
    marginLeft: 12,
    marginTop: 5,
  height: 65,
  flexDirection: 'row',
  alignItems: 'flex-start',
},
dropdownitem:{  
  padding: 6,
  marginLeft: 10,
  marginRight: 10,
  backgroundColor: '#ddd',
  borderColor: '#bbb',
  borderWidth: 1,
  borderRadius: 0,
},
dropdowncontainer:{
  padding: 5 
},
btnText: {
  color: '#fff',
  fontWeight: 'bold',
  fontSize: 18,
  margin: 5,
},
widget: {
  height:60,
  //flex: 1,
  margin:5,
  padding: 0,
  justifyContent: 'center',
  alignItems: 'center'
},
dropdowntextinput:
{
  fontSize: 16,
  paddingLeft: 10,
  paddingTop: 4,
  paddingBottom: 4,
  marginBottom:0,
  marginTop:2,
  marginLeft:6,
  marginRight:6,
  borderWidth: 1,
  borderColor: '#000',
  borderRadius: 5,
 // backgroundColor: '#FAF7F6',
},
rowcontainer:{
		flex: 1,
	//	paddingLeft:6,
		//paddingRight:6,
    padding:0,
    margin:0

	},
selected: {
    backgroundColor: "#ffc8bc",
    borderColor: '#bbb',
    borderWidth: 1,
		padding: 10,
		margin: 6,
		flexDirection: "row",		
		justifyContent: "flex-start",
		alignItems: "center",
  },
flatlist:{
  //width:'100%',
  //flex:1,
  padding: 0,
  margin: 0,
  //backgroundColor: "#ffc8bc"
},
flatlistView:{
  justifyContent: "flex-start",
  width:'100%',
  flex:1,
  margin: 10,
  borderWidth: 1,
  borderColor: '#000',
  borderRadius: 5,
  //backgroundColor: "#ffc8bc"
},
list: {
  borderColor: '#bbb',
  borderWidth: 1,
  paddingLeft: 10,
		padding: 2,
		margin: 2,
		flexDirection: "row",
		backgroundColor: "#ffffff",
		justifyContent: "flex-start",
		alignItems: "center",
		//zIndex: -1
	  },
    deleteImage:{
      textAlign:"right",margin:0,padding:0,
      fontWeight:'bold',fontSize:14,
      color: '#f00',
    },
    // buttonSend: {
    //   // width:200,
    //   padding: 0,
    //   marginLeft: 2,
    //   marginRight: 4,
    //   height: 36,
    //   backgroundColor: 'coral',
    //   alignItems: 'center',
    //   borderRadius: 10,shadowColor: 'black',
    //   shadowOpacity: 1,
    //   shadowOffset: {width: 2, height: 2},
    //   shadowRadius: 10,
    //   elevation: 4,
    // },
    buttonSave: {
      // width:200,
      padding: 0,
      marginLeft: 4,
      marginRight: 4,
      height: 36,
      backgroundColor: 'coral',
      alignItems: 'center',
      borderRadius: 0,
      shadowColor: 'black',
      shadowOpacity: 1,
      shadowOffset: {width: 2, height: 2},
      shadowRadius: 10,
      elevation: 4,
    },
    btncontainer: {
      backgroundColor: 'white',
      height: 50,
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'center',
    }, 
    buttonCol: {
      flex: 1,
    },
    searchBarContainerStyle: {
      padding:10,
      marginBottom: 5,
      flexDirection: "row",
      height: 30,
      shadowOpacity: 1.0,
      shadowRadius: 5,
      shadowOffset: {
        width: 1,
        height: 1
      },
      backgroundColor: "rgba(255,255,255,1)",
      shadowColor: "#d3d3d3",
      borderRadius: 5,
      elevation: 3,
      marginLeft: 10,
      marginRight: 10
    },
  
    selectLabelTextStyle: {
      color: "#000",
      textAlign: "left",
      width: "99%",
      padding: 5,
      margin:0,
      flexDirection: "row"
    },
    placeHolderTextStyle: {
      color: "#D3D3D3",
      padding: 5,
      margin:0,
      textAlign: "left",
      width: "99%",
      flexDirection: "row"
    },
    dropDownImageStyle: {
      marginLeft: 10,
      width: 10,
      height: 10,
      alignSelf: "center"
    },
    listTextViewStyle: {
      color: "#000",
      marginVertical: 10,
      flex: 0.9,
      marginLeft: 20,
      marginHorizontal: 10,
      textAlign: "left"
    },
    pickerStyle: {
      marginLeft: 25,
      marginRight: 15, 
      marginTop:2,
      marginBottom: 10,
      elevation:3,
      paddingTop:0,
      paddingBottom:0,
      paddingRight: 25,
      height:34,
      shadowOpacity: 1.0,
      shadowOffset: {
        width: 1,
        height: 1
      },
      borderWidth:1,
      shadowRadius: 10,
      backgroundColor: "rgba(255,255,255,1)",
      shadowColor: "#d3d3d3",
      borderRadius: 5,
      flexDirection: "row"
    }
  
});
