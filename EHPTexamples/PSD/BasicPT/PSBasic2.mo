within EHPTexamples.PSD.BasicPT;
model PSBasic2 "Modello a due macchine elettriche ideali (pure inerzie)"
  import Modelica.Constants.*;
  parameter Real vMass = 1300;
  parameter Real wICE = 167 "rad/s";
  Modelica.Units.SI.Power genPow0 = genTau.tau * der(genTau.flange.phi);
  // rad/s
  Modelica.Blocks.Nonlinear.Limiter limTgen(uMax = 30) annotation (
    Placement(visible = true, transformation(origin = {-86, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Math.Feedback feedback1 annotation (
    Placement(visible = true, transformation(extent = {{-22, -46}, {-42, -66}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback feedback annotation (
    Placement(visible = true, transformation(extent = {{-14, 62}, {-34, 42}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = -10) annotation (
    Placement(visible = true, transformation(extent = {{-54, -66}, {-74, -46}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.Torque genTau annotation (
    Placement(visible = true, transformation(extent = {{-82, -18}, {-64, 0}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia mot(w(fixed = false, displayUnit = "rpm"), J = 0.59) annotation (
    Placement(visible = true, transformation(extent = {{28, -8}, {48, 12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia gen(w(fixed = false, displayUnit = "rpm"), J = 0.25) annotation (
    Placement(visible = true, transformation(extent = {{-58, -18}, {-38, 2}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor propPow annotation (
    Placement(visible = true, transformation(origin = {38, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor icePow annotation (
    Placement(visible = true, transformation(extent = {{-30, 12}, {-10, 32}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor genPow annotation (
    Placement(visible = true, transformation(extent = {{-32, -18}, {-12, 2}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant iceSetW(k = 300) annotation (
    Placement(visible = true, transformation(origin = {18, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Sources.Torque iceTau annotation (
    Placement(visible = true, transformation(extent = {{-80, 12}, {-60, 32}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor iceW annotation (
    Placement(visible = true, transformation(origin = {10, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Translational.Sensors.PowerSensor vhPow annotation (
    Placement(visible = true, transformation(origin = {93, -35}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
  Modelica.Mechanics.Translational.Components.Mass mass(v(fixed = true, start = 0, displayUnit = "km/h"), m = 1300) annotation (
    Placement(visible = true, transformation(origin = {65, -35}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor vhVel annotation (
    Placement(visible = true, transformation(origin = {70, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.31) annotation (
    Placement(visible = true, transformation(extent = {{84, -6}, {100, 10}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio = 3.905) annotation (
    Placement(visible = true, transformation(extent = {{56, -8}, {76, 12}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia ICE(J = 0.73, w(fixed = true, start = iceSetW.k, displayUnit = "rad/s")) annotation (
    Placement(visible = true, transformation(extent = {{-54, 12}, {-34, 32}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.IdealPlanetary PSD(ratio = 78 / 30) annotation (
    Placement(visible = true, transformation(origin = {10, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant vRef(k = 130 / 3.6) annotation (
    Placement(visible = true, transformation(origin = {-3, -55}, extent = {{-9, -9}, {9, 9}}, rotation = 180)));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragForce(fc = 0.014, rho = 1.226, S = 2.2, Cx = 0.26, m = mass.m) annotation (
    Placement(visible = true, transformation(origin = {107, -62}, extent = {{-9, -9}, {9, 9}}, rotation = 90)));
  Modelica.Blocks.Math.Gain gain1(k = 10) annotation (
    Placement(transformation(extent = {{-42, 42}, {-62, 62}})));
equation
  connect(dragForce.flange, vhPow.flange_b) annotation (
    Line(points = {{107, -53}, {108, -53}, {108, -54}, {110, -54}, {110, -34}, {102, -34}, {102, -35}}, color = {0, 127, 0}));
  connect(vRef.y, feedback1.u1) annotation (
    Line(points = {{-12.9, -55}, {-11.9, -55}, {-11.9, -56}, {-24, -56}}, color = {0, 0, 127}));
  connect(PSD.ring, mot.flange_a) annotation (
    Line(points = {{20, 2}, {28, 2}}));
  connect(PSD.carrier, icePow.flange_b) annotation (
    Line(points = {{-5.55112e-16, 6}, {-5.55112e-16, 22}, {-10, 22}}));
  connect(genPow.flange_b, PSD.sun) annotation (
    Line(points = {{-12, -8}, {-12, -8}, {0, -8}, {0, 2}}));
  connect(icePow.flange_a, ICE.flange_b) annotation (
    Line(points = {{-30, 22}, {-34, 22}}));
  connect(iceTau.flange, ICE.flange_a) annotation (
    Line(points = {{-60, 22}, {-54, 22}}));
  connect(idealGear.flange_a, mot.flange_b) annotation (
    Line(points = {{56, 2}, {48, 2}}));
  connect(wheel.flangeR, idealGear.flange_b) annotation (
    Line(points = {{84, 2}, {76, 2}}));
  connect(wheel.flangeT, propPow.flange_a) annotation (
    Line(points = {{100, 2}, {112, 2}, {112, -22}, {20, -22}, {20, -34}, {28, -34}}, color = {0, 127, 0}));
  connect(vhVel.v, feedback1.u2) annotation (
    Line(points = {{59, -60}, {11.5, -60}, {11.5, -36}, {-31.25, -36}, {-31.25, -48}, {-32, -48}}, color = {0, 0, 127}));
  connect(vhVel.flange, vhPow.flange_a) annotation (
    Line(points = {{80, -60}, {80, -35}, {84, -35}}, color = {0, 127, 0}));
  connect(propPow.flange_b, mass.flange_a) annotation (
    Line(points = {{48, -34}, {54, -34}, {54, -35}}, color = {0, 127, 0}));
  connect(vhPow.flange_a, mass.flange_b) annotation (
    Line(points = {{84, -35}, {76, -35}}, color = {0, 127, 0}));
  connect(feedback.u2, iceW.w) annotation (
    Line(points = {{-24, 60}, {-24, 70}, {-1, 70}}, color = {0, 0, 127}));
  connect(icePow.flange_b, iceW.flange) annotation (
    Line(points = {{-10, 22}, {40, 22}, {40, 70}, {20, 70}}));
  connect(feedback.u1, iceSetW.y) annotation (
    Line(points = {{-16, 52}, {-8, 52}, {-8, 40}, {7, 40}}, color = {0, 0, 127}));
  connect(genPow.flange_a, gen.flange_b) annotation (
    Line(points = {{-32, -8}, {-38, -8}}));
  connect(gen.flange_a, genTau.flange) annotation (
    Line(points = {{-58, -8}, {-62, -8}, {-62, -9}, {-64, -9}}));
  connect(limTgen.y, genTau.tau) annotation (
    Line(points = {{-86, -29}, {-90, -29}, {-90, -10}, {-86, -10}, {-86, -9}, {-83.8, -9}}, color = {0, 0, 127}));
  connect(limTgen.u, gain.y) annotation (
    Line(points = {{-86, -52}, {-86, -56}, {-75, -56}}, color = {0, 0, 127}));
  connect(feedback1.y, gain.u) annotation (
    Line(points = {{-41, -56}, {-52, -56}}, color = {0, 0, 127}));
  connect(feedback.y, gain1.u) annotation (
    Line(points = {{-33, 52}, {-40, 52}}, color = {0, 0, 127}));
  connect(gain1.y, iceTau.tau) annotation (
    Line(points = {{-63, 52}, {-74, 52}, {-92, 52}, {-92, 22}, {-82, 22}}, color = {0, 0, 127}));
  annotation (
    experiment(StopTime = 120, Interval = 0.5),
    __Dymola_experimentSetupOutput,
    Documentation(info = "<html>
<h4>newInst OK</h4>
<h4>Modello di base per mostrare le prime funzionalit&agrave; di un sistema basato su PSD.</h4>
<p><br><u>Obiettivo finale</u>: simulazione di principio di Toyota Prius </p>
<p><u>Obiettivo di questa simulazione</u>: </p>
<p>Analizzare i punti di lavoro del PSD in un transitorio in cui il veicolo partendo da 0 accelera fino alla velocit&agrave; di 100 km/h, agendo sul gen; l&apos;ICE &egrave; mantenuto a velocit&agrave; costante da uno specifico controllo in retroazione. </p>
</html>"),
    conversion(noneFromVersion = ""),
    Icon(coordinateSystem(extent = {{-100, -80}, {120, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})),
    Diagram(coordinateSystem(extent = {{-100, -80}, {120, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics={  Text(origin = {18.4202, 31}, lineColor = {28, 108, 200}, extent = {{31.5798, 45}, {91.5798, 25}}, textString = "Valori iniziali:
velocità massa
velocità ICE
          "),
        Text(origin = {19.4729, 6}, lineColor = {238, 46, 47}, extent = {{30.5271, 54}, {88.5271, 30}}, textString = "Ripetere con valore più realistico 
di limTgen: 60Nm
Poi con velocità max di 120 km/h")}));
end PSBasic2;
