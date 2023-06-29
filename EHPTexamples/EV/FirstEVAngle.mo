within EHPTexamples.EV;
model FirstEVAngle "Simulates a very basic Electric Vehicle"
  import Modelica;
  extends Modelica.Icons.Example;
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = 6) annotation (
    Placement(visible = true, transformation(origin = {-14, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (
    Placement(visible = true, transformation(extent = {{-82, 10}, {-62, 30}}, rotation = 0)));
  EHPTlib.SupportModels.Miscellaneous.PropDriver driver(extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, k = 1000, yMax = 100000.0, CycleFileName = "TestAngle.txt") annotation (
    Placement(visible = true, transformation(extent = {{-118, 10}, {-98, 30}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 1300) annotation (
    Placement(visible = true, transformation(extent = {{34, 10}, {54, 30}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor velSens annotation (
    Placement(visible = true, transformation(origin = {60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.5715) annotation (
    Placement(visible = true, transformation(extent = {{4, 10}, {24, 30}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 5) annotation (
    Placement(visible = true, transformation(extent = {{-54, 10}, {-34, 30}}, rotation = 0)));
  EHPTlib.SupportModels.Miscellaneous.DragForceAngle dragF(Cx = 0.65, S = 6.0, fc = 0.013, m = mass.m, rho = 1.226, DataFileName = "Angle1.txt") annotation (
    Placement(visible = true, transformation(origin = {82, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
equation
  connect(velSens.flange, mass.flange_b) annotation (
    Line(points = {{60, 0}, {60, 20}, {54, 20}}, color = {0, 127, 0}));
  connect(driver.V, velSens.v) annotation (
    Line(points = {{-108, 8.8}, {-108, -36}, {60, -36}, {60, -21}}, color = {0, 0, 127}));
  connect(mass.flange_a, wheel.flangeT) annotation (
    Line(points = {{34, 20}, {24, 20}}, color = {0, 127, 0}));
  connect(inertia.flange_a, torque.flange) annotation (
    Line(points = {{-54, 20}, {-58, 20}, {-62, 20}}));
  connect(inertia.flange_b, gear.flange_a) annotation (
    Line(points = {{-34, 20}, {-24, 20}}));
  connect(gear.flange_b, wheel.flangeR) annotation (
    Line(points = {{-4, 20}, {-4, 20}, {4, 20}}));
  connect(torque.tau, driver.tauRef) annotation (
    Line(points = {{-84, 20}, {-97, 20}}, color = {0, 0, 127}));
  connect(dragF.flange, mass.flange_b) annotation (
    Line(points = {{82, -14}, {82, 20}, {54, 20}}, color = {0, 127, 0}));
  annotation (
    experimentSetupOutput(derivatives = false),
    Documentation(info = "<html><head></head><body><p>Basic EV model with resistance to movement which includes slope.</p><p>Note that the model is only partially working since it is not able to stop the vehicle with negative angles when zero speed is needed.&nbsp;</p><p>Check the variable dragF.locked when the driver cycle is Sort1.txt: for t=80-100s the requested speed is zero, but the variable dragF.locked remains false.</p><p>Fixing this requires implementing a totally different driver's model, since the driver in these cases must explicitly push on the brake pedal, often requesting a strong negative torque. This enhanced driver model is out of the scope of the EHPTlib library.</p>
</body></html>"),
    Commands,
    Diagram(coordinateSystem(extent = {{-120, -40}, {100, 40}}, preserveAspectRatio = false), graphics={  Rectangle(origin = {-6, 0}, lineColor = {28, 108, 200}, pattern = LinePattern.Dash, extent = {{-84, 36}, {-24, 4}}), Text(origin = {-6, 0}, lineColor = {28, 108, 200}, pattern = LinePattern.Dash, extent = {{-82, 2}, {-26, -4}}, textString = "electric drive")}),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    experiment(StopTime = 200, Interval = 0.1),
    __OpenModelica_simulationFlags(jacobian = "", s = "dassl", lv = "LOG_STATS"),
    __OpenModelica_commandLineOptions = "");
end FirstEVAngle;
