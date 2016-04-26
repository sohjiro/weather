defmodule Weather.CLI do

  import Weather.TableFormatter, only: [ print_table_for_columns: 2 ]

  @weather_columns ["location","station_id","latitude","longitude","observation_time","observation_time_rfc822","weather","temperature_string","dewpoint_string","relative_humidity","wind_string","visibility_mi","pressure_in"]

  def main(_argv) do
    Weather.CurrentObs.fetch()
    |> decode_response
    |> convert_to_list_of_maps
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from weather channel #{message}"
    System.halt(2)
  end

  def convert_to_list_of_maps(xml) do
    [convert_to_keyword(@weather_columns, xml)]
    |> Enum.map(&Enum.into(&1, Map.new))
  end

  defp convert_to_keyword([], _xml), do: []
  defp convert_to_keyword([header | t], xml) do
    [{header, Weather.XMLParser.text("/current_observation/#{header}", xml)} | convert_to_keyword(t, xml)]
  end

end
