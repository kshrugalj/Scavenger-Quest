from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/api')
def test_statement():
    d = {}
    d['Query'] = str(request.args['Query'])
    print('reached query')
    print(d)
    return jsonify(d)


if __name__ == '__main__':
    app.run()
