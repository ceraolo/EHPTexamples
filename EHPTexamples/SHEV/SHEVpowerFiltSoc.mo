within EHPTexamples.SHEV;
model SHEVpowerFiltSoc "Ice, Generator, DriveTrain, all map-based"
  //€
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
    Placement(visible = true, transformation(origin = {-40, -22}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.473) annotation (
    Placement(transformation(extent = {{-52, -66}, {-40, -54}})));
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = 10) annotation (
    Placement(transformation(extent = {{-78, -66}, {-66, -54}})));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 14000) annotation (
    Placement(transformation(extent = {{-8, -68}, {10, -50}})));
  Modelica.Mechanics.Translational.Sensors.PowerSensor powProp annotation (
    Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 0, origin = {-24, -60})));
  Modelica.Mechanics.Translational.Sensors.PowerSensor powDrag annotation (
    Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 0, origin = {45, -59})));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragForce(S = 6.5, fc = 0.01, Cx = 0.65, m = mass.m) annotation (
    Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 90, origin = {80, -68})));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor1 annotation (
    Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 270, origin = {26, -74})));
  EHPTlib.SupportModels.Miscellaneous.PropDriver driver(CycleFileName = Modelica.Utilities.Files.loadResource("modelica://EHPTexamples/Resources/Sort1.txt"), extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, k = 200.0, yMax = 2e3) annotation (
    Placement(visible = true, transformation(extent = {{-100, 90}, {-80, 110}}, rotation = 0)));
  EHPTlib.MapBased.Genset genset(gsRatio = 1,
    mapsFileName=Modelica.Utilities.Files.loadResource(
        "modelica://EHPTexamples/Resources/SHEVmaps.txt"),                   maxGenW = 300, maxPow = 45000, maxTau = 500, wIceStart = 300) annotation (
    Placement(transformation(extent = {{-80, -34}, {-50, -4}})));
  EHPTlib.SupportModels.Miscellaneous.Batt1 battery(ICellMax = 500, QCellNom = 25 * 3600, R0Cell = 0.35E-3, efficiency = 0.9, iCellEfficiency = 200, ns = 200) annotation (
    Placement(transformation(extent = {{0, -24}, {20, -4}})));
  EHPTlib.MapBased.OneFlange drive(effTableName = "motEffTable", mapsFileName = "SHEVmaps.txt", mapsOnFile = false, powMax = 150e3, tauMax = 1000, wMax = 3000) annotation (
    Placement(visible = true, transformation(extent = {{66, -10}, {86, -30}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor gsPow annotation (
    Placement(transformation(extent = {{-32, -20}, {-12, 0}})));
  Modelica.Blocks.Math.Feedback fbSOC annotation (
    Placement(transformation(extent = {{20, 38}, {0, 58}})));
  Modelica.Blocks.Sources.Constant socRef_(k = 0.5) annotation (
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {38, 48})));
  Modelica.Blocks.Math.Gain socErrToPow(k = 3e6) annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-24, 48})));
  Modelica.Blocks.Math.Add add annotation (
    Placement(visible = true, transformation(origin = {-6, 80}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.FirstOrder powFilt(y_start = 20e3, T = 500) annotation (
    Placement(visible = true, transformation(extent = {{34, 78}, {18, 94}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter toPowRef(uMax = 100e3, uMin = 0) annotation (
    Placement(visible = true, transformation(extent = {{-30, 72}, {-46, 88}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor drivePow annotation (
    Placement(visible = true, transformation(origin = {50, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(add.y, toPowRef.u) annotation (
    Line(points = {{-17, 80}, {-28.4, 80}}, color = {0, 0, 127}));
  connect(genset.pin_n, ground1.p) annotation (
    Line(points = {{-49.7, -28}, {-45.85, -28}, {-45.85, -14}, {-40, -14}}, color = {0, 0, 255}));
  connect(gsPow.nv, genset.pin_n) annotation (
    Line(points = {{-22, -20}, {-22, -28}, {-49.7, -28}}, color = {0, 0, 255}));
  connect(drivePow.nv, drive.pin_p) annotation (
    Line(points={{50,-18},{50,-23.3333},{66,-23.3333}},        color = {0, 0, 255}));
  connect(drivePow.pc, battery.p) annotation (
    Line(points = {{40, -8}, {20, -8}}, color = {0, 0, 255}));
  connect(drivePow.pv, drivePow.pc) annotation (
    Line(points = {{50, 2}, {40, 2}, {40, -8}}, color = {0, 0, 255}));
  connect(drivePow.nc, drive.pin_n) annotation (
    Line(points={{60,-8},{66,-8},{66,-14.4444}},        color = {0, 0, 255}));
  connect(gear.flange_a, drive.flange_a) annotation (
    Line(points={{-78,-60},{-84,-60},{-84,-42},{96,-42},{96,-18.8889},{86,
          -18.8889}}));
  connect(drive.tauRef, driver.tauRef) annotation (
    Line(points={{64.6,-18.8889},{64.6,16},{64,16},{64,24},{82,24},{82,100},{
          -79,100}},                                                                                   color = {0, 0, 127}));
  connect(battery.n, drive.pin_p) annotation (
    Line(points={{20.1,-20},{24,-20},{24,-28},{32,-28},{32,-23.3333},{66,
          -23.3333}},                                                                             color = {0, 0, 255}));
  connect(gsPow.nv, drive.pin_p) annotation (
    Line(points={{-22,-20},{-22,-28},{32,-28},{32,-23.3333},{66,-23.3333}},            color = {0, 0, 255}));
  connect(socErrToPow.y, add.u2) annotation (
    Line(points = {{-35, 48}, {-46, 48}, {-46, 66}, {12, 66}, {12, 74}, {6, 74}}, color = {0, 0, 127}));
  connect(toPowRef.y, genset.powRef) annotation (
    Line(points = {{-46.8, 80}, {-56, 80}, {-56, -1.75}, {-55.85, -1.75}}, color = {0, 0, 127}));
  connect(powFilt.y, add.u1) annotation (
    Line(points = {{17.2, 86}, {6, 86}}, color = {0, 0, 127}));
  connect(speedSensor1.v, driver.V) annotation (
    Line(points = {{26, -82.8}, {26, -82}, {-94, -82}, {-94, 40}, {-90, 40}, {-90, 88.8}}, color = {0, 0, 127}));
  connect(gear.flange_b, wheel.flangeR) annotation (
    Line(points = {{-66, -60}, {-52, -60}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(mass.flange_a, powProp.flange_b) annotation (
    Line(points = {{-8, -59}, {-12, -59}, {-12, -60}, {-18, -60}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(powProp.flange_a, wheel.flangeT) annotation (
    Line(points = {{-30, -60}, {-40, -60}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(powDrag.flange_a, mass.flange_b) annotation (
    Line(points = {{38, -59}, {10, -59}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(powDrag.flange_b, dragForce.flange) annotation (
    Line(points = {{52, -59}, {66, -59}, {66, -60}, {80, -60}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(speedSensor1.flange, mass.flange_b) annotation (
    Line(points = {{26, -66}, {26, -59}, {10, -59}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(gsPow.pc, genset.pin_p) annotation (
    Line(points = {{-32, -10}, {-50, -10}}, color = {0, 0, 255}));
  connect(gsPow.nc, battery.p) annotation (
    Line(points = {{-12, -10}, {-8, -10}, {-8, 6}, {28, 6}, {28, -8}, {20, -8}}, color = {0, 0, 255}));
  connect(gsPow.pv, gsPow.pc) annotation (
    Line(points = {{-22, 0}, {-32, 0}, {-32, -10}}, color = {0, 0, 255}));
  connect(battery.SOC, fbSOC.u2) annotation (
    Line(points = {{-1, -14}, {-4, -14}, {-4, 40}, {10, 40}}, color = {0, 0, 127}));
  connect(fbSOC.u1, socRef_.y) annotation (
    Line(points = {{18, 48}, {27, 48}}, color = {0, 0, 127}));
  connect(socErrToPow.u, fbSOC.y) annotation (
    Line(points = {{-12, 48}, {1, 48}}, color = {0, 0, 127}));
  connect(drivePow.power, powFilt.u) annotation (
    Line(points = {{40, -19}, {40, -18}, {34, -18}, {34, 26}, {60, 26}, {60, 86}, {35.6, 86}}, color = {0, 0, 127}));
  annotation (
    Diagram(coordinateSystem(extent = {{-100, -100}, {100, 120}}, initialScale = 0.1), graphics={  Rectangle(lineColor = {255, 0, 0}, pattern = LinePattern.Dash, extent = {{-90, -48}, {94, -94}}), Rectangle(lineColor = {255, 0, 0}, pattern = LinePattern.Dash, extent = {{-90, 10}, {92, -38}}), Rectangle(lineColor = {255, 0, 0}, pattern = LinePattern.Dash, extent = {{-70, 116}, {94, 30}}), Text(lineColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{50, 112}, {76, 104}}, textString = "EMS"), Text(origin = {16, -4}, lineColor = {255, 0, 0}, extent = {{-96, -80}, {-44, -88}}, textString = "Longitudinal Dynamics"), Text(origin = {-9.3846, 46}, lineColor = {255, 0, 0}, extent = {{-88.6154, -40}, {-40.6154, -44}}, textString = "Power Train")}),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}, initialScale = 0.1), graphics),
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 1e-06, Interval = 4),
    Documentation(info = "<html>
<p>This is a SHEV model which has an Energy Management System able to control the power flow with:</p>
<p>- basic logic: requests the ICE to deliver the average load power </p>
<p>- additional logic: SOC loop to avoid SOC drift.</p>
</html>"));
end SHEVpowerFiltSoc;
