within EHPTexamples.PSD.BasicPT;
model EleBalanceSim "Bilanciamento elettrico con simulazione (v. Epicicloidale.docx)"
  import Modelica.Constants.*;
  parameter Real vMass = 1300;
  parameter Real rho = 78 / 30;
  parameter Real sigma = 1 / rho;
  //  Real Tm = sigma * gear.flange_a.tau * wGen.w / (wMot.w + sigma * wGen.w);
  Real Tm = gear.flange_a.tau * ((1 + sigma) * wIce.w - wMot.w) / ((1 + sigma) * wIce.w);
  Real negPmot = -Tm * wMot.w;
  Modelica.Mechanics.Rotational.Components.IdealPlanetary PSD(ratio = rho) annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {-6, 0})));
  Modelica.Mechanics.Rotational.Components.Inertia ice(J = 0.73, w(fixed = true, start = 300, displayUnit = "rad/s")) annotation (
    Placement(transformation(extent = {{44, 50}, {64, 70}})));
  Modelica.Mechanics.Rotational.Components.IdealGear gear(ratio = 3.905) annotation (
    Placement(transformation(extent = {{46, -10}, {66, 10}})));
  Modelica.Mechanics.Rotational.Components.IdealRollingWheel wheel(radius = 0.31) annotation (
    Placement(transformation(extent = {{70, -8}, {86, 8}})));
  Modelica.Mechanics.Translational.Sensors.SpeedSensor carVel annotation (
    Placement(transformation(extent = {{-9, -9}, {9, 9}}, rotation = 180, origin = {105, -43})));
  Modelica.Mechanics.Translational.Components.Mass mass(m = vMass, v(fixed = true, displayUnit = "km/h", start = 1.0)) annotation (
    Placement(transformation(extent = {{-9, -9}, {9, 9}}, rotation = 0, origin = {121, 1})));
  Modelica.Mechanics.Translational.Sensors.PowerSensor pResis annotation (
    Placement(transformation(extent = {{-6, -6}, {6, 6}}, rotation = 270, origin = {132, -24})));
  EHPTlib.SupportModels.Miscellaneous.DragForce dragForce(fc = 0.014, rho = 1.226, m = vMass, S = 2.2, Cx = 0.26) annotation (
    Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 90, origin = {131, -49})));
  Modelica.Mechanics.Rotational.Sources.Torque tauIce annotation (
    Placement(transformation(extent = {{16, 50}, {36, 70}})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor pGen annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 90, origin = {-20, -28})));
  Modelica.Mechanics.Rotational.Sensors.PowerSensor pIce annotation (
    Placement(transformation(extent = {{-10, 10}, {10, -10}}, rotation = 180, origin = {12, 36})));
  Modelica.Mechanics.Translational.Sensors.PowerSensor pProp annotation (
    Placement(transformation(extent = {{-7, -7}, {7, 7}}, rotation = 0, origin = {99, 1})));
  Modelica.Mechanics.Rotational.Components.Inertia gen(w(fixed = false, displayUnit = "rpm"), J = 0.1) annotation (
    Placement(transformation(extent = {{-46, -58}, {-26, -38}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor wGen annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = 0, origin = {-48, 0})));
  Modelica.Blocks.Math.Feedback fbIce annotation (
    Placement(transformation(extent = {{-46, 50}, {-26, 70}})));
  EHPTlib.SupportModels.MapBasedRelated.InertiaTq mot(J = 0.1) annotation (
    Placement(transformation(extent = {{12, -10}, {32, 10}})));
  Modelica.Mechanics.Rotational.Sources.Torque tauGen annotation (
    Placement(transformation(extent = {{-70, -58}, {-50, -38}})));
  Modelica.Blocks.Math.Gain gain(k = -50.0) annotation (
    Placement(transformation(extent = {{18, -76}, {-2, -56}})));
  Modelica.Blocks.Math.Feedback fbGen annotation (
    Placement(transformation(extent = {{50, -56}, {30, -76}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 30, duration = 30) annotation (
    Placement(transformation(extent = {{84, -76}, {64, -56}})));
  Modelica.Blocks.Sources.RealExpression tauM(y = Tm) annotation (
    Placement(transformation(extent = {{50, -36}, {30, -16}})));
  Modelica.Blocks.Sources.Constant const(k = 300) annotation (
    Placement(transformation(extent = {{-72, 50}, {-52, 70}})));
  Modelica.Blocks.Math.Gain gain1(k = 100) annotation (
    Placement(transformation(extent = {{-18, 50}, {2, 70}})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor wIce annotation (
    Placement(transformation(extent = {{10, -10}, {-10, 10}}, rotation = -90, origin = {-36, 26})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor wMot annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 0, origin = {60, 20})));
equation
  connect(wheel.flangeR, gear.flange_b) annotation (
    Line(points = {{70, 0}, {66, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(pResis.flange_a, mass.flange_b) annotation (
    Line(points = {{132, -18}, {132, 1}, {130, 1}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(carVel.flange, pResis.flange_a) annotation (
    Line(points = {{114, -43}, {114, -18}, {132, -18}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(dragForce.flange, pResis.flange_b) annotation (
    Line(points = {{131, -42}, {132, -42}, {132, -30}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(tauIce.flange, ice.flange_a) annotation (
    Line(points = {{36, 60}, {44, 60}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(pGen.flange_b, PSD.sun) annotation (
    Line(points = {{-20, -18}, {-20, 0}, {-16, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(pIce.flange_a, ice.flange_b) annotation (
    Line(points = {{22, 36}, {78, 36}, {78, 60}, {64, 60}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(PSD.carrier, pIce.flange_b) annotation (
    Line(points = {{-16, 4}, {-16, 36}, {2, 36}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(pProp.flange_a, wheel.flangeT) annotation (
    Line(points = {{92, 1}, {90, 1}, {90, 0}, {86, 0}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(pProp.flange_b, mass.flange_a) annotation (
    Line(points = {{106, 1}, {112, 1}}, color = {0, 127, 0}, smooth = Smooth.None));
  connect(pGen.flange_a, gen.flange_b) annotation (
    Line(points = {{-20, -38}, {-20, -48}, {-26, -48}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(wGen.flange, PSD.sun) annotation (
    Line(points = {{-38, 0}, {-16, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(gear.flange_a, mot.flange_b) annotation (
    Line(points = {{46, 0}, {32, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(PSD.ring, mot.flange_a) annotation (
    Line(points = {{4, 0}, {12, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(gen.flange_a, tauGen.flange) annotation (
    Line(points = {{-46, -48}, {-50, -48}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(fbGen.y, gain.u) annotation (
    Line(points = {{31, -66}, {20, -66}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(gain.y, tauGen.tau) annotation (
    Line(points = {{-3, -66}, {-78, -66}, {-78, -48}, {-72, -48}, {-72, -48}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(fbGen.u2, carVel.v) annotation (
    Line(points = {{40, -58}, {40, -43}, {95.1, -43}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(fbGen.u1, ramp.y) annotation (
    Line(points = {{48, -66}, {63, -66}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(tauM.y, mot.tau) annotation (
    Line(points = {{29, -26}, {16.55, -26}, {16.55, -10}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(const.y, fbIce.u1) annotation (
    Line(points = {{-51, 60}, {-44, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(wIce.flange, PSD.carrier) annotation (
    Line(points = {{-36, 16}, {-22, 16}, {-22, 4}, {-16, 4}}, color = {0, 0, 0}, smooth = Smooth.None));
  connect(wIce.w, fbIce.u2) annotation (
    Line(points = {{-36, 37}, {-36, 52}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(tauIce.tau, gain1.y) annotation (
    Line(points = {{14, 60}, {3, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(gain1.u, fbIce.y) annotation (
    Line(points = {{-20, 60}, {-27, 60}}, color = {0, 0, 127}, smooth = Smooth.None));
  connect(wMot.flange, mot.flange_b) annotation (
    Line(points = {{50, 20}, {38, 20}, {38, 0}, {32, 0}}, color = {0, 0, 0}, smooth = Smooth.None));
  annotation (
    experiment(StopTime = 40, Interval = 0.1),
    __Dymola_experimentSetupOutput,
    Documentation(info = "<html><head></head><body><p></p><h4>newInst OK</h4><h4>Modello di base per mostrare le prime funzionalità di un sistema basato su PSD.</h4><p></p>
    <p><br><u>Obiettivo finale</u>: simulazione di principio di Toyota Prius</p>
    <p><u>Obiettivo di questa simulazione</u>: </p>
    <p>Mostrare il controllo in bilanciamento elettrico.</p>
    </body></html>"),
    conversion(noneFromVersion = ""),
    Diagram(coordinateSystem(extent = {{-80, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2}), graphics),
    Icon(coordinateSystem(extent = {{-80, -80}, {140, 80}}, preserveAspectRatio = false, initialScale = 0.1, grid = {2, 2})));
end EleBalanceSim;
