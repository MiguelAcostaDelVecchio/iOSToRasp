// Use this file to do the following:
// 	- Turn on BLE (Bluetooth Low Energy) on your raspberry pi
//	- Setup dictionary for GPIO pins
//	- Create a primary service and corresponding characteristic to toggle specified GPIO pin

const bleno = require('bleno2');
const Gpio = require('onoff').Gpio;

const DEVICE_NAME = 'miguelRaspberryPi';

const gpioPins = {
  2: new Gpio(514, 'out'),
  3: new Gpio(515, 'out'),
  4: new Gpio(516, 'out'),
  5: new Gpio(517, 'out'),
  6: new Gpio(518, 'out'),
  7: new Gpio(519, 'out'),
  8: new Gpio(520, 'out'),
  9: new Gpio(521, 'out'),
  10: new Gpio(522, 'out'),
  11: new Gpio(523, 'out'),
  12: new Gpio(524, 'out'),
  13: new Gpio(525, 'out'),
  16: new Gpio(528, 'out'),
  17: new Gpio(529, 'out'),
  18: new Gpio(530, 'out'),
  19: new Gpio(531, 'out'),
  20: new Gpio(532, 'out'),
  21: new Gpio(533, 'out'),
  22: new Gpio(534, 'out'),
  23: new Gpio(535, 'out'),
  24: new Gpio(536, 'out'),
  25: new Gpio(537, 'out'),
  26: new Gpio(538, 'out'),
  27: new Gpio(539, 'out')
};

function togglePin(pinNumber) {
  const gpioPin = gpioPins[pinNumber];
  if (!gpioPin) {
    console.error(`Invalid GPIO pin number: ${pinNumber}`);
    return;
  }

  console.log(`Toggling GPIO pin: ${pinNumber}`);

  gpioPin.read((err, value) => {
    if (err) {
      throw err;
    }

    gpioPin.write(value ^ 1, err => {
      if (err) {
        throw err;
      }
      console.log(`GPIO pin ${pinNumber} is now ${(value ^ 1) ? 'ON' : 'OFF'}`);
    });
  });
}

bleno.on('stateChange', function(state) {
  if (state === 'poweredOn') {
    bleno.startAdvertising(DEVICE_NAME, ['1803']);
  } else {
    bleno.stopAdvertising();
  }
});

bleno.on('advertisingStart', function(error) {
  if (!error) {
    bleno.setServices([

      // Custom Service - GPIO Control Service
      new bleno.PrimaryService({
        uuid: '4f047921-f9bf-4aa6-8fe2-5346412d82a8',
        characteristics: [
          // Custom Characteristic - Toggle GPIO Pin
          new bleno.Characteristic({
            value: 0,
            uuid: 'dc5e32a4-aee2-4e0a-882f-d16d4862d3c3',
            properties: ['writeWithoutResponse'],
            onWriteRequest(data, offset, withoutResponse, callback) {
              console.log(`Received data: ${data}`);
              const pinNumber = data.readUInt8(0);
              console.log(`Parsed GPIO pin number: ${pinNumber}`);
              togglePin(pinNumber);
              callback(this.RESULT_SUCCESS);
            },
          }),
        ],
      }),

    ]); // end of bleno.setServices
  } // end of if statement
}); // end of bleno advertising
