within EHPTexamples.PSD;
model PSecu1 "Full Power Split Device power train using Map-Based components"
  import Modelica.Constants.*;
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.AngularVelocity wIceStart = 50;
  Modelica.Units.SI.Energy EbatDel(start=0, fixed=true) "energy delivered by the battery";
  Modelica.Units.SI.Energy EgenDelM( start=0, fixed=true)
                                                         "energy delivered by gen trough mechanical flange";
  Modelica.Units.SI.Energy Eroad(start=0, fixed=true) "mechanical energy absorbed by roas (friction & air)";
  Modelica.Units.SI.Energy EiceDel(start=0, fixed=true) "mechanical energy delivered by ice";
  Modelica.Units.SI.Energy Emot(start=0, fixed=true);
  Modelica.Units.SI.Energy Emass;
  Modelica.Mechanics.Rotational.Components.IdealPlanetary PSD(ratio = 78 / 30) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-50, 52})));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 3.905, flange_b(
        phi(start=0, fixed=true)))                                            annotation (
    Placement(transformation(extent = {{2, 42}, {22, 62}})));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor carVel annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {78, -12})));
  Modelica.Mechanics.Translational.Components.Mass mass(v(fixed = true, start = 0), m = 1300) annotation (
    Placement(transformation(extent = {{54, 42}, {74, 62}})));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragForce(fc = 0.014, rho = 1.226, S = 2.2, Cx = 0.26, m = mass.m) annotation (
    Placement(transformation(extent = {{-9, -9}, {9, 9}}, rotation = 90, origin = {89, 29})));
  EHPTlib.MapBased.IceConnP ice(flange_a(phi(start=0, fixed=true)))
                                annotation (
    Placement(transformation(extent = {{-98, 46}, {-78, 66}})));
  EHPTlib.SupportModels.Miscellaneous.Batt1Conn bat(ECellMin = 0.9, ECellMax = 1.45, R0Cell = 0.0003, ns = 168, QCellNom = 2 * 6.5 * 3600.0, SOCInit = 0.6, ICellMax = 1e5, iCellEfficiency = 15 * 6.5) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-16, 0})));
  EHPTlib.SupportModels.ConnectorRelated.Conn d annotation (
    Placement(visible = true, transformation(extent = {{2, -40}, {28, -16}}, rotation = 0), iconTransformation(extent = {{4, -52}, {30, -28}}, rotation = 0)));
  EHPTlib.MapBased.ECUs.Ecu1 ECU(genLoopGain = 1.0) annotation (
    Placement(visible = true, transformation(origin={-12,-41},    extent = {{-10, -9}, {10, 9}}, rotation = 0)));
  EHPTlib.MapBased.TwoFlangeConn mot(effTableName = "motEffTable", mapsFileName = Modelica.Utilities.Files.loadResource("modelica://EHPTexamples/Resources/PSDmaps.txt"), mapsOnFile = true) annotation (
    Placement(visible = true, transformation(extent = {{-28, 62}, {-8, 42}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.31) annotation (
    Placement(visible = true, transformation(origin = {38, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(origin = {10, 26}, extent = {{10, 10}, {-10, -10}}, rotation = 270)));
  EHPTlib.MapBased.OneFlangeFVCTconn gen annotation (Placement(visible=true,
        transformation(extent={{-38,10},{-58,30}}, rotation=0)));
  EHPTlib.SupportModels.Miscellaneous.PropDriver driver(CycleFileName = Modelica.Utilities.Files.loadResource("modelica://EHPTexamples/Resources/NEDC.txt"), k = 1, yMax = 1.8) annotation (
    Placement(visible = true, transformation(extent = {{-60, -50}, {-40, -30}}, rotation = 0)));
equation
  connect(ECU.tauRef, driver.tauRef) annotation (
    Line(points={{-24,-41},{-29,-41},{-29,-40},{-39,-40}},          color = {0, 0, 127}));
  connect(carVel.v, driver.V) annotation (
    Line(points = {{78, -23}, {78, -58}, {-50, -58}, {-50, -51.2}}, color = {0, 0, 127}));
  connect(mot.conn1, ECU.conn) annotation (Line(
      points={{-26.8,59.8},{-26.8,72},{50,72},{50,-20},{-12,-20},{-12,-32.18}},
      color={255,204,51},
      thickness=0.5));
  connect(gen.pin_p, bat.p) annotation (
    Line(points={{-38,25},{-24,25},{-24,10},{-22,10}},             color = {0, 0, 255}));
  connect(gen.pin_n, bat.n) annotation (
    Line(points={{-38,15},{-10,15},{-10,10.1}},          color = {0, 0, 255}));
  connect(gen.flange_a, PSD.sun) annotation (
    Line(points = {{-58, 20}, {-70, 20}, {-70, 52}, {-60, 52}}));
  connect(gen.conn, ECU.conn) annotation (Line(
      points={{-57,10.25},{-57,-20},{-12,-20},{-12,-32.18}},
      color={255,204,51},
      thickness=0.5));
  connect(ground.p, bat.n) annotation (
    Line(points={{0,26},{-10,26},{-10,10.1}},          color = {0, 0, 255}));
  connect(wheel.flangeT, mass.flange_a) annotation (
    Line(points = {{48, 52}, {54, 52}}, color = {0, 127, 0}));
  connect(wheel.flangeR, idealGear.flange_b) annotation (
    Line(points = {{28, 52}, {22, 52}}));
  connect(PSD.ring, mot.flange_a) annotation (
    Line(points = {{-40, 52}, {-34, 52}, {-28, 52}}));
  connect(idealGear.flange_a, mot.flange_b) annotation (
    Line(points = {{2, 52}, {-4, 52}, {-4, 52.2}, {-8, 52.2}}));
  connect(mot.pin_p, bat.p) annotation (
    Line(points={{-22,43.8},{-22,10},{-22,10}},           color = {0, 0, 255}));
  connect(mot.pin_n, bat.n) annotation (
    Line(points={{-14,43.8},{-14,10.1},{-10,10.1}},       color = {0, 0, 255}));
  connect(ice.conn, ECU.conn) annotation (Line(
      points={{-88,45.8},{-88,-20},{-12,-20},{-12,-32.18}},
      color={255,204,51},
      thickness=0.5));
  connect(ECU.conn, d) annotation (Line(
      points={{-12,-32.18},{-12,-28},{15,-28}},
      color={255,204,51},
      thickness=0.5));
  der(EbatDel) = (bat.p.v - bat.n.v) * bat.n.i;
  der(EgenDelM) = gen.pin_p.i * (gen.pin_p.v - gen.pin_n.v) + gen.flange_a.tau * der(gen.flange_a.phi);
  der(Eroad) = dragForce.flange.f * der(dragForce.flange.s);
  der(EiceDel) = -ice.flange_a.tau * der(ice.flange_a.phi);
  der(Emot) = mot.flange_a.tau * der(mot.flange_a.phi) + mot.flange_b.tau * der(mot.flange_b.phi);
  Emass = 0.5 * mass.m * der(mass.flange_a.s) ^ 2;
  connect(PSD.carrier, ice.flange_a) annotation (
    Line(points = {{-60, 56}, {-70, 56}, {-70, 56}, {-78, 56}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(dragForce.flange, mass.flange_b) annotation (
    Line(points = {{89, 38}, {90, 38}, {90, 52}, {74, 52}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(carVel.flange, mass.flange_b) annotation (
    Line(points = {{78, -2}, {78, 52}, {74, 52}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(bat.conn, ECU.conn) annotation (Line(
      points={{-12,-10.2},{-12,-32.18}},
      color={255,204,51},
      thickness=0.5));
  annotation (
    __Dymola_experimentSetupOutput,
    Documentation(info = "<html>
<p>This model simulates a PSD based power train with a simple control logic, in its ECU:</p>
<p>It tries to make the ICE deliver the average load power, at its optimal speed.</p>
<p>This has two main inconveniences:</p>
<ul>
<li>the battery SOC is not controlled and tends to drift</li>
<li>in urban environments the power is too low to allow efficient drive without shutting off the engine.</li>
</ul>
<p>These inconveniences are addressed in subsequent models PSEcu2 and PSecu3 (see their infos).</p>
</html>"),
    Diagram(coordinateSystem(extent = {{-100, -60}, {100, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    experiment(StartTime = 0, StopTime = 1400, Tolerance = 0.0001, Interval = 2.8));
end PSecu1;
