within EHPTexamples.ElectricDrives;
model wFollowing "Compares U/f=cost and mains start-ups"
  //
  import Modelica.Constants.pi;
  extends Modelica.Icons.Example;
  Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox annotation (
    Placement(visible = true, transformation(extent = {{4, 14}, {24, 34}}, rotation = 0)));
  Modelica.Electrical.Machines.BasicMachines.InductionMachines.IM_SquirrelCage aimc annotation (
    Placement(visible = true, transformation(extent = {{4, -16}, {24, 4}}, rotation = 0)));
  Modelica.Electrical.Analog.Basic.Ground ground annotation (
    Placement(visible = true, transformation(extent = {{-98, -36}, {-78, -16}}, rotation = 0)));
  Modelica.Electrical.Polyphase.Basic.Star star annotation (
    Placement(visible = true, transformation(origin = {-88, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  EHPTlib.SupportModels.Miscellaneous.AronSensor pUp annotation (
    Placement(visible = true, transformation(extent = {{-38, 14}, {-20, 32}}, rotation = 0)));
  Modelica.Electrical.Polyphase.Sources.SignalVoltage signalV annotation (
    Placement(visible = true, transformation(origin = {-58, 23}, extent = {{-10, -9}, {10, 9}}, rotation = 180)));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (
    Placement(visible = true, transformation(origin = {75, -27}, extent = {{-7, -7}, {7, 7}}, rotation = 270)));
  Modelica.Electrical.Polyphase.Sensors.CurrentSensor iUp annotation (
    Placement(visible = true, transformation(origin = {-6, 40}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 0.5, w(fixed=
          true, start=0))                                           annotation (
    Placement(visible = true, transformation(extent = {{34, -16}, {54, 4}}, rotation = 0)));
  EHPTlib.ElectricDrives.ASMArelated.ControlLogic logic(Rr = aimc.Rr, Rs = aimc.Rs, wmMax = 314.16 / 2, uBase = 100 * sqrt(3), Lstray = aimc.Lssigma + aimc.Lrsigma, pp = aimc.p) annotation (
    Placement(visible = true, transformation(extent = {{-28, -54}, {-48, -34}}, rotation = 0)));
  EHPTlib.ElectricDrives.ASMArelated.GenSines genSines annotation (
    Placement(visible = true, transformation(origin = {-59, -6}, extent = {{11, -10}, {-11, 10}}, rotation = -90)));
  Modelica.Blocks.Sources.Trapezoid wReq(amplitude = 1000, falling = 2, offset = 0, period = 100, rising = 2, startTime = 2, width = 3) annotation (
    Placement(visible = true, transformation(origin = {59, -41}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque tqRes(tau_nominal = -150, w_nominal = 157.08) annotation (
    Placement(visible = true, transformation(origin = {100, -6}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.UnitConversions.From_rpm fromRpm annotation (
    Placement(visible = true, transformation(origin = {35, -41}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Feedback fb annotation (
    Placement(visible = true, transformation(origin = {10, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 20) annotation (
    Placement(visible = true, transformation(origin = {-13, -41}, extent = {{7, -7}, {-7, 7}}, rotation = 0)));
equation
  connect(gain.u, fb.y) annotation (
    Line(points = {{-4.6, -41}, {1, -41}, {1, -40}}, color = {0, 0, 127}));
  connect(gain.y, logic.Tstar) annotation (
    Line(points = {{-20.7, -41}, {-26.1, -41}, {-26.1, -44.1}}, color = {0, 0, 127}));
  connect(fb.u1, fromRpm.y) annotation (
    Line(points = {{18, -40}, {28, -40}, {28, -40}, {28, -41}, {27.3, -41}}, color = {0, 0, 127}));
  connect(fb.u2, speedSensor.w) annotation (
    Line(points = {{10, -48}, {10, -54}, {80, -54}, {80, -34.7}, {75, -34.7}}, color = {0, 0, 127}));
  connect(fromRpm.u, wReq.y) annotation (
    Line(points = {{43.4, -41}, {51.3, -41}}, color = {0, 0, 127}));
  connect(logic.Wm, speedSensor.w) annotation (
    Line(points = {{-38.1, -55.3}, {-38.1, -64.3}, {75, -64.3}, {75, -34.7}}, color = {0, 0, 127}));
  connect(genSines.Ustar, logic.Ustar) annotation (
    Line(points = {{-64.9, -18.43}, {-63.9, -18.43}, {-63.9, -50}, {-49, -50}}, color = {0, 0, 127}));
  connect(genSines.Westar, logic.Westar) annotation (
    Line(points = {{-53.1, -18.43}, {-54.1, -18.43}, {-54.1, -36.43}, {-52.6, -36.43}, {-52.6, -38}, {-49, -38}}, color = {0, 0, 127}));
  connect(inertia.flange_b, tqRes.flange) annotation (
    Line(points = {{54, -6}, {90, -6}}));
  connect(speedSensor.flange, inertia.flange_b) annotation (
    Line(points = {{75, -20}, {74.5, -20}, {74.5, -8}, {74, -8}, {74, -6}, {54, -6}}));
  connect(genSines.U, signalV.v) annotation (
    Line(points = {{-59, 6.1}, {-58, 6.1}, {-58, 12.2}}, color = {0, 0, 127}));
  connect(terminalBox.plug_sn, aimc.plug_sn) annotation (
    Line(points = {{8, 18}, {8, 4}}, color = {0, 0, 255}));
  connect(terminalBox.plug_sp, aimc.plug_sp) annotation (
    Line(points = {{20, 18}, {20, 4}}, color = {0, 0, 255}));
  connect(iUp.plug_n, terminalBox.plugSupply) annotation (
    Line(points = {{2, 40}, {14, 40}, {14, 20}}, color = {0, 0, 255}));
  connect(inertia.flange_a, aimc.flange) annotation (
    Line(points = {{34, -6}, {24, -6}}));
  connect(ground.p, star.pin_n) annotation (
    Line(points = {{-88, -16}, {-88, -2}}, color = {0, 0, 255}));
  connect(signalV.plug_n, star.plug_p) annotation (
    Line(points = {{-68, 23}, {-88, 23}, {-88, 18}}, color = {0, 0, 255}));
  connect(pUp.pc, signalV.plug_p) annotation (
    Line(points = {{-38, 23}, {-42, 23}, {-42, 24}, {-44, 24}, {-44, 23}, {-48, 23}}, color = {0, 0, 255}));
  connect(iUp.plug_p, pUp.nc) annotation (
    Line(points = {{-14, 40}, {-20, 40}, {-20, 23}}, color = {0, 0, 255}));
  annotation (
    Documentation(info = "<html>
<p>This system simulates variable-frequency start-up of an asyncronous motor.</p>
<p>Two different sources for the machine re compared.</p>
<p>The motor supply is constituted by a three-phase system of quasi-sinusoidal shapes, created according to the following equations:</p>
<p>WEl=WMecc*PolePairs+DeltaWEl</p>
<p>U=U0+(Un-U0)*WEl/WNom</p>
<p>where:</p>
<p><ul>
<li>U0, Un U, are initial, nominal actual voltage amplitudes</li>
<li>WMecc, WEl, are machine, mechanical and supply, electrical angular speeds</li>
<li>PolePairs are the machine pole pairs</li>
<li>delta WEl is a fixed parameter during the simulation, except when the final speed is reached</li>
</ul></p>
<p>When the final speed is reached, the feeding frequenccy and voltage are kept constant (no flux weaking simulated)</p>
</html>"),
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}})),
    Diagram(coordinateSystem(extent = {{-100, -80}, {120, 60}}, preserveAspectRatio = false),
      graphics={  Rectangle(origin = {-57, 26}, lineColor = {255, 0, 0},
      pattern = LinePattern.Dash, extent = {{-15, 10}, {15, -48}}),
      Text(origin={-30,-7},    extent = {{-8, 3}, {8, -3}}, textString = "simulates\ninverter")}),
    experiment(StartTime = 0, StopTime = 12, Tolerance = 0.0001, Interval = 0.0024),
    __OpenModelica_commandLineOptions = "");
end wFollowing;
