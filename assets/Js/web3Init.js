if (typeof web3 !== 'undefined') {
    web3 = new Web3(web3.currentProvider);
} else {
    web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:7545"));
}
var accountAddress = web3.eth.defaultAccount = web3.eth.accounts[0];
var LandContract = web3.eth.contract([
    {
      "inputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "name": "nid",
          "type": "uint256"
        }
      ],
      "name": "UserCreation",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "name": "plotHash",
          "type": "bytes32"
        }
      ],
      "name": "PlotCreation",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "name": "khatianHash",
          "type": "bytes32"
        }
      ],
      "name": "KhatiyanCreation",
      "type": "event"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_uid",
          "type": "uint256"
        },
        {
          "name": "_khatianHash",
          "type": "bytes32"
        }
      ],
      "name": "addUserOwned",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_fullName",
          "type": "string"
        },
        {
          "name": "_fathersName",
          "type": "string"
        },
        {
          "name": "_district",
          "type": "string"
        },
        {
          "name": "_thana",
          "type": "string"
        },
        {
          "name": "_postCode",
          "type": "uint24"
        },
        {
          "name": "_village",
          "type": "string"
        },
        {
          "name": "_nid",
          "type": "uint256"
        }
      ],
      "name": "createUser",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "getUserArrayLen",
      "outputs": [
        {
          "name": "len",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "id",
          "type": "uint256"
        }
      ],
      "name": "getUserIdById",
      "outputs": [
        {
          "name": "UserId",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "_nid",
          "type": "uint256"
        }
      ],
      "name": "getUserByNid",
      "outputs": [
        {
          "name": "fullName",
          "type": "bytes32"
        },
        {
          "name": "fathersName",
          "type": "bytes32"
        },
        {
          "name": "district",
          "type": "bytes32"
        },
        {
          "name": "thana",
          "type": "bytes32"
        },
        {
          "name": "postCode",
          "type": "uint24"
        },
        {
          "name": "village",
          "type": "bytes32"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "_uid",
          "type": "uint256"
        }
      ],
      "name": "getUserOwnedByNid",
      "outputs": [
        {
          "name": "number",
          "type": "uint256"
        },
        {
          "name": "khatianList",
          "type": "bytes32[]"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_division",
          "type": "string"
        },
        {
          "name": "_district",
          "type": "string"
        },
        {
          "name": "_thana",
          "type": "string"
        },
        {
          "name": "_JLNo",
          "type": "uint16"
        },
        {
          "name": "_plotNo",
          "type": "uint16"
        },
        {
          "name": "_plotType",
          "type": "uint8"
        },
        {
          "name": "_plotArea",
          "type": "uint32"
        }
      ],
      "name": "createPlot",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "getPlotArrayLen",
      "outputs": [
        {
          "name": "len",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "id",
          "type": "uint256"
        }
      ],
      "name": "getPlotHashById",
      "outputs": [
        {
          "name": "plotHash",
          "type": "bytes32"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "plotHash",
          "type": "bytes32"
        }
      ],
      "name": "getPlotByHash",
      "outputs": [
        {
          "name": "division",
          "type": "bytes32"
        },
        {
          "name": "district",
          "type": "bytes32"
        },
        {
          "name": "thana",
          "type": "bytes32"
        },
        {
          "name": "JLNo",
          "type": "uint16"
        },
        {
          "name": "plotNo",
          "type": "uint16"
        },
        {
          "name": "plotType",
          "type": "uint8"
        },
        {
          "name": "plotArea",
          "type": "uint32"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_khatianiId",
          "type": "uint64"
        },
        {
          "name": "_plotHash",
          "type": "bytes32"
        },
        {
          "name": "_percentOwn",
          "type": "uint16"
        },
        {
          "name": "_user",
          "type": "uint256[]"
        },
        {
          "name": "_percentage",
          "type": "uint16[]"
        }
      ],
      "name": "createKhatiyan",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": false,
      "inputs": [
        {
          "name": "_khatianiId",
          "type": "uint64"
        },
        {
          "name": "_plotHash",
          "type": "bytes32"
        },
        {
          "name": "_percentOwn",
          "type": "uint16"
        },
        {
          "name": "_buyFrom",
          "type": "bytes32"
        },
        {
          "name": "_user",
          "type": "uint256[]"
        },
        {
          "name": "_percentage",
          "type": "uint16[]"
        }
      ],
      "name": "createKhatiyanFromOld",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [],
      "name": "getKhatianArrayLen",
      "outputs": [
        {
          "name": "len",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "id",
          "type": "uint256"
        }
      ],
      "name": "getKhatianHasById",
      "outputs": [
        {
          "name": "khatianHash",
          "type": "bytes32"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "khatianHash",
          "type": "bytes32"
        }
      ],
      "name": "getKhatianByHash",
      "outputs": [
        {
          "name": "khatianiId",
          "type": "uint64"
        },
        {
          "name": "plotHash",
          "type": "bytes32"
        },
        {
          "name": "percentOwn",
          "type": "uint16"
        },
        {
          "name": "buyFrom",
          "type": "bytes32"
        },
        {
          "name": "sellTo",
          "type": "bytes32[]"
        },
        {
          "name": "sellPercentage",
          "type": "uint16[]"
        },
        {
          "name": "ownerArray",
          "type": "uint256[]"
        },
        {
          "name": "perOwnerPercentage",
          "type": "uint16[]"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }
  ]);
var contract = LandContract.at('0x7c873Eb24A610449742c82794384Fc42812f26a0');