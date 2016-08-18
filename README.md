# BigBrother - A Walabot Application

This app demonstrates the target detection ability of Walabot. A human head follows you with his look as you move around the room.

* The code is written in Matlab.  
* The app was tested on Windows 10.  

## How to use

1. Install the [Walabot SDK](http://walabot.com/getting-started).
2. Position the Walabot as  instructed below.
3. Download and add the app files.
3. Run `BigBrother.m` and start moving! :eyes:

**IMPORTANT NOTE:** Current Walabot settings are for vMaker18.

### Positioning the Walabot

The Walabot device should be positioned in the following manner:  
* The devices' clear side should face you (The side with the logo is on the back).
* The longer dimension of the device is in parallel with the floor.
* The USB connector is at your right.

![Positioning the Walabot](https://raw.githubusercontent.com/Walabot-Projects/Walabot-BigBrother/master/Walabot_BigBrotherL.PNG)

![Positioning the Walabot](https://raw.githubusercontent.com/Walabot-Projects/Walabot-BigBrother/master/Walabot_BigBrotherR.PNG)

## Editing the Code

At the top of the code you can find variables that can be changed easily without dealing with the "heavy" part of the code.  
All those variables should vary between different Walabot boards, operating systems, operating machines, etc.  
'Walabot Settings' variables are necessary to set the Walabot arena.  
'App Settings' variables are required for a proper flow of the app.

### Walabot Settings

* `R_in` - Walabot [`SetArenaR`](http://api.walabot.com/_walabot_a_p_i_8h.html#aac6cafa27c4a7d069dd64c903964632c) parameters.
* `Theta_in` -  Walabot [`SetArenaTheta`](http://api.walabot.com/_walabot_a_p_i_8h.html#a3832f1466248274faadd6c23127b998d) parameters.
* `Phi_in` - Walabot [`SetArenaPhi`](http://api.walabot.com/_walabot_a_p_i_8h.html#a9afb632b5cce965eba63b323bc579557) parameters.
* `Threshold` - Walabot [`SetThreshold`](http://api.walabot.com/_walabot_a_p_i_8h.html#a4a19aa1afc64d7012392c5c91e43da15) parameter.

A comprehensive explanation about the Walabot imaging features can be found [here](http://api.walabot.com/_features.html).

### App Settings

* `WindSize`: Number of sample Walabot targets considered at each loop iteration.
* `ExtraSamp`: Number of new Walbot targets taken at each loop iteration (starting from the 2nd iteration and on).
