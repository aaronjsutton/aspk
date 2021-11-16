defmodule ASPK.Generator do
  @moduledoc """
  Cryptographic generator functions.
  """

  @alphabet Enum.concat([?0..?9, ?A..?Z, ?a..?z])
  @id_length 6
  @secret_length 32

  @doc """
  Generates a cryptographically strong secret string value.
  """
  def generate_secret do
    :crypto.strong_rand_bytes(@secret_length)
    |> Base.encode64()
  end

	@doc """
	Generate a key identifier.
	"""
  def generate_id() do
    :rand.seed(:exsplus, :os.timestamp())

    Stream.repeatedly(&random_char_from_alphabet/0)
    |> Enum.take(@id_length)
    |> List.to_string()
    |> String.downcase()
  end

  defp random_char_from_alphabet() do
    Enum.random(@alphabet)
  end
end
