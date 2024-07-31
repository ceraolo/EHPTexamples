within EHPTexamples.EV;
model MBEVdata "Simulates a very basic Electric Vehicle"
  import Modelica;
  extends Modelica.Icons.Example;
  Modelica.Units.SI.Energy enBatDel(start=0, fixed=true);
  Modelica.Units.SI.Energy enDTdel(start=0, fixed=true);
  Modelica.Units.SI.Energy enP1del(start=0, fixed=true);
  Modelica.Units.SI.Energy enBattLoss(start=0, fixed=true);
  Modelica.Units.SI.Energy enBraking(start=0, fixed=true);

  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = data.ratio) annotation (
    Placement(visible = true, transformation(origin = {-20, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  EHPTlib.SupportModels.Miscellaneous.PropDriver driver(CycleFileName = Modelica.Utilities.Files.loadResource("modelica://EHPTexamples/Resources/NEDC.txt"), extrapolation = Modelica.Blocks.Types.Extrapolation.Periodic, k = data.kContr, yMax = 100000.0) annotation (
    Placement(visible = true, transformation(extent = {{-116, -10}, {-96, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.5715) annotation (
    Placement(visible = true, transformation(extent = {{-4, 4}, {16, 24}}, rotation = 0)));
  EHPTlib.MapBased.OneFlangeFVCT eleDrive(J = data.J, effTableName = "effTable", mapsFileName = Modelica.Utilities.Files.loadResource("modelica://EHPTexamples/Resources/EVmaps.txt"), mapsOnFile = true, powMax = 22e3, tauMax = 200, wMax = 1000) "Electric Drive" annotation (
    Placement(visible = true, transformation(extent = {{-74, 6}, {-54, 24}}, rotation = 0)));
  EHPTlib.SupportModels.Miscellaneous.Batt1 batt1(SOCInit = 0.7, QCellNom = 100 * 3600,
  ns = 100, C1(v(start=0, fixed=true))) annotation (
    Placement(transformation(extent = {{-112, 34}, {-92, 54}})));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(extent = {{-84, -20}, {-64, 0}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor mP1 annotation (
    Placement(visible = true, transformation(origin = {32, 14}, extent = {{-6, -8}, {6, 8}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = data.m, v(fixed=
          true))                                                    annotation (
    Placement(visible = true, transformation(extent = {{56, 4}, {76, 24}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor mP2 annotation (
    Placement(visible = true, transformation(origin = {98, 4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor velSens annotation (
    Placement(visible = true, transformation(origin = {68, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragF(Cx = data.Cx, S = data.S, fc = data.fc, m = data.m, rho = data.rho) annotation (
    Placement(visible = true, transformation(origin = {98, -24}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Mechanics.Translational.Sources.Force brake annotation (
    Placement(visible = true, transformation(origin = {32, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.TorqueSensor edTau annotation (
    Placement(transformation(extent = {{-8, -8}, {8, 8}}, rotation = 0, origin = {-42, 14})));
  Modelica.Blocks.Math.Add add(k1 = -1) annotation (
    Placement(transformation(extent = {{-42, -26}, {-30, -14}})));
  Modelica.Blocks.Math.Gain tqToForce(k = gear.ratio * wheel.radius) annotation (
    Placement(visible = true, transformation(extent = {{0, -26}, {12, -14}}, rotation = 0)));
  Modelica.Blocks.Nonlinear.Limiter cutNeg(uMax = 0, uMin = -Modelica.Constants.inf) annotation (
    Placement(visible = true, transformation(origin = {-14, -20}, extent = {{-6, -6}, {6, 6}}, rotation = 0)));
  VehicleData.Car data annotation (
    Placement(visible = true, transformation(origin = {70, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(batt1.n, eleDrive.pin_n) annotation (
    Line(points={{-91.9,38},{-80,38},{-80,10.5},{-74,10.5}},      color = {0, 0, 255}));
  connect(eleDrive.pin_n, ground.p) annotation (
    Line(points={{-74,10.5},{-74,10.5},{-74,0},{-74,0}},      color = {0, 0, 255}));
  connect(eleDrive.tauRef, driver.tauRef) annotation (
    Line(points={{-74.2,15},{-86,15},{-86,0},{-95,0}},          color = {0, 0, 127}));
  connect(batt1.p, eleDrive.pin_p) annotation (
    Line(points={{-92,50},{-74,50},{-74,19.5}},      color = {0, 0, 255}));
  connect(edTau.flange_a, eleDrive.flange_a) annotation (
    Line(points={{-50,14},{-52,14},{-52,15},{-54,15}}));
  connect(tqToForce.y, brake.f) annotation (
    Line(points = {{12.6, -20}, {18, -20}, {18, -20}, {20, -20}}, color = {0, 0, 127}));
  connect(cutNeg.y, tqToForce.u) annotation (
    Line(points = {{-7.4, -20}, {-2, -20}, {-2, -20}, {-1.2, -20}}, color = {0, 0, 127}));
  connect(cutNeg.u, add.y) annotation (
    Line(points={{-21.2,-20},{-29.4,-20}},    color = {0, 0, 127}));
  connect(brake.flange,mP1. flange_b) annotation (
    Line(points = {{42, -20}, {46, -20}, {46, 14}, {38, 14}}, color = {0, 127, 0}));
  connect(velSens.flange,mP2. flange_a) annotation (
    Line(points = {{78, -42}, {78, 14}, {98, 14}}, color = {0, 127, 0}));
  connect(driver.V, velSens.v) annotation (
    Line(points = {{-106, -11.2}, {-106, -42}, {57, -42}}, color = {0, 0, 127}));
  connect(mass.flange_a,mP1. flange_b) annotation (
    Line(points = {{56, 14}, {38, 14}}, color = {0, 127, 0}));
  connect(mP2.flange_a, mass.flange_b) annotation (
    Line(points = {{98, 14}, {76, 14}}, color = {0, 127, 0}));
  connect(mP1.flange_a, wheel.flangeT) annotation (
    Line(points = {{26, 14}, {16, 14}}, color = {0, 127, 0}));
  connect(gear.flange_b, wheel.flangeR) annotation (
    Line(points = {{-10, 14}, {-4, 14}}));
  connect(dragF.flange,mP2. flange_b) annotation (
    Line(points = {{98, -14}, {98, -6}}, color = {0, 127, 0}));
  der(enBatDel) = (batt1.p.v - batt1.n.v) * batt1.n.i;
  der(enDTdel) = eleDrive.powSensor.power;
  der(enP1del) =mP1.power;
  der(enBattLoss) = batt1.powerLoss;
  der(enBraking) = if mP1.power > 0 then 0 else -mP1.power;
  connect(add.u2, driver.tauRef) annotation (
    Line(points={{-43.2,-23.6},{-86,-23.6},{-86,0},{-95,0}},    color = {0, 0, 127}));
  connect(edTau.flange_b, gear.flange_a) annotation (
    Line(points = {{-34, 14}, {-30, 14}, {-30, 14}}, color = {0, 0, 0}));
  connect(add.u1, edTau.tau) annotation (
    Line(points={{-43.2,-16.4},{-43.2,5.2},{-48.4,5.2}},  color = {0, 0, 127}));
  annotation (
    Documentation(info = "<html>
<p>Simple map-based EV model with battery.</p>
</html>"),
    Diagram(coordinateSystem(extent = {{-120, -60}, {120, 60}}, preserveAspectRatio = false)),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    experiment(StartTime = 0, StopTime = 1400, Tolerance = 0.0001, Interval = 0.1),
    __OpenModelica_commandLineOptions = "");
end MBEVdata;
