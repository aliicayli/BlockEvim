using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Nethereum.Hex.HexTypes;
using Nethereum.Web3;
using Nethereum.Contracts;
using System.IO;
using Newtonsoft.Json.Linq;
using Nethereum.Web3.Accounts;
using Nethereum.RPC.Eth.DTOs;
using System.Numerics;
using Xunit;
using System.Threading;

namespace TestBlock
{
    /// <summary>
    /// MainWindow.xaml etkileşim mantığı
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            var web3 = new Web3("http://localhost:5001");
            //var contractAddress = "0xf8e81D47203A594245E36C48e151709F0C19fBe8";

            //var abi = @"[{'inputs':[],'name':'print','outputs':[{'internalType':'string','name':'','type':'string'}],'stateMutability':'pure','type':'function'}]";
            //var contract = web3.Eth.GetContract(abi, contractAddress);
            //var printFunction = contract.GetFunction("print");
            //var a = printFunction.CallAsync<string>().re;

            ////var result = printFunction.CallAsync<string>().Result;

            //MessageBox.Show(a.ToString());


            //GetAccountBalance();




            Test4();
        }


        static void GetAccountBalance()
        {
            ////var web3 = new Web3("https://mainnet.infura.io/v3/83b74693e4bc43c19b92ad521d050744");
            //var web3 = new Web3("HTTP://127.0.0.1:7545");
            ////var balance = web3.Eth.GetBalance.SendRequestAsync("0xbd3Afb0bB76683eCb4225F9DBc91f998713C3b01");
            //var balance = web3.Eth.GetBalance.SendRequestAsync("0x58A616402a8fde6DC983525aC69b3645279a8B94").Result;
            //MessageBox.Show(balance + "togg");

            //var web3 = new Web3("HTTP://127.0.0.1:7545");
            //var balance = web3.Eth.GetBalance.SendRequestAsync("0x95625F4ba2B339baf9ebeffb59792CcdD3268113").Result;
            //web3.Eth.baa
            //MessageBox.Show(balance + "togg");




            var web3 = new Web3("HTTP://127.0.0.1:7545");
            var contractAddress = "0x86D832B6EC56134E422Dc6A3cE536FE30b228e79";

            var secondAbi = @"[{'anonymous':false,'inputs':[{'indexed':false,'internalType':'string','name':'phoneNumber','type':'string'},{'indexed':false,'internalType':'int256','name':'count','type':'int256'}],'name':'PhoneNumberReported','type':'event'},{'inputs':[{'internalType':'string','name':'phoneNumber','type':'string'}],'name':'checkReports','outputs':[{'internalType':'int256','name':'','type':'int256'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'string','name':'phoneNumber','type':'string'}],'name':'reportNumber','outputs':[],'stateMutability':'nonpayable','type':'function'}]";
            //var contract = web3.Eth.GetContract(secondAbi, contractAddress);
            //var printFunction = contract.GetFunction("set").CallAsync<string>().Result;

            var contract = web3.Eth.GetContract(secondAbi, contractAddress);
            var setFunction = contract.GetFunction("reportNumber");
            var printFunction = contract.GetFunction("reportNumber").CallAsync<string>("test").Result;
            setFunction.SendTransactionAndWaitForReceiptAsync("Togg");
            var transactionHash = setFunction.SendTransactionAsync("hello world");
            var printFunction2 = contract.GetFunction("reportNumber").CallAsync<string>("Test2").Result;


            var test = contract.GetFunction("reportNumber");
            test.SendTransactionAndWaitForReceiptAsync("test");

            //var a = printFunction.SendTransactionAsync("togg").Result;

            //MessageBox.Show(a.ToString());



        }


        static async Task Test()
        {
            var web3 = new Web3("HTTP://127.0.0.1:7545");
            var latestBlockNumber = await web3.Eth.Blocks.GetBlockNumber.SendRequestAsync();
            var block = await web3.Eth.Blocks.GetBlockWithTransactionsByNumber.SendRequestAsync(new HexBigInteger(latestBlockNumber.Value));
            MessageBox.Show($"En son blok numarası: {latestBlockNumber.Value}");
            MessageBox.Show($"En son blok özeti hash'i: {block.BlockHash}");
        }

        static async Task Test2()
        {
            var web3 = new Web3("HTTP://127.0.0.1:7545");
            var latestBlockNumber = await web3.Eth.Blocks.GetBlockNumber.SendRequestAsync();
            var block = await web3.Eth.Blocks.GetBlockWithTransactionsByNumber.SendRequestAsync(new HexBigInteger(latestBlockNumber.Value));
           
            MessageBox.Show($"En son blok numarası: {latestBlockNumber.Value}");
            MessageBox.Show($"En son blok özeti hash'i: {block.BlockHash}");


        }

        static async Task Test3()
        {
        //    var web3 = new Web3("HTTP://127.0.0.1:7545");
        //    var blockNumber = await web3.Eth.Blocks.GetBlockNumber.SendRequestAsync();
        //    Console.WriteLine($"Current block number: {blockNumber.Value}");

        //    var newBlock = new NewBlock
        //    {
        //        ParentHash = await web3.Eth.Blocks.GetBlockHash.SendRequestAsync(blockNumber),
        //        Miner = "0x0000000000000000000000000000000000000000",
        //        Difficulty = new HexBigInteger(1),
        //        ExtraData = "0x",
        //        GasLimit = new HexBigInteger(1000000),
        //        Timestamp = new HexBigInteger((ulong)DateTimeOffset.UtcNow.ToUnixTimeSeconds())
        //    };

        //    var blockHash = await web3.Eth.Miner.Start.SendRequestAsync(newBlock);
        //    Console.WriteLine($"New block created with hash: {blockHash}");
        //}


    }

        static async Task Test4()
        {
            var senderAddress = "0x86D832B6EC56134E422Dc6A3cE536FE30b228e79";
            var password ="password" ;
            var abi = @"[{'anonymous':false,'inputs':[{'indexed':false,'internalType':'string','name':'phoneNumber','type':'string'},{'indexed':false,'internalType':'int256','name':'count','type':'int256'}],'name':'PhoneNumberReported','type':'event'},{'inputs':[{'internalType':'string','name':'phoneNumber','type':'string'}],'name':'checkReports','outputs':[{'internalType':'int256','name':'','type':'int256'}],'stateMutability':'view','type':'function'},{'inputs':[{'internalType':'string','name':'phoneNumber','type':'string'}],'name':'reportNumber','outputs':[],'stateMutability':'nonpayable','type':'function'}]";
            var byteCode = "608060405234801561000f575f80fd5b5061049e8061001d5f395ff3fe608060405234801561000f575f80fd5b5060043610610034575f3560e01c806385556f9114610038578063911e904e14610068575b5f80fd5b610052600480360381019061004d919061028a565b610084565b60405161005f91906102e9565b60405180910390f35b610082600480360381019061007d919061028a565b6100ac565b005b5f8082604051610094919061036e565b90815260200160405180910390205f01549050919050565b60015f826040516100bd919061036e565b90815260200160405180910390205f015f8282546100db91906103b1565b925050819055507fc46aa8ae8d7178a76af2501d0c47d7ce3f8ef2c4f8023b31247c04c7ef02d5c2815f83604051610113919061036e565b90815260200160405180910390205f015460405161013292919061043a565b60405180910390a150565b5f604051905090565b5f80fd5b5f80fd5b5f80fd5b5f80fd5b5f601f19601f8301169050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b61019c82610156565b810181811067ffffffffffffffff821117156101bb576101ba610166565b5b80604052505050565b5f6101cd61013d565b90506101d98282610193565b919050565b5f67ffffffffffffffff8211156101f8576101f7610166565b5b61020182610156565b9050602081019050919050565b828183375f83830152505050565b5f61022e610229846101de565b6101c4565b90508281526020810184848401111561024a57610249610152565b5b61025584828561020e565b509392505050565b5f82601f8301126102715761027061014e565b5b813561028184826020860161021c565b91505092915050565b5f6020828403121561029f5761029e610146565b5b5f82013567ffffffffffffffff8111156102bc576102bb61014a565b5b6102c88482850161025d565b91505092915050565b5f819050919050565b6102e3816102d1565b82525050565b5f6020820190506102fc5f8301846102da565b92915050565b5f81519050919050565b5f81905092915050565b5f5b83811015610333578082015181840152602081019050610318565b5f8484015250505050565b5f61034882610302565b610352818561030c565b9350610362818560208601610316565b80840191505092915050565b5f610379828461033e565b915081905092915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f6103bb826102d1565b91506103c6836102d1565b92508282019050828112155f8312168382125f8412151617156103ec576103eb610384565b5b92915050565b5f82825260208201905092915050565b5f61040c82610302565b61041681856103f2565b9350610426818560208601610316565b61042f81610156565b840191505092915050565b5f6040820190508181035f8301526104528185610402565b905061046160208301846102da565b939250505056fea2646970667358221220c006350c89fa80d9656c76b29b0b6370e85b03a2d7dc34dde209164e4306705f64736f6c63430008160033";
            var multiplier = 7; 

            var web3 = new Web3();
            //var unlockAccountResult = await web3.Personal.UnlockAccount.SendRequestAsync(senderAddress, password, new HexBigInteger(120));
            //Assert.True(unlockAccountResult);
            //var transactionHash = web3.Eth.DeployContract.SendRequestAsync(abi, byteCode, senderAddress, "asd");
            var transactionHash = web3.Eth.DeployContract.SendRequestAsync(byteCode, "asd");
            //var mineResult = await web3.Miner.Start.SendRequestAsync(6);
            //Assert.True(mineResult);

            var receipt =  web3.Eth.Transactions.GetTransactionReceipt.SendRequestAsync(transactionHash.Result);

            receipt =  web3.Eth.Transactions.GetTransactionReceipt.SendRequestAsync(transactionHash.Result);
            MessageBox.Show(5.ToString());

            var contractAddress = receipt.Result.ContractAddress;
            var contract = web3.Eth.GetContract(abi, contractAddress);
            var multiplyFunction = contract.GetFunction("reportNumber");
            var result = multiplyFunction.CallAsync<string>("asd").Result;
            MessageBox.Show(receipt.ToString());
                }
    }

        
}
