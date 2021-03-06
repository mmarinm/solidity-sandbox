assert = require 'assert'
ganache = require 'ganache-cli'
Web3 = require 'web3'
web3 = new Web3 ganache.provider()
compile = require '../compile'


accounts = null
inbox = null

beforeEach ()->
    accounts = await web3.eth.getAccounts()
    inbox = await new web3.eth.Contract(JSON.parse compile.interface)
        .deploy {data: compile.bytecode, arguments: ['Hi there!']}
        .send {from: accounts[0], gas: '1000000'}


describe 'Inbox', ()->
    it 'should deploy a contract', ()->
        assert.ok inbox.options.address

    it 'has a default message', ()->
        message = await inbox.methods.message().call()
        assert.equal(message, 'Hi there!')

    it 'should set new value of the message', ()->
        await inbox.methods.setMessage('bye').send({from: accounts[0]})
        message = await inbox.methods.message().call()
        assert.equal(message, 'bye')

