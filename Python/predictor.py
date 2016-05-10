from flask import Flask
from sklearn import linear_model
import pandas as panda
app = Flask(__name__)


from sklearn.externals import joblib

  # Cargo el modelo que he entrenado previamente.
predictors = ["op1", "operando", "op2"]
clf = linear_model.LinearRegression()
operation = panda.read_csv("allData.csv")
operation.loc[operation["operando"] == "/", "operando"] = 3
operation.loc[operation["operando"] == "*", "operando"] = 2
operation.loc[operation["operando"] == "-", "operando"] = 1
operation.loc[operation["operando"] == "+", "operando"] = 0
total = clf.fit(operation[predictors], operation["tiempo"])

@app.route("/")
def hello():
    return "Hello World!"

@app.route("/predict/<float:op1>/<float:op2>/<float:operando>/")
#@app.route("/predict/<float:op1>/<string:j>/")
def predict(op1, op2, operando):

    return str(total.predict([int(op1),int(operando), int(op2),])[0])

if __name__ == "__main__":

    app.run()

# Desde Rails podeis llamarlo asi

# def estimate
#   self.estimation = HTTP.get("http://localhost:5000/predict/#{op1.to_f}/").to_s
# end
