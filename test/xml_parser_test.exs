defmodule Weather.XMLParserTest do

  use ExUnit.Case

  def xml do
    """
    <?xml version="1.0" encoding="UTF-8"?>
    <note>
      <to>Tove</to>
      <from>Jani</from>
      <heading>Reminder</heading>
      <body>Don't forget me this weekend!</body>
    </note>
    """
  end

  test "extracting text from xml" do
    xml_parse = Weather.XMLParser.parse!( xml )

    to = Weather.XMLParser.text('/note/to', xml_parse)
    from = Weather.XMLParser.text('/note/from', xml_parse)

    assert to == "Tove"
    assert from == "Jani"
  end


end
