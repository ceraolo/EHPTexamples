within EHPTexamples.PSD.BasicPT;
model PSBasic0 "Modello a due macchine elettriche ideali (pure inerzie)"
  import Modelica.Constants.*;
  parameter Real vMass = 1300;
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 3.905) annotation (
    Placement(transformation(extent = {{-24, 26}, {-4, 46}})));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.31) annotation (
    Placement(transformation(extent = {{0, 28}, {16, 44}})));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 1300, v(fixed = true, start = 33.333333333333, displayUnit = "km/h")) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {28, 26})));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragForce(fc = 0.014, S = 2.2, Cx = 0.26, m = mass.m, rho(displayUnit = "kg/m3") = 1.226) annotation (
    Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 90, origin = {27, -23})));
  Modelica.Mechanics.Rotational.Components.Inertia mot(w(fixed = false, displayUnit = "rpm"), J = 0.59) annotation (
    Placement(transformation(extent = {{-50, 26}, {-30, 46}})));
  Modelica.Mechanics.Translational.Sensors.PowerSensor Presis annotation (
    Placement(visible = true, transformation(origin = {28, -2}, extent = {{-8, -8}, {8, 8}}, rotation = 270)));
equation
  connect(dragForce.flange, Presis.flange_b) annotation (
    Line(points = {{27, -16}, {27, -10}, {28, -10}}, color = {0, 127, 0}));
  connect(Presis.flange_a, mass.flange_b) annotation (
    Line(points = {{28, 6}, {28, 16}}, color = {0, 127, 0}));
  connect(wheel.flangeR, idealGear.flange_b) annotation (
    Line(points = {{0, 36}, {-4, 36}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(idealGear.flange_a, mot.flange_b) annotation (
    Line(points = {{-24, 36}, {-24, 38}, {-26, 38}, {-26, 36}, {-30, 36}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(wheel.flangeT, mass.flange_a) annotation (
    Line(points = {{16, 36}, {28, 36}}, color = {0, 127, 0}));
  annotation (
    __Dymola_experimentSetupOutput,
    Documentation(info = "<html><head></head><body><h4>newInst OK</h4>
<h4>Basic model to show some funcionalitiea of a PSD-based power train</h4><p><u>Purpose f this simulation</u>:</p>
<p>to show the PSD operating points in a transient in which the vehicle decelerates as a consequence of only the resistances to movement (friction, aerodinamic drag) from &nbsp;120 km/h up to 0. The Internal Combustion Engine is kept at constant speed using a specific closed-loop control. The \"gen\" inertia is artificially enlarged, with reference to actual car's by a factor of 20. </p>
</body></html>",
           revisions = "<html><head></head><body>No NewInst</body></html>"),
    conversion(noneFromVersion = ""),
    Diagram(coordinateSystem(extent = {{-80, -40}, {60, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    Icon(coordinateSystem(extent = {{-80, -40}, {60, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 0.0001, Interval = 0.5));
end PSBasic0;
