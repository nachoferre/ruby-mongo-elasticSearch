class Operation
  include Mongoid::Document
  include Mongoid::Enum

  after_create :calculate_result



  #enum, :operations [:add, :sub, :mul, :div]
#["+", "-", "*", "/"]
  field :op, type: String
  field :time0, type: Float
  field :time1, type: Float
  field :timetot, type: Float
  field :num1, type: Integer
  field :num2, type: Integer
  field :resultado, type: Integer

  def total_time
      update_attributes(timetot: (time1 - time0))
  end

  def check_result(result)
      resultado == result
  end

  private
    def calculate_result
        update_attributes(resultado: num1.public_send(op,num2))
    end
end
