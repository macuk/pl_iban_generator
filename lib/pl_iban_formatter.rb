class PlIbanFormatter
  class NumberInvalid < Exception; end

  def initialize(number)
    @number = number
    msg = "Wrong bank account number length!"
    raise NumberInvalid, msg unless [26, 28].include?(@number.size)
  end

  def get
    case @number.size
    when 28
      @number.gsub(/(.{4})/, '\1 ').strip
    when 26
      @number[0..1] + ' ' + @number[2..-1].gsub(/(.{4})/, '\1 ').strip
    end
  end
end
