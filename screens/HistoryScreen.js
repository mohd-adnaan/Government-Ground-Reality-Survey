import React,{useEffect} from 'react';
import { View, Text, Button, StyleSheet,FlatList,ImageBackground,Alert,
  TouchableOpacity,ActivityIndicator } from 'react-native';

  import { useFocusEffect, useIsFocused } from '@react-navigation/native';
import { openDatabase } from 'react-native-sqlite-storage';

const db=openDatabase({name:'sisdpgt.db',createFromLocation:1},function () {
  console.log('--getting database----');
  //this.setState({isLoading: true});
  },
  function () {
    console.log('--error----');
    //this.setState({isLoading: true});    
  });

const HistoryScreen = ({navigation}) => {
  const isFocused=useIsFocused();

const [data,setData]=React.useState({ 
      isLoading: true,
		  FlatListItems: [],
		  sel_id:[]
  });
const selectItem = seldata => {

  console.log(seldata.item.obssts);	
  if(seldata.item.obssts=='Sent'){
    return false;
  }
  else{
    
//	data.item.isSelect = data.item.isSelect;
    // reset all to false
    console.log(seldata.item.id);
    let sel_id=seldata.item.id;

    data.FlatListItems.forEach((value, key) => {
      if(value.id!=sel_id){	
        data.FlatListItems[key].selectedClass=styles.list;
      }
      else{					
        seldata.item.selectedClass=styles.selected;
      }
    });
   setData({
    ...data,
    sel_id: sel_id,
    sel_data_item:seldata.item,
    obssts:seldata.item.obssts
  });
}
};
const ListViewItemSeparator = () => {
  return (
    <View style={{ height: 0.5, width: '100%', backgroundColor: '#808080' }} />
  );
  };
  const sendToServer =async(id)=>
  {
    //(tx, results)
    console.log('id:  '+id);
    let obs_data=[];
    db.transaction((tx) => {
      tx.executeSql("select * from geotagTbl where id=?", [id], 
      (_, { rows }) =>{
        
        obs_data=rows.item(0);
    
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
      if (response.success == "true") {
        console.log('geotagTbl uploaded with id '+id);
        Alert.alert("Success",response.updateInfo,
        [{ text: 'OK', onPress: () => {                
					db.transaction(tx => {
						tx.executeSql("update geotagTbl set obssts=(?) where id = ?", ['Sent',id],(tx, results)  =>{
								console.log(results);
							  setData({...data, isLoading: false });  								
                 refreshData();   
							
							},(t,error)=>{                
                 setData({...data, isLoading: false });  
								console.log(error);
								console.log(t);								
							  setData({...data, isLoading: false });  
							})							
					}); 
                   // this.resetModalForm();   
          }
                },
              ],
              { cancelable: false }
        ); 
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
      }
      );
      });
      
     // setData({...data, isLoading: false });
  }

const sendClicked=async()=>{
  if (data.sel_id>0){
    Alert.alert(
			'Confirm' ,
			//'Selected Item # '+this.state.sel_id+'  
			'Do you want to submit the data to server?',
			[
				{ text: 'Cancel', onPress: () => console.log('Cancel Pressed!') },
				{
					text: 'Yes', onPress: () => {
						setData({...data, isLoading: true });
						sendToServer(data.sel_id);
					}
				},
			],
			{ cancelable: true }
		); 
  }
  else{
    Alert.alert(
      'Alert' ,
      'No Record Selected'
    );	
  }
}

const delDataClicked = async () => {
  console.log(data.sel_id);
	
	if (data.sel_id>0){
		Alert.alert(
			'Confirm' ,
			'Do you really want to delete this observtion?',
			[
				{ text: 'Cancel', onPress: () => console.log('Cancel Pressed!') },
				{ text: 'Yes', onPress: () => {
					let sel_id_remove=data.sel_id;
					console.log(sel_id_remove);
					sel_id_remove=sel_id_remove.toString();
					db.transaction(
						tx => {
						tx.executeSql("delete from geotagTbl where id in (?)", [sel_id_remove],(tx, results)  =>{
							console.log(sel_id_remove);
									console.log(results);
									refreshData();
								//	console.log(tx.sql);
							
							},(t,error)=>{
								console.log(error);
								console.log(t);
							}
						);
						// tx.executeSql("select * from ubaSurveyTbl", [],(tx, results)  =>{
						// 	//console.log(JSON.stringify(rows));
						// 			console.log(results.rows.length);
						// 	var temp = [];
						// 	for (let i = 0; i < results.rows.length; ++i) {
						// 		let item=results.rows.item(i);
						// 	//	item['isSelect']=false;
						// 		item['selectedClass']=styles.list;
						// 		temp.push(item);
						// 	//	temp.push(results.rows.item(i));
						// 	//	console.log(item);
						// 	}
						// 	this.setState({
						// 		FlatListItems: temp,
						// 		sel_id:[]
						// 	});
						// 	},(t,error)=>{
						// 		console.log(error);
						// 	}
						// );
						},
				function(error){
					console.log(error);
				},
				function () {
					console.log('--history----');
					}
			);
			}
		}
		],
		{ cancelable: true }
		);     
	  
		}
		else{
			console.log('no data selected');
			Alert.alert(
				'Alert' ,
				'No Record Selected'
			);
		}
}
const  renderItem = seldata =>
    <TouchableOpacity key={seldata.item.id}
    style={[styles.list, seldata.item.selectedClass]}      
    onPress={() => selectItem(seldata)}
    >
    <View  style={styles.rowcontainer}>
    <Text>GT Observation: {seldata.item.seldist}</Text>   
    <Text>{seldata.item.l1class} > {seldata.item.l2class} > {seldata.item.l3class} > {seldata.item.regdisc}  {seldata.item.otherclass}</Text>
    <Text>Saved on {seldata.item.timestamp}</Text>  
    <View style={styles.imgcontainer}>
    <ImageBackground source={{ uri: 'data:image/jpeg;base64,'+seldata.item.photob640 }}
          resizeMode="contain"
          // onPress={() => this._imagePress(index)}
          style={{ width: 70, height: 60, borderWidth: 1, marginLeft: 10 }}>
    </ImageBackground>
    {seldata.item.photob641 ?(
    <ImageBackground source={{ uri:'data:image/jpeg;base64,'+ seldata.item.photob641 }}
          resizeMode="contain"
          // onPress={() => this._imagePress(index)}
          style={{ width: 70, height: 60, borderWidth: 1, marginLeft: 10 }}>
    </ImageBackground>):null
    }
    <Text style={styles.stsText}>{seldata.item.obssts}</Text>
    </View> 
    </View>      
    </TouchableOpacity> 
  
const refreshData=async()=>{
 
  db.transaction(
		tx => {		
		tx.executeSql("select * from geotagTbl order by id DESC", [],(tx, results)  =>{
			//	console.log(JSON.stringify(results));
				console.log(results.rows.length +" records found in history");
				if(results.rows.length==0){
					Alert.alert("Alert","No Saved Records!");			
					setData({
            ...data,
						isLoading: false,
						FlatListItems: [],
						sel_id:[]
					});
				}
				else{					
				var temp = [];
				for (let i = 0; i < results.rows.length; ++i){
					let item=results.rows.item(i);
				//	item['isSelect']=false;
					item['selectedClass']=styles.list;
					temp.push(item);
				//	temp.push(results.rows.item(i));
				//	console.log(item);
				}
				setData({
          ...data,
					isLoading: false,
					FlatListItems: temp,
          sel_id:[]
				});
		}},
			(t,error)=>{
				console.log(error);
				Alert.alert("Alert","No Saved Records!");			
				setData({
          ...data,
					isLoading: false,
					FlatListItems: [],
				});
			}
		);
		},
		function(error){
			console.log(error);
		},
		function () {
			console.log('--history----');
			//this.setState({isLoading: true});
			}
	);	
}
// useFocusEffect(() => {
//   console.log('use focus effect');
//     refreshData();
 

// },[]

// )


useEffect(() => {
  if (isFocused){
    console.log('use effect');
      refreshData();
  }
},[isFocused]);

// if(data.isLoading){
//   return(
//     <View style={{flex: 1, justifyContent: 'center', padding: 20,flexDirection: 'row',justifyContent: 'space-around'}}>
//     <ActivityIndicator size="large" color="#0000ff"/>
//     </View>
//   )
//   }

//	this.getHistoryData();
  //const { navigate } = this.props.navigation;
return (data.isLoading) ? (
  <View style={styles.loading} >
      <ActivityIndicator size="large" color="#0000ff"/>
  </View>

): (      
        <View style={styles.container}>	   
            <FlatList
              data={data.FlatListItems}
          ItemSeparatorComponent={ListViewItemSeparator}
              keyExtractor={(item, id) => id.toString()}
          renderItem={ item => renderItem(item)}		
          //extraData={data}
              />
          <View style={styles.btncontainer}>
    
          <View style={styles.buttonCol}>
          <TouchableOpacity
            onPress={delDataClicked}
            style={styles.buttonSave}>
            <Text style={styles.btnText}>Delete</Text>
          </TouchableOpacity>
          </View>          
          <View style={styles.buttonCol}>
          <TouchableOpacity
            onPress={sendClicked}
            style={styles.buttonSave}>
            <Text style={styles.btnText}>Send Now</Text>
          </TouchableOpacity>
          </View>
          </View>
          </View>      
    );
};

export default HistoryScreen;

const styles = StyleSheet.create({
  // container: {
  //   flex: 1, 
  //   alignItems: 'center', 
  //   justifyContent: 'center'
  // },

  container:{
    flex: 1,
    backgroundColor: "#e0f0e3",
    //paddingVertical: 50,
    position: "relative"
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
rowcontainer:{
  flex: 1,
  padding:5,
},
selected: {backgroundColor: "#ffc8bc"},
list: {
  padding: 5,
  margin: 5,
  flexDirection: "row",
  backgroundColor: "#ffffff",
  justifyContent: "flex-start",
  alignItems: "center",
  zIndex: -1
  },
btn1:{
  backgroundColor:'orange',
  padding:10,margin:10,width:'95%'
},
btnText: {
  color: '#fff',
  textAlign: 'center',
  fontWeight: 'bold',
  fontSize: 18,
  marginTop: 5,
},
buttonCol: {
  flex: 1,
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
buttonSend: {
  // width:200,
  padding: 0,
  marginLeft: 2,
  marginRight: 4,
  height: 36,
  backgroundColor: 'coral',
  alignItems: 'center',
},
// buttonCancel: {
//   // width:200,
//   padding: 0,
//   marginLeft: 4,
//   marginRight: 2,
//   height: 36,
//   backgroundColor: 'coral',
//   alignItems: 'center',
//   },
//   buttonSave: {
//   // width:200,
//   padding: 0,
//   marginLeft: 4,
//   marginRight: 2,
//   height: 36,
//   backgroundColor: 'orange',
//   alignItems: 'center',
//   },
  btncontainer: {
    borderWidth:1,borderColor:'gray',
    backgroundColor:  '#fff2e2',
  height: 45,
  flexDirection: 'row',
  alignItems: 'center',
  justifyContent: 'center',
  },
  imgcontainer:{
    flex:1,
    marginLeft: 5,
    marginTop: 5,
  height: 65,
  flexDirection: 'row',
  alignItems: 'flex-end',
  },
  stsText:{
    flex: 1,
    paddingRight: 10,
    textAlign: 'right',
    color: '#00f',
    fontWeight: 'bold',
    fontSize: 14,
  }

});
