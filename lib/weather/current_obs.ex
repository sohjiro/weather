defmodule Weather.CurrentObs do

  def fetch do
    weather_url
    |> HTTPoison.get
    |> handle_response
  end

  def weather_url do
    "http://w1.weather.gov/xml/current_obs/KDTO.xml"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, Weather.XMLParser.parse!(body)}
  end

  def handle_response({_, %{status_code: status, body: body}}) do
    {:ok, Weather.XMLParser.parse!(body)}
  end

end
