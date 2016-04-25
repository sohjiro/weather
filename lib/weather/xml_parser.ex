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

  def parse_node(path, xml) do
    [element]  = :xmerl_xpath.string('/breakfast_menu/food[1]/description', xml)
    [text]     = xmlElement(element, :content)
    value      = xmlText(text, :value)
    IO.inspect to_string(value)
    value
  end

  defp extract_text([xmlText(value: value)]), do: List.to_string(value)
  defp extract_text(x) do
    IO.puts "x : #{inspect x}"
    nil
  end


end
