within EHPTexamples.EV;
model FirstEVpow "Simulates a very basic Electric Vehicle"
  import Modelica;
  extends Modelica.Icons.Example;
  EHPTlib.SupportModels.Miscellaneous.DragForce dragF(Cx = 0.26, S = 2.2,
  fc = 0.014, m = mass.m, rho(displayUnit = "kg/m3") = 1.226,  v(start=0, fixed=true)) annotation (
    Placement(visible = true, transformation(origin = {100, -22}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = 4, flange_b(
        phi(start=0, fixed=true))) annotation (
    Placement(visible = true, transformation(origin = {-8, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque torque annotation (
    Placement(visible = true, transformation(extent = {{-76, 10}, {-56, 30}}, rotation = 0)));
  EHPTlib.SupportModels.Miscellaneous.PropDriver driver(CycleFileName = Modelica.Utilities.Files.loadResource("modelica://EHPTexamples/Resources/Sort1.txt"), extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, k = 1000, yMax = 100000.0) annotation (
    Placement(visible = true, transformation(extent = {{-112, 8}, {-92, 28}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 1300) annotation (
    Placement(visible = true, transformation(extent = {{54, 10}, {74, 30}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor velSens annotation (
    Placement(visible = true, transformation(origin = {78, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.31) annotation (
    Placement(visible = true, transformation(extent = {{10, 10}, {30, 30}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 1.5) annotation (
    Placement(visible = true, transformation(extent = {{-48, 10}, {-28, 30}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor mP2 annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {100, 6})));
  Modelica.Mechanics.Translational.Sensors.PowerSensor mP1 annotation (
    Placement(transformation(extent = {{36, 12}, {52, 28}})));
equation
  connect(torque.tau, driver.tauRef) annotation (
    Line(points={{-78,20},{-84,20},{-84,18},{-91,18}},
                                          color = {0, 0, 127}));
  connect(driver.V, velSens.v) annotation (
    Line(points={{-102,6.8},{-102,-36},{78,-36},{78,-21}},          color = {0, 0, 127}));
  connect(inertia.flange_b, gear.flange_a) annotation (
    Line(points = {{-28, 20}, {-18, 20}}));
  connect(inertia.flange_a, torque.flange) annotation (
    Line(points = {{-48, 20}, {-52, 20}, {-56, 20}}));
  connect(gear.flange_b, wheel.flangeR) annotation (
    Line(points = {{2, 20}, {2, 20}, {10, 20}}));
  connect(velSens.flange, mass.flange_b) annotation (
    Line(points = {{78, 4.44089e-016}, {78, 20}, {74, 20}}, color = {0, 127, 0}));
  connect(mP2.flange_b, dragF.flange) annotation (
    Line(points = {{100, -4}, {100, -12}}, color = {0, 127, 0}));
  connect(mP2.flange_a, mass.flange_b) annotation (
    Line(points = {{100, 16}, {100, 20}, {74, 20}}, color = {0, 127, 0}));
  connect(mass.flange_a,mP1. flange_b) annotation (
    Line(points = {{54, 20}, {54, 20}, {52, 20}}, color = {0, 127, 0}));
  connect(wheel.flangeT,mP1. flange_a) annotation (
    Line(points = {{30, 20}, {34, 20}, {36, 20}}, color = {0, 127, 0}));
  annotation (
    Documentation(info = "<html>
<p>Very basic introductory EV model with power measurements.</p>
</html>"),
    Diagram(coordinateSystem(extent = {{-120, -40}, {120, 40}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics={  Rectangle(extent = {{-84, 36}, {-24, 4}}, lineColor = {28, 108, 200}, pattern = LinePattern.Dash), Text(extent = {{-82, 2}, {-26, -4}}, lineColor = {28, 108, 200}, pattern = LinePattern.Dash, textString = "electric drive")}),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    experiment(StartTime = 0, StopTime = 200, Tolerance = 0.0001, Interval = 0.1));
end FirstEVpow;
