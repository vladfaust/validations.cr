class Hash(K, V)
  # Fetch *key* or set it to *value*.
  #
  # ```
  # h = {"foo" => "bar"}
  # h.fetch_or_set("foo", "baz"); pp h
  # # {"foo" => "bar"}
  # h.fetch_or_set("bar", "baz"); pp h
  # # {"foo" => "bar", "bar" => "baz"}
  # ```
  def fetch_or_set(key, value)
    if has_key?(key)
      self.[key]
    else
      self.[key] = value
    end
  end
end
