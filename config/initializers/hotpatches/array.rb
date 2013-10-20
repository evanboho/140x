class Array

  def filter(arg)
    if arg.is_a? Hash
      ar = arg.collect { |k,v| [k.to_s, "==", v]}
      str = ar.collect { |s| "a[:#{s[0]}] #{s[1]} #{s[2] || 'nil'}" }.join(" && ")
    elsif arg.is_a? String
      s = arg.split(" ")
      str = "a[:#{s[0].to_s}] #{s[1]} #{s[2] || nil}"
    end
    puts str
    to_return = self.select { |a| eval(str)}
    return to_return
  end

end
