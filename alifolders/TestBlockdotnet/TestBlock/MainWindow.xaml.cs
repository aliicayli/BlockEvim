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
            var web3 = new Web3("https://remix.ethereum.org");
            var contractAddress = "0xddaAd340b0f1Ef65169Ae5E41A8b10776a75482d";

            var abi = @"[{'inputs':[],'name':'print','outputs':[{'internalType':'string','name':'','type':'string'}],'stateMutability':'pure','type':'function'}]";
            var contract = web3.Eth.GetContract(abi, contractAddress);
            var printFunction = contract.GetFunction("print");
            var a = printFunction.CallAsync<string>().Result;
            //var result = printFunction.CallAsync<string>().Result;


            MessageBox.Show(a.ToString());
        }
    }
}
