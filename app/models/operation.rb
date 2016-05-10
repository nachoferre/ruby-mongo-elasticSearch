class Operation
  include Mongoid::Document
  include Mongoid::Enum

  after_create :calculate_result_estimation



  #enum, :operations [:add, :sub, :mul, :div]
#["+", "-", "*", "/"]
  field :op, type: String
  field :time0, type: Float
  field :time1, type: Float
  field :timetot, type: Float
  field :num1, type: Integer
  field :num2, type: Integer
  field :resultado, type: Integer
  field :estimacion, type: String

  def total_time
      update_attributes(timetot: (time1 - time0))
  end

  def check_result(result)
      resultado == result
  end

 # def estimate
#      self.estimation = HTTP.get("http://localhost:5000/predict/#{op1.to_f}/").to_s
 # end

  private
    def calculate_result_estimation
        table = Hash["+" => 0, "-" => 1, "*" => 2, "/" => 3]
        update_attributes(resultado: num1.public_send(op,num2))
        update_attributes(estimacion: HTTP.get("http://localhost:5000/predict/#{num1.to_f}/#{num2.to_f}/#{table[op].to_f}/").to_s)
    end
end
