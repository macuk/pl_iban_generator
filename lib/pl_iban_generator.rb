class PlIbanGenerator
  class NumberInvalid < Exception; end

  attr_accessor :bank_code, :account_no, :prefix

  def initialize(bank_code, account_no, prefix='PL')
    self.bank_code = bank_code
    self.account_no = account_no
    @prefix = prefix.to_s
  end

  def bank_code=(bank_code)
    @bank_code = bank_code.to_s.gsub(/\D/, '')
    msg = 'Wrong bank code number length!'
    raise NumberInvalid, msg if @bank_code.size != 8
  end

  def account_no=(account_no)
    @account_no = account_no.to_s.gsub(/\D/, '')
    msg = 'Wrong account number length!'
    raise NumberInvalid, msg if @account_no.size != 16
  end

  def get
    @prefix + check_digits + @bank_code + @account_no
  end

  def to_s
    n = get
    return n.gsub(/(.{4})/, '\1 ').strip if n.size == 28
    return n[0..1] + ' ' + n[2..-1].gsub(/(.{4})/, '\1 ').strip if n.size == 26
  end

  private
    def check_digits
      n = @bank_code + @account_no + '252100' # A=10, B=11, ..., L=21, P=25, ... + '00'
      sprintf('%02d', 98 - (n.to_i % 97))
    end
end
