import React  ,{ useEffect } from 'react';
import { View, Text, TouchableOpacity,Modal, StyleSheet, Alert } from 'react-native';

import AsyncStorage from '@react-native-community/async-storage';
import { openDatabase } from 'react-native-sqlite-storage';
import RNPicker from "search-modal-picker";

const db=openDatabase({name:'sisdpgt.db',createFromLocation:1},function () {
  console.log('--getting database----');
  //this.setState({isLoading: true});
  },
  function () {
    console.log('--error----');
    //this.setState({isLoading: true});    
  });

const MainScreen = ({navigation}) => {
  
 const [isModalVisible, setIsModalVisible] = React.useState(false);  

  const [data, setData] = React.useState({   
    selState:'',
    selDist:''
  })
  const [statelist,setStatelist]=React.useState({
    states:[],
    district:[]
 }
 )
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
  }
  const getDistList=(statename)=>{
    console.log(statename);
    db.transaction(
      tx => {      
        tx.executeSql("select distinct(distname) from districtlist where statename=?", [statename],(tx, results)  =>{
          var temp = [];
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
  }
  
  const selectDist=async()=>{
    //console.log (data.selState);
    //console.log (data.selDist);
    setData({
      ...data,
      selState:data.selStatetemp,
      selDist:data.selDisttemp })
  
    try{
        await AsyncStorage.setItem('selstate', data.selStatetemp);
        await AsyncStorage.setItem('seldist', data.selDisttemp);
        setIsModalVisible(false);
    } 
    catch(e) {
        console.log(e);
    }
  }

  useEffect(() => {
    getStatelist();  

    setTimeout(async() => {
      let selState=null;
      let selDist=null;          
      
      try {
        selState = await AsyncStorage.getItem('selstate');
        selDist=await AsyncStorage.getItem('seldist');
        
        if(selDist && selState){
            // console.log(selState);
            // console.log(selDist);
            setIsModalVisible(false);
            setData({
              ...data,
              selState:selState,
              selDist:selDist })
          }
          else{
            setIsModalVisible(true);
          }
        
      } catch(e) {
        console.log(e);
      }
     
    }, 1000);
   
  },[]);
  
  return (
      <View  style={styles.scrollcontainer} contentContainerStyle={{ flex: 1 }}>
         <View style={styles.row}>               
              <TouchableOpacity onPress={() =>{if (data.selDist) {console.log(data.selDist); navigation.navigate("Home")}
               else{ Alert.alert("Alert", "Please select a District before proceeding")}}}  style={[styles.widget, { backgroundColor: 'teal' }]}>
                <Text  style={styles.btnText}>{'Collect GT'}</Text>
              </TouchableOpacity>
              <TouchableOpacity onPress={() => navigation.navigate("History")} style={[styles.widget, { backgroundColor: 'darkcyan' }]}>
                <Text  style={styles.btnText}>{'History'}</Text>
            </TouchableOpacity>
            <TouchableOpacity onPress={() =>  setIsModalVisible(true)} style={[styles.widget, { backgroundColor: 'seagreen' }]}>
                <Text  style={styles.btnText}>{'Select District'}</Text>
            </TouchableOpacity>

            <View style={styles.scrollcontainer}>
              <Text style={styles.getStartedText}>Selected District : </Text>
              <Text style={styles.getStartedText}>{data.selState}</Text>
              <Text style={styles.getStartedText}>{data.selDist}</Text>
            </View>            
      </View>        
      <Modal animationType="slide" style={styles.modalContainer}
                  transparent={true}
                  visible={isModalVisible}
                  onRequestClose={() => setIsModalVisible(false)}>                  
      <View style={styles.modalView} contentContainerStyle={{ flex: 1 }}>
      <Text style={styles.headerText}>Select a District</Text> 
      <View style={styles.statecontainer}>
            <Text style={styles.getStartedText}>Select State</Text>
            <RNPicker
              dataSource={statelist.states}
              dummyDataSource={statelist.states}
              defaultValue={false}
              pickerTitle={"Select State"}
              showSearchBar={true}
              disablePicker={false}
              changeAnimation={"none"}
              searchBarPlaceHolder={"Search....."}
              showPickerTitle={true}
              placeHolderText={"Select a State"}              
              selectedLabel={data.selStatetemp}              
            // dropDownImage={require("./res/ic_drop_down.png")}
              selectedValue={(index, item) => {
                console.log('sel state');
                console.log(item);
                        setData({
                              ...data,
                              selStatetemp:item.name,
                              selDisttemp:'' })
                            getDistList(item.name);}
              }
            />
            <Text style={styles.getStartedText}>Select District</Text>
            <RNPicker
              dataSource={statelist.district}
              dummyDataSource={statelist.district}
              defaultValue={false}
              pickerTitle={"Select District"}
              showSearchBar={true}
              disablePicker={false}
              changeAnimation={"none"}
              searchBarPlaceHolder={"Search....."}
              showPickerTitle={true}
              placeHolderText={"Select a District"}
              selectedLabel={data.selDisttemp}
            // dropDownImage={require("./res/ic_drop_down.png")}
              selectedValue={(index, item) => {
                     setData({
                              ...data,
                              //selState:item,
                              selDisttemp:item.name })
              }}
            />
            </View>
            <View style={styles.btncontainer}>
                      <View style={styles.buttonCol}>
                        <TouchableOpacity
                          onPress={() => {
                            setIsModalVisible(false);
                          }}  
                          style={[styles.buttonSave,{backgroundColor: 'coral'}]}>
                          <Text style={styles.modalbtnText}>Cancel</Text>
                        </TouchableOpacity>
                      </View>
                      <View style={styles.buttonCol}>
                        <TouchableOpacity        
                          onPress={selectDist}                  
                          style={[styles.buttonSave,{backgroundColor: 'teal'}]}>
                          <Text style={styles.modalbtnText}>Select District</Text>
                        </TouchableOpacity>
                      </View>
              </View>         
      </View>
  </Modal>
        
      </View>
    );
};

export default MainScreen;

const styles = StyleSheet.create({
  container: {
    flex: 1, 
    alignItems: 'center', 
    justifyContent: 'center'
  },
  modalcontainer:{
    width:'100%',
   // alignItems: 'center',
    padding:30,
    flex: 1,
    backgroundColor:  '#fff2e2',
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
    paddingBottom:20,
    borderWidth: 1,
    borderColor: 'gray',
  },
  scrollcontainer:{
    width:'100%',
    alignItems: 'center',
    flex: 1,
    backgroundColor:  '#fff2e2', //c2185B
  },
  row: {
    width:'100%',
    flexDirection: 'column',
    margin: 25,
    //backgroundColor:  '#ff00e2',
    flex:1
	},
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
    height: 60,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
  }, 
  buttonCol: {
    flex: 1,
  },
  modalbtnText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 18,
    margin: 5,
  },
  getStartedText: {
    fontSize: 14,
    color: 'black',
    lineHeight: 18,
    textAlign: 'left',
    marginLeft: 10,
    paddingTop:10,
    paddingBottom:10,
    //marginTop:4,
    },
  btnText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 24,
    margin: 5,
  },
  widget: {
		height:60,
    //flex: 1,
    margin:10,
    borderRadius: 5,
    padding: 0,
    justifyContent: 'center',
    alignItems: 'center'
  },
  headerText:{
    fontWeight: 'bold',paddingBottom:20,paddingTop:20,
    fontSize: 16,
            marginLeft: 10,
            color: 'black',
            lineHeight: 30,
            textAlign: 'left',
            marginBottom: 10,
  }
});
