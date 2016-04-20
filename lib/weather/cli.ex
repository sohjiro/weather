defmodule Weather.CLI do


  def main(_argv) do
    Weather.CurrentObs.fetch()
  end


end
