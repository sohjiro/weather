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
    path
    |> :xmerl_xpath.string(xml)
    |> extract_text
  end

  defp extract_text([xmlText(value: value)]), do: List.to_string(value)
  defp extract_text(_x), do: nil


end
