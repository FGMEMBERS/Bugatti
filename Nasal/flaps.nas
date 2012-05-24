# ======================================================================================
# Deploys or retracts flaps, spoilers and gear based on speed and thrust levers position
#
# 2011/2012 Philippe BROCORENS - OO ZVY
# ======================================================================================

interpolation = func(speed,flapsminspeed,flapsmaxspeed,flapsmin,flapsmax )
{
  x= flapsmin + ( flapsmax-flapsmin ) / (flapsmaxspeed-flapsminspeed) * (speed-flapsminspeed );
  return x;
}    

# ======================================================================================
# Flaps
# ======================================================================================
var autoflaps = func {
  var thrustlever = getprop("/controls/engines/engine/throttle");
  var airspeed = getprop("/velocities/airspeed-kt");

  if  (airspeed > 80 and airspeed < 150) {	
    if (thrustlever < 0.9) {
      setprop("/controls/flight/flaps", interpolation(airspeed,80,150,1,0.1));
    }
    else {
      setprop("/controls/flight/flaps", interpolation(airspeed,80,150,0.5,0.1));   
    }         
  } 

  if ( airspeed >= 150 and airspeed < 180 ) {
    if ( thrustlever < 0.05 ) {
      setprop("/controls/flight/flaps", 1);
    }
    else {
      setprop("/controls/flight/flaps", 0.1);
    }
  }

  if ( airspeed >= 180 ) {
    if ( thrustlever < 0.05 ) {
      setprop("/controls/flight/flaps", 1);
    }
    else {
      setprop("/controls/flight/flaps", 0);
    }
  }

  if ( airspeed <= 80 ) {
    if (thrustlever < 0.9) {
      setprop("/controls/flight/flaps", 1.0);
    }
    else {
      setprop("/controls/flight/flaps", 0.5);
    }
  }

  settimer(autoflaps,0);
}
autoflaps();

# ======================================================================================
# Gears
# ======================================================================================
var autogear = func {
  var airspeed = getprop("/velocities/airspeed-kt");
  if ( airspeed < 100 ) {
    setprop("/controls/gear/gear-down", 1);
  }
  else {
    setprop("/controls/gear/gear-down", 0);
  }

  settimer(autogear,0);
}
autogear();

# ======================================================================================
# Spoilers
# ======================================================================================
var autospoiler = func {
  var thrustlever = getprop("/controls/engines/engine/throttle");     
  var airspeed = getprop("/velocities/airspeed-kt");
 		 
  if ( airspeed >= 180 ) {
    if ( thrustlever < 0.05) {
      setprop("/controls/flight/spoilers", 1);
    }
    else {
      setprop("/controls/flight/spoilers", 0.2);
    }
  }

  if ( airspeed >= 150 and airspeed < 180 ) {
    if ( thrustlever < 0.05 ) {
      setprop("/controls/flight/spoilers", 1);
    }
    else {
      setprop("/controls/flight/spoilers", 0.1);
    }
  }

  if ( airspeed <= 80 ) {
    if ( thrustlever < 0.9 ) {
      setprop("/controls/flight/spoilers", 0.1);
    }
    else {
      setprop("/controls/flight/spoilers", 0);
    }
  }

  if  (airspeed > 80 and airspeed < 150) {	
    if (thrustlever < 0.9) {
      setprop("/controls/flight/spoilers", 0.1);
    }
    else {
      setprop("/controls/flight/spoilers", interpolation(airspeed,80,150,0,0.1));
    }  
  }  

  settimer ( autospoiler,0);
}
autospoiler();

