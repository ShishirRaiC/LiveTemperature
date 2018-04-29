// Initialize Firebase
var config = {
    apiKey: "AIzaSyDPkFUJXTNqM9rs9TxzwXi_GOuiODC82_w",
    authDomain: "live-temperature-9acef.firebaseapp.com",
    databaseURL: "https://live-temperature-9acef.firebaseio.com",
    projectId: "live-temperature-9acef",
    storageBucket: "live-temperature-9acef.appspot.com",
    messagingSenderId: "401403875226"
};
firebase.initializeApp(config);

// window.addEventListener("load", getData(genFunction));

// function getData(callbackIN) {
//     // var ref = firebase.database();

//     var currentDate = new Date();
//     var date = new Date();
//     date.setDate(date.getDate() - 1);

//     var timestamp = date.getTime() / 1000;


//     timeLabels = []
//     tempDate = date;
//     for (i = 0; i < 24; i++) {
//         timeLabels.push(tempDate.getHours())
//         tempDate.setTime(tempDate.getTime() + (60 * 60 * 1000))
//     }

//     console.log(timeLabels)
//         // var ref = firebase.database().ref('temp/all/').limitToLast(3);
//     var ref = firebase.database().ref('temp1/all');


//     console.log(timestamp)
//     console.log(new Date().getTime())

//     // ref.orderByChild("timestamp")
//     // .startAt(timestamp)
//     // .endAt(new Date().getTime())
//     // .once('value').then(function (snapshot){
//     //   callbackIN(snapshot.val())
//     // });
//     ref.orderByChild("timestamp")
//         .startAt(timestamp)
//         .endAt(new Date().getTime())
//         .on('value', function(snapshot) {
//             callbackIN(snapshot.val())
//         });


// }

// function genFunction(data) {
//     // console.log(Object.keys(data))
//     console.log(data)
//     var cdata = [];
//     var xlabels = [];
//     var arrayData = [];

//     for (var key in data) {
//         cdata.push({
//             label: data[key]['timestamp'],
//             value: data[key]['value']
//         })
//         arrayData.push({
//             "x": data[key]['timestamp'],
//             "y": data[key]['value']
//         })
//         xlabels.push(
//             data[key]['timestamp']
//         )

//     }
//     xlabesl = ['1524653873', '2524653873', '3524653873', '4524653873', '5524653873', '6524653873']
//     console.log(cdata)
//     console.log(arrayData)

//     console.log(JSON.stringify(arrayData))


//     /*
//           var cdata = [];
//           var len = data.length;
//           for(var i=1; i<10; i++) {
//             // console.log(data['-LA9K8RqBi86P6lQbnv6'])

//               // console.log(data[i].val())
              
//             cdata.push({
//               label: data[i]['timestamp'],
//               value: data[i]['value']
//             });
//           }
//     */


//     var firebaseChart = new FusionCharts({
//         type: 'area2d',
//         renderAt: 'chart-container',
//         width: '650',
//         height: '400',
//         dataFormat: 'json',
//         dataSource: {
//             "chart": {
//                 "caption": "Website Visitors Trend",
//                 "subCaption": "Last 7 Days{br}ACME Inc.",
//                 "subCaptionFontBold": "0",
//                 "captionFontSize": "20",
//                 "subCaptionFontSize": "17",
//                 "captionPadding": "15",
//                 "captionFontColor": "#8C8C8C",
//                 "baseFontSize": "14",
//                 "baseFont": "Barlow",
//                 "canvasBgAlpha": "0",
//                 "bgColor": "#FFFFFF",
//                 "bgAlpha": "100",
//                 "showBorder": "0",
//                 "showCanvasBorder": "0",
//                 "showPlotBorder": "0",
//                 "showAlternateHGridColor": "0",
//                 "usePlotGradientColor": "0",
//                 "paletteColors": "#6AC1A5",
//                 "showValues": "0",
//                 "divLineAlpha": "5",
//                 "showAxisLines": "1",
//                 "drawAnchors": "0",
//                 "xAxisLineColor": "#8C8C8C",
//                 "xAxisLineThickness": "0.7",
//                 "xAxisLineAlpha": "50",
//                 "yAxisLineColor": "#8C8C8C",
//                 "yAxisLineThickness": "0.7",
//                 "yAxisLineAlpha": "50",
//                 "baseFontColor": "#8C8C8C",
//                 "toolTipBgColor": "#FA8D67",
//                 "toolTipPadding": "10",
//                 "toolTipColor": "#FFFFFF",
//                 "toolTipBorderRadius": "3",
//                 "toolTipBorderAlpha": "0",
//                 "drawCrossLine": "1",
//                 "crossLineColor": "#8C8C8C",
//                 "crossLineAlpha": "60",
//                 "crossLineThickness": "0.7",
//                 "alignCaptionWithCanvas": "1"
//             },
//             "data": cdata
//         }
//     });

//     firebaseChart.render();
//     var chartData = cdata.map(function(e) {
//             return e.value;
//         })
//         //Convert JsonObject to JSON Array

//     // arrayData = [{"x":3,"y":4},{"x":2,"y":1}]

//     var ctx = document.getElementById('myChart').getContext('2d');
//     var myChart = new Chart(ctx, {
//         type: 'line',
//         data: {
//             datasets: [{
//                 // This dataset appears on the first axis
//                 yAxisID: 'first-y-axis'
//             }, {
//                 // This dataset appears on the second axis
//                 yAxisID: 'second-y-axis'
//             }]
//         },
//         options: {
//             scales: {
//                 yAxes: [{
//                     id: 'first-y-axis',
//                     type: 'linear'
//                 }, {
//                     id: 'second-y-axis',
//                     type: 'linear'
//                 }]
//             }
//         }
//     });