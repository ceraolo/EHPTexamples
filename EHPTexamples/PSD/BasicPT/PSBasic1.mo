within EHPTexamples.PSD.BasicPT;
model PSBasic1 "Modello a due macchine elettriche ideali (pure inerzie)"
  import Modelica.Constants.*;
  parameter Real vMass = 1300;
  Modelica.Mechanics.Rotational.Components.IdealPlanetary PSD(ratio = 78 / 30) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-8, 0})));
  Modelica.Mechanics.Rotational.Components.Inertia ICE(J = 0.73, w(fixed = true, start = 300, displayUnit = "rad/s")) annotation (
    Placement(transformation(extent = {{-64, 14}, {-44, 34}})));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 3.905) annotation (
    Placement(transformation(extent = {{58, 0}, {78, 20}})));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.31) annotation (
    Placement(transformation(extent = {{82, 2}, {98, 18}})));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor vhVel annotation (
    Placement(transformation(extent = {{-9, -9}, {9, 9}}, rotation = 180, origin = {83, -21})));
  Modelica.Mechanics.Translational.Components.Mass mass(m = 1300, v(fixed = true, start = 33.333333333333, displayUnit = "km/h")) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = -90, origin = {110, 0})));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragForce(fc = 0.014, S = 2.2, Cx = 0.26, m = mass.m, rho(displayUnit = "kg/m3") = 1.226) annotation (
    Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 90, origin = {109, -49})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor iceW annotation (
    Placement(transformation(extent = {{-9, 9}, {9, -9}}, rotation = 180, origin = {1, 67})));
  Modelica.Mechanics.Rotational.Sources.Torque iceTau annotation (
    Placement(transformation(extent = {{-88, 14}, {-70, 32}})));
  Modelica.Blocks.Sources.Constant iceSetW(k = 300) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 180, origin = {-2, 40})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor sunPow annotation (
    Placement(transformation(extent = {{-46, -18}, {-26, 2}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor carrPow annotation (
    Placement(transformation(extent = {{-38, 16}, {-24, 30}})));
  Modelica.Mechanics.Rotational.Components.Inertia gen(w(fixed = false, displayUnit = "rpm"), J = 5) annotation (
    Placement(transformation(extent = {{-76, -18}, {-56, 2}})));
  Modelica.Mechanics.Rotational.Components.Inertia mot(w(fixed = false, displayUnit = "rpm"), J = 0.59) annotation (
    Placement(transformation(extent = {{32, 0}, {52, 20}})));
  Modelica.Blocks.Math.Feedback feedback annotation (
    Placement(transformation(extent = {{-22, 64}, {-42, 44}})));
  Modelica.Mechanics.Translational.Sensors.PowerSensor Presis annotation (
    Placement(visible = true, transformation(origin = {110, -28}, extent = {{-8, -8}, {8, 8}}, rotation = 270)));
  Modelica.Blocks.Math.Gain gain(k = 10) annotation (
    Placement(transformation(extent = {{-54, 44}, {-74, 64}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor ringPow annotation (
    Placement(transformation(extent = {{24, -8}, {8, 8}})));
equation
  connect(dragForce.flange, Presis.flange_b) annotation (
    Line(points = {{109, -42}, {109, -36}, {110, -36}}, color = {0, 127, 0}));
  connect(vhVel.flange, Presis.flange_a) annotation (
    Line(points = {{92, -21}, {92, -20}, {110, -20}}, color = {0, 127, 0}));
  connect(Presis.flange_a, mass.flange_b) annotation (
    Line(points = {{110, -20}, {110, -10}}, color = {0, 127, 0}));
  connect(wheel.flangeR, idealGear.flange_b) annotation (
    Line(points = {{82, 10}, {78, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(iceTau.flange, ICE.flange_a) annotation (
    Line(points = {{-70, 23}, {-70, 24}, {-64, 24}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(sunPow.flange_b, PSD.sun) annotation (
    Line(points = {{-26, -8}, {-18, -8}, {-18, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(carrPow.flange_a, ICE.flange_b) annotation (
    Line(points = {{-38, 23}, {-42, 23}, {-42, 24}, {-44, 24}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(PSD.carrier, carrPow.flange_b) annotation (
    Line(points = {{-18, 4}, {-18, 23}, {-24, 23}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(carrPow.flange_b, iceW.flange) annotation (
    Line(points = {{-24, 23}, {18, 23}, {18, 67}, {10, 67}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(sunPow.flange_a, gen.flange_b) annotation (
    Line(points = {{-46, -8}, {-56, -8}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(idealGear.flange_a, mot.flange_b) annotation (
    Line(points = {{58, 10}, {58, 12}, {56, 12}, {56, 10}, {52, 10}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(iceSetW.y, feedback.u1) annotation (
    Line(points = {{-13, 40}, {-18, 40}, {-18, 54}, {-24, 54}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(iceW.w, feedback.u2) annotation (
    Line(points = {{-8.9, 67}, {-32, 67}, {-32, 62}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(feedback.y, gain.u) annotation (
    Line(points = {{-41, 54}, {-46, 54}, {-52, 54}}, color = {0, 0, 127}));
  connect(gain.y, iceTau.tau) annotation (
    Line(points = {{-75, 54}, {-86, 54}, {-96, 54}, {-96, 23}, {-89.8, 23}}, color = {0, 0, 127}));
  connect(wheel.flangeT, mass.flange_a) annotation (
    Line(points = {{98, 10}, {110, 10}}, color = {0, 127, 0}));
  connect(mot.flange_a, ringPow.flange_a) annotation (
    Line(points = {{32, 10}, {28, 10}, {28, 0}, {24, 0}}, color = {0, 0, 0}));
  connect(PSD.ring, ringPow.flange_b) annotation (
    Line(points = {{2, 0}, {8, 0}}, color = {0, 0, 0}));
  annotation (
    __Dymola_experimentSetupOutput,
    Documentation(info = "<html>
<h4>newInst OK</h4>
<h4>Modello di base per mostrare le prime funzionalit&agrave; di un sistema basato su PSD.</h4>
<p><br><u>Obiettivo finale</u>: simulazione di principio di Toyota Prius </p>
<p><u>Obiettivo di questa simulazione</u>: </p>
<p>Analizzare i punti di lavoro del PSD in un transitorio in cuil il veicolo decelera a seguito solo delle resistenze al moto d 120 km/h a 0; l&apos;ICE &egrave; mantenuto a velocit&agrave; costante da uno specifico controllo in retroazione, l&apos;inerzia di gen &egrave; aumentata di un fattore 20. </p>
</html>",
    revisions = "<html><head></head><body>No NewInst</body></html>"),
    conversion(noneFromVersion = ""),
    Diagram(coordinateSystem(extent = {{-100, -60}, {120, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    Icon(coordinateSystem(extent = {{-100, -60}, {120, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 0.0001, Interval = 0.5));
end PSBasic1;
