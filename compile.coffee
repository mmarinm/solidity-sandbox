path = require 'path'
fs = require 'fs'
solc = require 'solc'

inboxPath = path.resolve(__dirname, 'contracts', 'Inbox.sol')
source = fs.readFileSync(inboxPath, 'utf8')

module.exports = solc.compile(source, 1).contracts[':Inbox']
