
importScripts( "https://www.gstatic.com/firebasejs/8.2.4/firebase-app.js" );
importScripts( "https://www.gstatic.com/firebasejs/8.2.4/firebase-messaging.js" );


var firebaseConfig = {
    "apiKey": "AIzaSyAV0c4MPfug-hSJYU8bT5pADkpaUadCYGU",
    "authDomain": "selfandpay.firebaseapp.com",
    "databaseURL": "https://selfandpay.firebaseio.com",
    "projectId": "selfandpay",
    "storageBucket": "selfandpay.appspot.com",
    "messagingSenderId": "858174338114",
    "appId": "1:858174338114:web:1f7773702de59dc336e9db",
    "measurementId": "G-G1ZWS0D01G"
};
firebase.initializeApp( firebaseConfig );


const messaging = firebase.messaging();
console.log( 'Registrando serviceWorker' );

messaging.onBackgroundMessage(function(payload) {
    console.log('[firebase-messaging-sw.js] Received background message ', payload);
    const notificationTitle = 'Background Message Title';
    const notificationOptions = {
      body: 'Background Message body.',
      icon: '/firebase-logo.png'
    };
  
    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });
