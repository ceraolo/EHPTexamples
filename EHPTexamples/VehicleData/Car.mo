within EHPTexamples.VehicleData;
record Car
  parameter Modelica.Units.SI.Mass m = 1300;
  parameter Real ratio = 10;
  parameter Modelica.Units.SI.Length radius = 0.31;
  parameter Modelica.Units.SI.MomentOfInertia J = 0.4;
  parameter Real Cx = 0.26;
  parameter Modelica.Units.SI.Area S = 2.2;
  parameter Real fc = 0.014;
  parameter Modelica.Units.SI.Density rho = 1.225;
  //1 atm, 15deg C
  parameter Modelica.Units.SI.Power MaxPower = 100e3;
  parameter Modelica.Units.SI.Torque MaxTorque = 150;
  parameter Modelica.Units.SI.AngularVelocity MaxOmega = 1000;
  parameter Real kContr(unit = "N.m/(m/s)") = 100;
  /* Per il calcolo di J abbiamo usato Tavv=2s, Pn=50kW, Wbase= quella 
                                                                                                                                                                                                                                                     corrispondente a 36 km/h, quindi 252 rad/s*/
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics={  Rectangle(lineColor = {162, 29, 33}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(origin = {-6, 74}, lineColor = {162, 29, 33}, extent = {{-94, 22}, {106, -16}}, textString = "Car"), Text(origin = {-6, -58}, lineColor = {0, 0, 255}, extent = {{-94, 22}, {106, -16}}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end Car;
