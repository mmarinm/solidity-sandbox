require('dotenv').config()
HDWalletProvider = require 'truffle-hdwallet-provider'
Web3 = require 'web3'
compile = require './compile'

provider = new HDWalletProvider(
    process.env.MNEMONIC,
    process.env.RINKEBY_URL
)

web3 = new Web3(provider)

deploy = ()->
    try
        accounts = await web3.eth.getAccounts()
    catch e
        console.log e
        
    console.log 'Attempting to deploy from account', accounts[0]
    try
        result = await new web3.eth.Contract(JSON.parse(compile.interface))
            .deploy {data: compile.bytecode, arguments: ['Hi there!']}
            .send {gas: '1000000', from: accounts[0]}
    catch e
        console.log e
    
    console.log 'contract deployed to ', result.options.address


deploy()

