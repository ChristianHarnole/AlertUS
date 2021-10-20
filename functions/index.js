const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { DataSnapshot } = require('firebase-functions/v1/database');
admin.initializeApp(functions.config().firebase);

exports.sendNotificationToPoliceTopic = functions.firestore.document('police reports/{uid}').onUpdate(async (event,) => {
    let content = event.after.get('police message');
    var message = {
        notification: {
            title: 'New Report',
            body: content,
        },
        topic: 'Police',
    };

    let response = await admin.messaging().send(message);
    console.log(response);
});
exports.sendNotificationToFireTopic = functions.firestore.document('fire reports/{uid}').onUpdate(async (event) => {
  let content = event.after.get('fire message');
  var message = {
      notification: {
        title: 'New Report', 
        body: content,
      },
      topic: 'Fire',
  };

  let response = await admin.messaging().send(message);
  console.log(response);
});
exports.sendNotificationToHospitalTopic = functions.firestore.document('hospital reports/{uid}').onUpdate(async (event) => {
  let content = event.after.get('hospital message');

  var message = {
      notification: {
        title: 'New Report',
          body: content,
      },
      topic: 'Hospital',
  };

  let response = await admin.messaging().send(message);
  console.log(response);
});
exports.sendNotificationToPoliceTopicOnCreate = functions.firestore.document('police reports/{uid}').onCreate(async (event,) => {
  let content = event.get('police message');
  var message = {
      notification: {
          title: 'New Report',
          body: content,
      },
      topic: 'Police',
  };

  let response = await admin.messaging().send(message);
  console.log(response);
});
exports.sendNotificationToFireTopicOnCreate = functions.firestore.document('fire reports/{uid}').onCreate(async (event) => {
  let content = event.get('fire message');
  var message = {
      notification: {
        title: 'New Report', 
        body: content,
      },
      topic: 'Fire',
  };

  let response = await admin.messaging().send(message);
  console.log(response);
});
exports.sendNotificationToHospitalTopicOnCreate = functions.firestore.document('hospital reports/{uid}').onCreate(async (event) => {
  let content = event.get('hospital message');

  var message = {
      notification: {
        title: 'New Report',
          body: content,
      },
      topic: 'Hospital',
  };

  let response = await admin.messaging().send(message);
  console.log(response);
});