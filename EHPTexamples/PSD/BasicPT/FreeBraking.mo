within EHPTexamples.PSD.BasicPT;
model FreeBraking "Modello a due macchine elettriche ideali (pure inerzie)"
  import Modelica.Constants.*;
  parameter Real vMass = 1300;
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 3.905) annotation (
    Placement(visible = true, transformation(extent = {{-30, 10}, {-10, 30}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.31) annotation (
    Placement(visible = true, transformation(extent = {{-6, 12}, {10, 28}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia mot(w(fixed = false, displayUnit = "rpm"), J = 0.59) annotation (
    Placement(visible = true, transformation(extent = {{-56, 10}, {-36, 30}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor wGen annotation (
    Placement(visible = true, transformation(origin = {-60, -14}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor Pprop annotation (
    Placement(visible = true, transformation(origin = {24, 20}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(m = vMass, v(fixed = true, start = 33.333333333333, displayUnit = "km/h")) annotation (
    Placement(visible = true, transformation(origin = {46, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor Presis annotation (
    Placement(visible = true, transformation(origin = {62.5, -9.5}, extent = {{-9.5, -9.5}, {9.5, 9.5}}, rotation = 270)));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragForce(fc = 0.014, rho = 1.226, m = vMass, S = 2.2, Cx = 0.26) annotation (
    Placement(visible = true, transformation(origin = {61.5, -36.5}, extent = {{-9.5, -9.5}, {9.5, 9.5}}, rotation = 90)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor Vvh annotation (
    Placement(visible = true, transformation(origin = {29, -17}, extent = {{-9, -9}, {9, 9}}, rotation = 180)));
equation
  connect(Vvh.flange, Presis.flange_a) annotation (
    Line(points = {{38, -17}, {38, 0}, {62.5, 0}}, color = {0, 127, 0}));
  connect(dragForce.flange, Presis.flange_b) annotation (
    Line(points = {{61.5, -27}, {61.5, -19.5}, {62.5, -19.5}, {62.5, -19}}, color = {0, 127, 0}));
  connect(Presis.flange_a, mass.flange_b) annotation (
    Line(points = {{62.5, 0}, {62, 0}, {62, 20}, {56, 20}, {56, 20}, {56, 20}}, color = {0, 127, 0}));
  connect(dragForce.flange, Presis.flange_b) annotation (
    Line(points = {{61.5, -27}, {62.5, -27}, {62.5, -19}}, color = {0, 127, 0}));
  connect(Pprop.flange_b, mass.flange_a) annotation (
    Line(points = {{32, 20}, {36, 20}}, color = {0, 127, 0}));
  connect(Pprop.flange_a, wheel.flangeT) annotation (
    Line(points = {{16, 20}, {10, 20}}, color = {0, 127, 0}));
  connect(wGen.flange, mot.flange_a) annotation (
    Line(points = {{-60, -4}, {-60, 9}, {-60, 9}, {-60, 20}, {-58, 20}, {-58, 20}, {-56, 20}}));
  connect(idealGear.flange_a, mot.flange_b) annotation (
    Line(points = {{-30, 20}, {-36, 20}}));
  connect(wheel.flangeR, idealGear.flange_b) annotation (
    Line(points = {{-6, 20}, {-10, 20}}));
  annotation (
    __Dymola_experimentSetupOutput,
    Documentation(info = "<html><head></head><body><p></p><h4>Modello di base per mostrare le prime funzionalità di un sistema basato su PSD.</h4><p></p>
    <p><br><u>Obiettivo finale</u>: simulazione di principio di Toyota Prius</p>
    <p><u>Obiettivo di questa simulazione</u>: </p>
    <p>funzionamento con frenata naturale (=a seguito delle sole resistenze al moto) del veicolo di riferimento.</p>
    </body></html>"),
    conversion(noneFromVersion = ""),
    Diagram(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    Icon(coordinateSystem(extent = {{-100, -60}, {100, 60}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    experiment(StartTime = 0, StopTime = 300, Tolerance = 0.0001, Interval = 0.15));
end FreeBraking;
