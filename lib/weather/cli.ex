defmodule Weather.CLI do

  @weather_columns ["location","station_id","latitude","longitude","observation_time","observation_time_rfc822","weather","temperature_string","dewpoint_string","relative_humidity","wind_string","visibility_mi","pressure_in"]

  def main(_argv) do
    Weather.CurrentObs.fetch()
    |> decode_response
    |> print_table_for_columns(@weather_columns)
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from weather channel #{message}"
    System.halt(2)
  end

end
