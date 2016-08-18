%
% BigBrother
% 
% Description:This app demonstrates the target detection ability of Walabot. A human head follows you with his look as you move around the room. 
%
% The Walabot device should be positioned in the following manner:
% The devices' clear side should face you (The side with the logo is on the back) 
% The longer dimension of the device is in parallel to the floor
% The USB connector is at your right
%
% In order to run the script, the following files should be loaded to the
% Workspace: 
% GetClosestTarget.m
% HUMAN_HEAD3D.m
% STL_Import.m
% human-head.stl


% ****************Setup variables**********************
% Define Arena and Threshold (Where R_in=[R_min,R_max,R_resolution] and similarly for Theta_in and Phi_in )
R_in=[10,100,10];
Theta_in=[-30,30,10];
Phi_in=[-70,70,10];
Threshold=60;
% ****************App variables **********************
WindSize=15; % Window size (number of Walabot targets considered at each loop iteration) 
ExtraSamp=3; % Number of new Walabot targets taken at each loop iteration (starting from the 2nd iteration and on)

%***********************************

flag=0; % Flag for first iteration of the loop (flag=1 after first iteration)
result2=zeros(3,WindSize); % Matrix of the coordinates of targets detected 

% Setup
global API
asm=NET.addAssembly('C:\Program Files\walabot\WalabotSDK\bin\x64\WalabotAPI.NET.dll');

import WalabotAPI_NET.*;
API = WalabotAPI_NET.WalabotAPI();
API.SetSettingsFolder('C:\ProgramData\Walabot\WalabotSDK');


API.ConnectAny();

% Set Sensor Profile:
PROF_SENSOR=WalabotAPI_NET.APP_PROFILE.PROF_SENSOR;
MTI_Filter=WalabotAPI_NET.FILTER_TYPE.FILTER_TYPE_MTI ;
API.SetProfile(PROF_SENSOR);

% Set Threshold:
API.SetThreshold(Threshold);
% Set Arena:
API.SetArenaR(R_in(1),R_in(2),R_in(3));
API.SetArenaTheta(Theta_in(1),Theta_in(2),Theta_in(3));
API.SetArenaPhi(Phi_in(1),Phi_in(2),Phi_in(3));
% Set Filter Type
API.SetDynamicImageFilter(MTI_Filter);

% Activate walabot sensor (Start and calibrate)
API.Start();
API.GetStatus();
API.StartCalibration();
API.GetStatus();


% Display human head in default position
HUMAN_HEAD3D();
view(0,0);
 
% Begin Loop
while true

  if flag==0 % if first iteration of loop

    % Get Targets
    for k=1:WindSize
       % Trigger and get Sensor Targets
       API.Trigger();
       result=API.GetSensorTargets();

       Vec=GetClosestTarget(result); % Get closest target out of the available sampled targets

          if size(Vec)==[0,1]
             continue
          else
             result2(1,k)=Vec(1,1);
             result2(2,k)=Vec(2,1);
             result2(3,k)=Vec(3,1);
          end
    end

   flag=1; % First loop iteration done- set flag to 1


  else % Not the first loop iteration
  % Shift the last sampled #(WindSize-ExtraSamp) targets' coordinates to the beggining of the matrix result2
     for k=(ExtraSamp+1):WindSize 
         result2(1,k-ExtraSamp)=result2(1,k);
         result2(2,k-ExtraSamp)=result2(2,k);
         result2(3,k-ExtraSamp)=result2(3,k);
     end
     
     % Take new #ExtraSamp target cooardunates and insert them to the matrix result2 
     for k=1:ExtraSamp
         % Trigger and get Sensor Targets
         API.Trigger();
         result=API.GetSensorTargets();

         Vec=GetClosestTarget(result); % Get closest target out of the avilable sampled targets

           if size(Vec)==[0,1]
              continue
           else
              result2(1,WindSize-k)=Vec(1,1);
              result2(2,WindSize-k)=Vec(2,1);
              result2(3,WindSize-k)=Vec(3,1);
           end
     end
      
 end

Vavg=median(result2,2); % Take the median target location out of the loop's sampled target cooardinates
     
% Calculate the azimuth and elevation angles of the target
azim=atan2(Vavg(3,1),Vavg(2,1));
elv=atan2(Vavg(1,1),sqrt(Vavg(2,1)^2+Vavg(3,1)^2));

azimDeg=90-azim*180/pi;
elvDeg=elv*180/pi;

% Set upper and lower bounds on the possible azimuth and elevation angles
if abs(azimDeg)>90
    if azimDeg<0
        azimDeg=-90;
    else
        azimDeg=90;
    end
end

if abs(elvDeg)>89
    if elvDeg<0
        elvDeg=-89;
    else
        elvDeg=89;
    end
end


% Move Human Head To look At The Target
view(azimDeg,elvDeg);
pause(0.1);

end