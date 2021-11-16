defmodule ASPK.Generator do
  @moduledoc """
  Cryptographic generator functions. These are used to generate identifier and
  secret strings for tokens.
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
  Generate a key identifier, a six-character string containing numbers and lowercase
  letters. Key identifiers are used to quickly look up corresponding hashes in the database,
  as to avoid a large number of hash comparisons when searching for a key.
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
