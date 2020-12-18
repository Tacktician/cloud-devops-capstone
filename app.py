import logging
import os

from flask import Flask
from flask import jsonify
from flask import request
from flask_pymongo import PyMongo

app = Flask(__name__)

app.config['MONGO_DBNAME'] = 'dbzdata'
app.config['MONGO_URI'] = 'mongodb://' + os.getenv('MONGO_URI', 'localhost') + ':27017/dbzdata'
mongodb = PyMongo(app)


@app.route('/')
def default_route():
    """Default route to return a simple message"""
    return jsonify('Please use /dbz URI to view content')


@app.route('/dbz', methods=['GET'])
def get_all_dbzs():
    dbz = mongodb.db.dbzdata
    output = []
    for s in dbz.find():
        output.append({'name': s['name'], 'powerlevel': s['powerlevel']})
    return jsonify({'result': output})


@app.route('/dbz/<name>', methods=['GET'])
def get_one_dbz(name):
    dbz = mongodb.db.dbzdata
    s = dbz.find_one({'name': name})
    if request.method == 'GET':
        if s:
            output = {'name': s['name'], 'powerlevel': s['powerlevel']}
        else:
            output = "No such DBZ Warrior!"
    return jsonify({'result': output})


@app.route('/dbz', methods=['POST'])
def add_dbz():
    dbz = mongodb.db.dbzdata
    name = request.json['name']
    power_level = request.json['powerlevel']
    dbz_id = dbz.insert({'name': name, 'powerlevel': power_level})
    new_dbz = dbz.find_one({'_id': dbz_id})
    output = {'name': new_dbz['name'], 'powerlevel': new_dbz['powerlevel']}
    return jsonify({'result': output})


application = app


if __name__ == '__main__':
    logging.info('starting with MONGO_URL %d', os.getenv('MONGO_URI', 'localhost'))
    app.run(host='0.0.0.0', debug=True)
