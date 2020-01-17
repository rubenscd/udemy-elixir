defmodule Cards do
  @moduledoc """
    Contem metodos que criam e manipulam um baralho de cartas
  """

  @doc """
    Cria um baralho com a sequencia de cartas e naipes fornecida

  ## Examples

      iex> Cards.create_deck
      ["A♦", "2♦", "3♦", "4♦", "5♦", "6♦", "7♦", "8♦", "9♦",
      "10♦", "J♦", "Q♦", "K♦", "A♠", "2♠", "3♠", "4♠", "5♠",
      "6♠", "7♠", "8♠", "9♠", "10♠", "J♠", "Q♠", "K♠", "A♥",
      "2♥", "3♥", "4♥", "5♥", "6♥", "7♥", "8♥", "9♥", "10♥",
      "J♥", "Q♥", "K♥", "A♣", "2♣", "3♣", "4♣", "5♣", "6♣",
      "7♣", "8♣", "9♣", "10♣", "J♣", "Q♣", "K♣"]

  """
  def create_deck do
    # cartas
    # values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    # valores = ["Ás", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Valete", "Dama", "Rei", "Coringa"]
    # suits = ["Diamonds", "Spades", "Hearts", "Clubs"]
    # naipes = ["Ouros", "Espadas", "Copas", "Paus"]
    values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    suits = ["♦", "♠", "♥", "♣"]

    # modo grosseiro de iterar um array com outro array
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value}#{suit}"
    #   end
    # end
    # List.flatten(cards)

    for suit <- suits, value <- values do
      "#{value}#{suit}"
    end
  end

  @doc """
    embaralha o deck de cartas

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.shuffle(deck)
      ["A♠", "3♣", "10♠", "2♣", "6♥", "8♣", "Q♣", "2♦", "6♣", ...()]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    checa se uma carta esta no baralho

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "1♠")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    prepara uma mao de cartas com a quantidade solicitada pela variavel `hand_size`

  ## Examples

    iex> deck = Cards.create_deck
    iex> {hand, _} = Cards.deal(deck, 1)
    iex> hand
    ["A♦"]

  """
  def deal(deck, hand_size) do
    # resultado sempre um tuple { [ hand ], [ deck ] }
    Enum.split(deck, hand_size)
  end

  @doc """
    salva o baralho atual em formato binario
    (arquivo localizado na raiz do projeto)

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.save(deck, "meu_maco")
      :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    recupera um baralho salvo anteriormente em formato binario
    (arquivo localizado na raiz do projeto)

  ## Examples

      iex> Cards.load(deck(), "meu_maco")
      :ok

  """
  def load(filename) do

    # modo grosseiro de fazer
    # { status, binary } = File.read(filename)
    # evitando IF statment
    # case status do
    #   :ok -> :erlang.binary_to_term(binary)
    #   :error -> "algo deu errado, arquivo não encontrado"
    # end

    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      # _ na frente de assign/variaveis faz com que ele viva durante o escopo do uso nao precisa ser declarada anteriormente
      {:error, _reason} -> "algo deu errado, arquivo não encontrado"
    end
  end

  @doc """
    Cria o baralho, embaralha e já disponibiliza uma mao com a `hand_size` quantidade de cartas informadas

  ## Examples

      iex> deck = Cards.create_hand(3)
      iex> deck
      {["Q♦", "8♦", "2♥"], ["7♥", "7♦", "4♥", "8♥", "A♣", "7♠", "A♦", "2♦", "K♠", ...()]}

  """
  def create_hand(hand_size) do
    # modo antiquado de usar uma sequencia de funcoes
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    # estilo de uso do pipe operator, automaticamente utiliza o primeiro argumento da funcao e repassa para sequencia, sempre como primeiro argumento
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
