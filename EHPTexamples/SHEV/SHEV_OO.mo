within EHPTexamples.SHEV;
model SHEV_OO "Ice, Generator, DriveTrain, all map-based"
  //€
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Basic.Ground ground1 annotation (
    Placement(visible = true, transformation(origin = {22, -12}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.473) annotation (
    Placement(visible = true, transformation(origin = {-48, -42}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = 10) annotation (
    Placement(visible = true, transformation(extent = {{-82, -52}, {-62, -32}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 14000) annotation (
    Placement(visible = true, transformation(extent = {{-2, -50}, {16, -32}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor powProp annotation (
    Placement(visible = true, transformation(origin = {-21, -41}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor powDrag annotation (
    Placement(visible = true, transformation(origin = {51, -41}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragForce(S = 6.5, fc = 0.01, Cx = 0.65, m = mass.m) annotation (
    Placement(visible = true, transformation(origin = {76, -50}, extent = {{-8, -8}, {8, 8}}, rotation = 90)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor speedSensor1 annotation (
    Placement(visible = true, transformation(origin = {26, -56}, extent = {{-8, -8}, {8, 8}}, rotation = 270)));
  EHPTlib.SupportModels.Miscellaneous.Batt1 battery(ICellMax = 500, QCellNom = 25 * 3600, R0Cell = 0.35E-3, SOCInit = 0.5, efficiency = 0.9, iCellEfficiency = 200, ns = 100) annotation (
    Placement(visible = true, transformation(origin = {-2, 26}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  EHPTlib.MapBased.OneFlange drive(effTableName = "motEffTable", mapsFileName = "SHEVmaps.txt", mapsOnFile = false, powMax = 150e3, tauMax = 1000, wMax = 3000) annotation (
    Placement(visible = true, transformation(extent = {{64, 16}, {84, -4}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor gsPow annotation (
    Placement(visible = true, transformation(extent = {{-36, 0}, {-16, 20}}, rotation = 0)));
  EHPTlib.MapBased.ECUs.EMS ems(powHigh = 60e3, powLow = 30e3, powMax = 200e3, powPerSoc = 300e3, socRef = 0.6) annotation (
    Placement(visible = true, transformation(origin = {-20, 58}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  EHPTlib.MapBased.GensetOO genset(gsRatio = 1, mapsFileName = "SHEVmaps.txt", maxGenW = 300, maxPow = 45000, maxTau = 500, wIceStart = 300) annotation (
    Placement(visible = true, transformation(extent = {{-84, -14}, {-54, 16}}, rotation = 0)));
  EHPTlib.SupportModels.Miscellaneous.PropDriver driver(CycleFileName = "Sort1.txt", extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, k = 200.0, yMax = 2e3) annotation (
    Placement(visible = true, transformation(origin = {86, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Sensors.PowerSensor drivePow annotation (
    Placement(visible = true, transformation(origin = {40, 16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(genset.pin_n, drive.pin_p) annotation (
    Line(points = {{-53.7, -8}, {10, -8}, {10, 2.66667}, {64, 2.66667}}, color = {0, 0, 255}));
  connect(gsPow.pc, genset.pin_p) annotation (
    Line(points = {{-36, 10}, {-54, 10}}, color = {0, 0, 255}));
  connect(ems.pcPowReq, genset.powRef) annotation (
    Line(points = {{-30.8, 52}, {-60, 52}, {-60, 18.4}}, color = {0, 0, 127}));
  connect(ems.on, genset.ON) annotation (
    Line(points = {{-30.8, 64}, {-78, 64}, {-78, 18.4}}, color = {255, 0, 255}));
  connect(drive.flange_a, gear.flange_a) annotation (
    Line(points = {{84, 7.11111}, {94, 7.11111}, {94, -24}, {-94, -24}, {-94, -42}, {-82, -42}, {-82, -42}, {-82, -42}}));
  connect(drivePow.power, ems.edPow) annotation (
    Line(points={{30,5},{16,5},{16,64},{-8,64},{-8,64}},            color = {0, 0, 127}));
  connect(drivePow.nv, drive.pin_p) annotation (
    Line(points = {{40, 6}, {40, 6}, {40, 0}, {64, 0}, {64, 2.66667}}, color = {0, 0, 255}));
  connect(drivePow.pc, battery.p) annotation (
    Line(points = {{30, 16}, {4, 16}, {4, 16}, {4, 16}}, color = {0, 0, 255}));
  connect(drivePow.pv, drivePow.nc) annotation (
    Line(points = {{40, 26}, {50, 26}, {50, 16}, {50, 16}}, color = {0, 0, 255}));
  connect(drivePow.nc, drive.pin_n) annotation (
    Line(points={{50,16},{64,16},{64,11.5556},{64,11.5556}},          color = {0, 0, 255}));
  connect(driver.tauRef, drive.tauRef) annotation (
    Line(points = {{75, 60}, {57, 60}, {57, 4.5}, {62.6, 4.5}, {62.6, 7.11111}}, color = {0, 0, 127}));
  connect(ground1.p, drive.pin_p) annotation (
    Line(points = {{22, -4}, {22, 2.66667}, {64, 2.66667}}, color = {0, 0, 255}));
  connect(gsPow.nv, drive.pin_p) annotation (
    Line(points = {{-26, 0}, {-26, -8}, {10, -8}, {10, 2.66667}, {64, 2.66667}}, color = {0, 0, 255}));
  connect(battery.n, drive.pin_p) annotation (
    Line(points = {{-8, 15.9}, {-8, -8}, {10, -8}, {10, 2.66667}, {64, 2.66667}}, color = {0, 0, 255}));
  connect(speedSensor1.v, driver.V) annotation (
    Line(points = {{26, -64.8}, {26, -74}, {98, -74}, {98, 44}, {86, 44}, {86, 48.8}}, color = {0, 0, 127}));
  connect(gear.flange_b, wheel.flangeR) annotation (
    Line(points = {{-62, -42}, {-56, -42}}));
  connect(powProp.flange_a, wheel.flangeT) annotation (
    Line(points = {{-30, -41}, {-35, -41}, {-35, -42}, {-40, -42}}, color = {0, 127, 0}));
  connect(mass.flange_a, powProp.flange_b) annotation (
    Line(points = {{-2, -41}, {-12, -41}}, color = {0, 127, 0}));
  connect(battery.SOC, ems.soc) annotation (
    Line(points = {{-2, 37}, {-2, 52}, {-8, 52}}, color = {0, 0, 127}));
  connect(gsPow.pv, gsPow.pc) annotation (
    Line(points = {{-26, 20}, {-36, 20}, {-36, 10}}, color = {0, 0, 255}));
  connect(powDrag.flange_b, dragForce.flange) annotation (
    Line(points = {{60, -41}, {60, -42}, {76, -42}}, color = {0, 127, 0}));
  connect(speedSensor1.flange, mass.flange_b) annotation (
    Line(points = {{26, -48}, {26, -41}, {16, -41}}, color = {0, 127, 0}));
  connect(powDrag.flange_a, mass.flange_b) annotation (
    Line(points = {{42, -41}, {42, -41}, {16, -41}}, color = {0, 127, 0}));
  connect(battery.p, gsPow.nc) annotation (
    Line(points = {{4, 16}, {4, 10}, {-16, 10}}, color = {0, 0, 255}));
  annotation (
    Diagram(coordinateSystem(extent = {{-100, -80}, {100, 80}}, initialScale = 0.1), graphics={  Rectangle(origin = {-2, 4}, lineColor = {255, 0, 0}, pattern = LinePattern.Dash, extent = {{-88, -32}, {94, -74}}), Rectangle(origin = {-4, 0}, lineColor = {255, 0, 0}, pattern = LinePattern.Dash, extent = {{-88, 40}, {94, -20}}), Text(origin = {0, 4}, lineColor = {255, 0, 0}, fillPattern = FillPattern.Solid, extent = {{-96, -64}, {-44, -72}}, textString = "MechProp")}),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics),
    experiment(StopTime = 2000, StartTime = 0, Tolerance = 1e-06, Interval = 0.4),
    Documentation(info = "<html>
<p>This is a SHEV model which has an Energy Management System able to control the power flow with:</p>
<p>- basic logic: requests the ICE to deliver the average load power </p>
<p>- additional logic: SOC loop to avoid SOC drift</p>
<p>- further ON/OFF control to switch OFF the engine when the average power is too low to permit efficient operation.</p>
</html>"),
    __OpenModelica_commandLineOptions = "");
end SHEV_OO;
