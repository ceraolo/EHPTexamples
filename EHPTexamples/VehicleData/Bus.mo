within EHPTexamples.VehicleData;
record Bus
  parameter Real m = 16000;
  parameter Real ratio = 6;
  parameter Real radius = 0.5715;
  parameter Real J = 5;
  //Costante H=5s
  parameter Real Cx = 0.65;
  parameter Real S = 6;
  parameter Real fc = 0.013;
  parameter Real rho = 1.226;
  parameter Real kContr = 1000;
  annotation (
    Icon(coordinateSystem(preserveAspectRatio = false), graphics={  Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {162, 29, 33}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-94, 22}, {96, -16}}, lineColor = {162, 29, 33}, textString = "Bus"), Text(extent = {{-100, -104}, {100, -140}}, lineColor = {0, 0, 255}, textString = "%name")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)));
end Bus;
