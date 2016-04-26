defmodule Weather.XMLParser do
  require Record

  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText,    from_lib: "xmerl/include/xmerl.hrl")


  def parse!(string_xml) do
    {xml, _rest} = string_xml
                   |> to_char_list
                   |> :xmerl_scan.string
    xml
  end

  def text(path, xml) do
    [element]  = :xmerl_xpath.string(path, xml)
    [text]     = xmlElement(element, :content)
    value      = xmlText(text, :value)

    to_string(value)
  end

end
