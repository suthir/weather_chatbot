module ApplicationHelper
  def replace_string(prompt, replacement)
    prompt.gsub(/\b(in|this|is|the|weather)\b/i, replacement)
  end

  def find_city(prompt)
    match = prompt.match(/(?:in|at|for|like)\s+([\w\s\-]+?)(?=\s*(?:,|\?|\.|!|$|\b(?:today|tomorrow|tonight|morning|afternoon|evening|night)\b))/i)
    city = match[1].strip if match
    to_camel_case(replace_string(city, "").strip)
  end

  def to_camel_case(str)
    str.split.map(&:capitalize).join(" ")
  end
end
