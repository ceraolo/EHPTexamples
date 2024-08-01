model Test1 "Two 6-pulse equidistant bridges with 3 winding transformer"
  import Modelica.Electrical.Analog.Ideal;
  parameter Modelica.Units.SI.Inductance Lsmooth = 225e-3 "Smoothing inductor";
  parameter Modelica.Units.SI.Resistance Rsmooth = 0.1 "Resistance of smoothing inductor";
  parameter Modelica.Units.SI.Current iStart = 30 "Initial current: flows in load and source";
  //Note that setting an initial current, if we do not want wrong initial voltage, must be combined with initial SCR state.
  parameter Modelica.Units.SI.Frequency f = 50 "line frequency";
  parameter Real BlockTime = 0 "Pulse initial blocking time";
  parameter Real Inverter = 1 "1 for inverter and 0 for rectifier operation";
  parameter Modelica.Units.SI.Resistance Rs = 24.75 "Snubber resistance";
  parameter Modelica.Units.SI.Capacitance Cs = 0.0013e-6 "Snubber capacitance";
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation(
    Placement(transformation(extent = {{-24, -24}, {24, 24}}, rotation = 180, origin = {286, -10}), iconTransformation(extent = {{280, -36}, {326, 10}})));
  Modelica.Blocks.Interfaces.RealOutput vdc1 annotation(
    Placement(transformation(extent = {{280, -168}, {344, -104}}), iconTransformation(extent = {{280, -174}, {328, -126}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation(
    Placement(transformation(extent = {{262, -114}, {310, -66}}), iconTransformation(extent = {{280, -112}, {326, -66}})));
  Modelica.Blocks.Interfaces.RealOutput idc1 annotation(
    Placement(transformation(extent = {{282, 2}, {344, 64}}), iconTransformation(extent = {{280, 26}, {328, 74}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac annotation(
    Placement(transformation(extent = {{-236, -72}, {-176, -12}}), iconTransformation(extent = {{-232, -74}, {-182, -28}})));
  Modelica.Blocks.Interfaces.RealInput Alpha annotation(
    Placement(transformation(extent = {{-43, -43}, {43, 43}}, rotation = 0, origin = {-205, -193}), iconTransformation(extent = {{-29, -29}, {29, 29}}, rotation = 0, origin = {-221, -147})));
equation
  connect(pin_p, pin_p) annotation(
    Line(points = {{286, -10}, {286, -10}}, color = {0, 0, 255}));
  connect(ac, ac) annotation(
    Line(points = {{-206, -42}, {-206, -42}}, color = {0, 0, 255}));
  connect(pin_n, pin_n) annotation(
    Line(points = {{286, -90}, {286, -90}}, color = {0, 0, 255}));
  annotation(
    Placement(transformation(origin = {-314, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 180)),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -200}, {280, 100}})),
    experiment(StopTime = 0.6, StartTime = 0, Tolerance = 1e-06, Interval = 6e-05),
    Documentation(info = "<html>
<p>In questo modello per accelerare l&apos;analisi del transitorio do un valore alla corrente iniziale diverso da 0, tramit ela variabile iStart.</p>
<p>Ovviamente questo &egrave; incompatibile con i valori di default degli stati iniziali delle valvole, tutti OFF.</p>
<p><br>Essendo la terna con r che sta per diventare positiva, siamo nel mezzo della pi&ugrave; alta tensione ts, quindi i diodi da tenere attivi sono 5 e 6. La corrente iStart, che esce dal morsetto DC, deve di conseguenza uscire da t e rientrare in s. Le correnti iniziali delle induttanze primarie sono selezionte in accordo con questa analisi.</p>
</html>", revisions = "<html>
  <p><b>Release Notes:</b></p>
  <ul>
  <li><i>Mai 7, 2004   </i>
         by Anton Haumer<br> realized<br>
         </li>
  </ul>
  </html>"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(extent = {{-200, -200}, {280, 100}}, preserveAspectRatio = false), graphics = {Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, extent = {{-200, 100}, {280, -200}}), Text(origin = {54, -46}, rotation = 180, textColor = {0, 0, 217}, extent = {{-228, 42}, {228, -42}}, textString = "HVDC Pole", fontName = MS), Text(origin = {76.4197, 85.9999}, textColor = {0, 0, 227}, extent = {{-338.42, 92.0001}, {263.58, 16.0001}}, textString = "%name", fontName = MS)}),
    uses(Modelica(version = "4.0.0"), HVDCPulseGeneratorAndPLL(version = "3")));
end Test1;