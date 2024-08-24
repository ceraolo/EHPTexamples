within EHPTexamples.SHEV;
model SHEVpowerFilt "Ice, Generator, DriveTrain, all map-based"
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
    Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 0, origin = {-42, -2})));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.473) annotation (
    Placement(transformation(extent = {{-52, -46}, {-38, -32}})));
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = 10) annotation (
    Placement(transformation(extent = {{-78, -46}, {-64, -32}})));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 14000) annotation (
    Placement(transformation(extent = {{-8, -48}, {10, -30}})));
  Modelica.Mechanics.Translational.Sensors.PowerSensor powProp annotation (
    Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 0, origin = {-23, -39})));
  Modelica.Mechanics.Translational.Sensors.PowerSensor powDrag annotation (
    Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 0, origin = {45, -39})));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragForce(S = 6.5, fc = 0.01, Cx = 0.65, m = mass.m) annotation (
    Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 90, origin = {80, -48})));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor1 annotation (
    Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 270, origin = {26, -54})));
  Modelica.Blocks.Continuous.FirstOrder powFilt(y_start = 20e3, T = 500) annotation (
    Placement(visible = true, transformation(extent = {{12, 64}, {-4, 80}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = 100e3, uMin = 0) annotation (
    Placement(visible = true, transformation(extent = {{-14, 64}, {-30, 80}}, rotation = 0)));
  EHPTlib.SupportModels.Miscellaneous.PropDriver driver(CycleFileName = Modelica.Utilities.Files.loadResource("modelica://EHPTexamples/Resources/Sort1.txt"), extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, k = 500.0, yMax = 2e3) annotation (
    Placement(visible = true, transformation(extent = {{-94, 76}, {-74, 96}}, rotation = 0)));
  EHPTlib.MapBased.Genset genset(gsRatio = 1, mapsFileName = Modelica.Utilities.Files.loadResource("modelica://EHPTexamples/Resources/SHEVmaps.txt"), maxGenW = 300,
    maxSpeedNorm=600,                                                                                                                                                maxPow = 45000, maxTau = 500, wIceStart = 300) annotation (
    Placement(transformation(extent = {{-80, 8}, {-50, 38}})));
  EHPTlib.SupportModels.Miscellaneous.Batt1 battery(ICellMax = 500, QCellNom = 25 * 3600, R0Cell = 0.35E-3, efficiency = 0.9, iCellEfficiency = 100, ns = 100) annotation (
    Placement(visible = true, transformation(extent = {{0, 20}, {20, 40}}, rotation = 0)));
  EHPTlib.MapBased.OneFlangeFVCT drive(effTableName = "motEffTable",
     mapsFileName = "SHEVmaps.txt", effMapOnFile = false, powMax = 150e3, tauMax = 1000, wMax = 3000) annotation (
    Placement(visible = true, transformation(extent = {{68, 42}, {88, 22}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor gsPow annotation (
    Placement(visible = true, transformation(extent = {{-32, 24}, {-12, 44}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor drivePow annotation (
    Placement(visible = true, transformation(origin = {52, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(battery.n, drivePow.nv) annotation (
    Line(points = {{20.1, 24}, {24, 24}, {24, 14}, {52, 14}, {52, 26}, {52, 26}}, color = {0, 0, 255}));
  connect(drive.pin_p, drivePow.nv) annotation (
    Line(points={{68,28},{61,28},{61,26},{52,26}},                    color = {0, 0, 255}));
  connect(drivePow.nc, drive.pin_n) annotation (
    Line(points={{62,36},{66,36},{66,36},{68,36}},                    color = {0, 0, 255}));
  connect(gear.flange_a, drive.flange_a) annotation (
    Line(points={{-78,-39},{-84,-39},{-84,-14},{98,-14},{98,32},{88,32}}));
  connect(drive.tauRef, driver.tauRef) annotation (
    Line(points={{67.8,32},{67.8,32},{32,32},{32,86},{-73,86}},                 color = {0, 0, 127}));
  connect(gsPow.nv, genset.pin_n) annotation (
    Line(points = {{-22, 24}, {-22, 24}, {-22, 14}, {-49.7, 14}, {-49.7, 14}}, color = {0, 0, 255}));
  connect(gsPow.pv, gsPow.pc) annotation (
    Line(points = {{-22, 44}, {-32, 44}, {-32, 34}}, color = {0, 0, 255}));
  connect(gsPow.pc, genset.pin_p) annotation (
    Line(points = {{-32, 34}, {-41, 34}, {-41, 32}, {-50, 32}}, color = {0, 0, 255}));
  connect(gsPow.nc, battery.p) annotation (
    Line(points = {{-12, 34}, {-8, 34}, {-8, 48}, {20, 48}, {20, 36}}, color = {0, 0, 255}));
  connect(drivePow.power, powFilt.u) annotation (
    Line(points = {{42, 25}, {38, 25}, {38, 72}, {13.6, 72}, {13.6, 72}}, color = {0, 0, 127}));
  connect(drivePow.nv, genset.pin_n) annotation (
    Line(points = {{52, 26}, {52, 14}, {-49.7, 14}}, color = {0, 0, 255}));
  connect(drivePow.pv, drivePow.pc) annotation (
    Line(points = {{52, 46}, {42, 46}, {42, 36}, {42, 36}}, color = {0, 0, 255}));
  connect(drivePow.pc, battery.p) annotation (
    Line(points = {{42, 36}, {20, 36}, {20, 36}, {20, 36}}, color = {0, 0, 255}));
  connect(powFilt.y, limiter.u) annotation (
    Line(points = {{-4.8, 72}, {-12.4, 72}}, color = {0, 0, 127}));
  connect(limiter.y, genset.powRef) annotation (
    Line(points = {{-30.8, 72}, {-55.85, 72}, {-55.85, 40.25}}, color = {0, 0, 127}));
  connect(speedSensor1.v, driver.V) annotation (
    Line(points = {{26, -62.8}, {26, -74}, {-94, -74}, {-94, 68}, {-84, 68}, {-84, 74.8}}, color = {0, 0, 127}));
  connect(gear.flange_b, wheel.flangeR) annotation (
    Line(points = {{-64, -39}, {-52, -39}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(mass.flange_a, powProp.flange_b) annotation (
    Line(points = {{-8, -39}, {-16, -39}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(powProp.flange_a, wheel.flangeT) annotation (
    Line(points = {{-30, -39}, {-38, -39}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(powDrag.flange_a, mass.flange_b) annotation (
    Line(points = {{38, -39}, {10, -39}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(powDrag.flange_b, dragForce.flange) annotation (
    Line(points = {{52, -39}, {66, -39}, {66, -40}, {80, -40}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(speedSensor1.flange, mass.flange_b) annotation (
    Line(points = {{26, -46}, {26, -39}, {10, -39}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(genset.pin_n, ground1.p) annotation (
    Line(points = {{-49.7, 14}, {-42, 14}, {-42, 6}}, color = {0, 0, 255}, smooth = Smooth.None));
  annotation (
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 100}}, initialScale = 0.1), graphics={  Rectangle(lineColor = {255, 0, 0}, pattern = LinePattern.Dash, extent = {{-90, -28}, {94, -70}}), Rectangle(lineColor = {255, 0, 0}, pattern = LinePattern.Dash, extent = {{-90, 52}, {94, -10}}), Rectangle(lineColor = {255, 0, 0}, pattern = LinePattern.Dash, extent = {{-60, 96}, {94, 58}}), Text(lineColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{68, 74}, {94, 66}}, textString = "EMS"), Text(lineColor = {255, 0, 0}, extent = {{-96, -60}, {-44, -68}}, textString = "Longitudinal Dynamics"), Text(lineColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{12, 0}, {58, -8}}, textString = "PowerTrain")}),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics),
    experiment(StopTime = 400, StartTime = 0, Tolerance = 1e-06, Interval = 0.2),
    Documentation(info = "<html>
<p>This is a SHEV model which has an Energy Management System able to control the power flow with basic logic: requests the ICE to deliver the average load power.</p>
</html>"));
end SHEVpowerFilt;
