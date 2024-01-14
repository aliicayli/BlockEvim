package block;

import java.io.IOException;

import org.bouncycastle.util.encoders.Hex;
import org.web3j.abi.datatypes.Address;
import org.web3j.protocol.Web3j;
import org.web3j.protocol.core.DefaultBlockParameterName;
import org.web3j.protocol.core.methods.response.EthGetCode;
import org.web3j.protocol.core.methods.response.Web3ClientVersion;
import org.web3j.protocol.http.HttpService;
import org.web3j.tx.Contract;


public class Main {
    //String bytecode = "0x<your_bytecode>";
    //byte[] bytecodeBytes = Hex.decode(bytecode.substring(2));


    //Web3j web3j = Web3j.build(new HttpService("http://localhost:8545"));
    //String contractAddress = "0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B";
    //String bytecode = "608060405234801561000f575f80fd5b506101688061001d5f395ff3fe608060405234801561000f575f80fd5b5060043610610029575f3560e01c806313bdfacd1461002d575b5f80fd5b61003561004b565b6040516100429190610112565b60405180910390f35b60606040518060400160405280600c81526020017f48656c6c6f20576f726c64210000000000000000000000000000000000000000815250905090565b5f81519050919050565b5f82825260208201905092915050565b5f5b838110156100bf5780820151818401526020810190506100a4565b5f8484015250505050565b5f601f19601f8301169050919050565b5f6100e482610088565b6100ee8185610092565b93506100fe8185602086016100a2565b610107816100ca565b840191505092915050565b5f6020820190508181035f83015261012a81846100da565b90509291505056fea264697066735822122065ac960991ab8cc80564a8986fa68ad97739d79711dad9dcd1a055bdd00b979f64736f6c63430008160033";


   
    public static void main(String[] args) {
         Web3j web3j = Web3j.build(new HttpService("https://remix.ethereum.org"));
         Web3ClientVersion web3ClientVersion = null;
        try {
            web3ClientVersion = web3j.web3ClientVersion().send();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String web3ClientVersionString  = web3ClientVersion.getWeb3ClientVersion();
        //System.out.println(web3ClientVersionString);
        
        

        
        //  EthGetCode ethGetCode;
        // try {
        //     ethGetCode = web3j.ethGetCode("0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47",DefaultBlockParameterName.LATEST).send();
        //     String s=ethGetCode.getCode();
        //     System.out.println(s);
        // } catch (IOException e) {
        //     System.out.println("asd");
        // }
    
    }
}