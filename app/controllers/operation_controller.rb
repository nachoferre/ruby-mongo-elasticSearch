def getrandom
  oper = ["+", "-", "*", "/"]
  return oper.sample
end

def submit(op1, op2, oper, res)
  puts op1, op2

end

class OperationController < ApplicationController

  # GET /peliculas/new
  def index

  end

  def new
      operator = ["+", "-", "*", "/"].sample
      @operation = Operation.create({
          time0: Time.new,
          num1: rand(1..99),
          num2: rand(1..99),
          op: operator
    })
  end

  def answer
      @operation = Operation.find(params[:id])
      if @operation.check_result(params[:operation][:resultado].to_i)
        @operation.update_attributes(time1: Time.now)
        @operation.total_time
        @operation.save
        flash[:success] = "Right!"
      else
          flash[:error] = "Wrong!"
          render :new
      end
  end
end
