model Test3 "Two 6-pulse equidistant bridges with 3 winding transformer"
  import Modelica.Electrical.Analog.Ideal;
  Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation(
    Placement(transformation(extent = {{-24, -24}, {24, 24}}, rotation = 180, origin = {286, -10}), iconTransformation(extent = {{280, -36}, {326, 10}})));
  Modelica.Blocks.Interfaces.RealOutput vdc1 annotation(
    Placement(transformation(extent = {{280, -168}, {344, -104}}), iconTransformation(extent = {{280, -174}, {328, -126}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation(
    Placement(transformation(extent = {{262, -114}, {310, -66}}), iconTransformation(extent = {{280, -112}, {326, -66}})));
  Modelica.Blocks.Interfaces.RealOutput idc1 annotation(
    Placement(transformation(extent = {{282, 2}, {344, 64}}), iconTransformation(extent = {{280, 26}, {328, 74}})));
  Modelica.Electrical.Polyphase.Interfaces.PositivePlug ac annotation(
    Placement(transformation(origin = {0, 82}, extent = {{-236, -72}, {-176, -12}}, rotation = 0)visible = true, iconTransformation(origin = {0, 0}, extent = {{-232, -74}, {-182, -28}}, rotation = 0),));
  Modelica.Blocks.Interfaces.RealInput Alpha annotation(
    Placement(transformation(,extent = {{-43, -43}, {43, 43}}, rotation = 0 origin = {-205, -111})visible = true, iconTransformation(,extent = {{-29, -29}, {29, 29}}, rotation = 0 origin = {-221, -147}),));
equation
  connect(pin_p, pin_p) annotation(
    Line(points = {{286, -10}, {286, -10}}, color = {0, 0, 255}));
  connect(ac, ac) annotation(
    Line(points = {{-206, 40}, {-206, 40}}, color = {0, 0, 255}));
  connect(pin_n, pin_n) annotation(
    Line(points = {{286, -90}, {286, -90}}, color = {0, 0, 255}));
  annotation(
    Placement(transformation(origin = {-314, 82}, extent = {{-10, -10}, {10, 10}}, rotation = 180)),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-200, -200}, {280, 100}})),
    experiment(StopTime = 0.6, StartTime = 0, Tolerance = 1e-06, Interval = 6e-05),

    Icon(coordinateSystem(extent = {{-200, -200}, {280, 100}}, preserveAspectRatio = false), graphics = {Rectangle(fillColor = {255, 255, 255}, pattern = LinePattern.Solid, fillPattern = FillPattern.Solid, extent = {{-200, 100}, {280, -200}}), Text(origin = {54, -46}, rotation = 180, textColor = {0, 0, 217}, extent = {{-228, 42}, {228, -42}}, textString = "HVDC Pole"), Text(origin = {76.4197, 85.9999}, textColor = {0, 0, 227}, extent = {{-338.42, 92.0001}, {263.58, 16.0001}}, textString = "%name")}),
    uses(Modelica(version = "4.0.0"), HVDCPulseGeneratorAndPLL(version = "3")));
end Test3;