import org.web3j.abi.FunctionEncoder
import org.web3j.abi.FunctionReturnDecoder
import org.web3j.abi.TypeReference
import org.web3j.abi.datatypes.Function
import org.web3j.abi.datatypes.Utf8String
import org.web3j.crypto.Credentials
import org.web3j.crypto.RawTransaction
import org.web3j.crypto.TransactionEncoder
import org.web3j.crypto.WalletUtils
import org.web3j.protocol.Web3j
import org.web3j.protocol.core.DefaultBlockParameterName
import org.web3j.protocol.core.methods.request.Transaction
import org.web3j.protocol.http.HttpService
import org.web3j.tx.RawTransactionManager
import org.web3j.tx.gas.DefaultGasProvider
import org.web3j.utils.Numeric
import java.math.BigInteger
import java.util.concurrent.CompletableFuture

class SimpleStorageContract(web3jUrl: String, private val contractAddress: String, private val privateKey: String) {

    private val web3j: Web3j = Web3j.build(HttpService(web3jUrl))
    private val credentials: Credentials = Credentials.create(privateKey)
    private val gasProvider: DefaultGasProvider = DefaultGasProvider()

    // Function to set data in the contract
    fun setData(data: String): CompletableFuture<String> {
        val function = Function(
            "setData",
            listOf(Utf8String(data)),
            emptyList()
        )

        val encodedFunction = FunctionEncoder.encode(function)

        val rawTransaction = RawTransaction.createTransaction(
            web3j.ethGetTransactionCount(credentials.address, DefaultBlockParameterName.LATEST).send().transactionCount,
            DefaultGasProvider.GAS_PRICE,
            DefaultGasProvider.GAS_LIMIT,
            contractAddress,
            BigInteger.ZERO,
            encodedFunction
        )

        val signedMessage = TransactionEncoder.signMessage(rawTransaction, credentials)
        val hexValue = Numeric.toHexString(signedMessage)

        return web3j.ethSendRawTransaction(hexValue).sendAsync().thenApply { ethSendTransaction ->
            if (ethSendTransaction.hasError()) {
                throw RuntimeException("Error processing transaction: ${ethSendTransaction.error.message}")
            } else {
                ethSendTransaction.transactionHash
            }
        }
    }

    // Function to get data from the contract
    fun getData(): String {
        val function = Function(
            "getData",
            emptyList(),
            listOf(object : TypeReference<Utf8String?>() {})
        )

        val response = executeCallFunction(function)
        val result = FunctionReturnDecoder.decode(response, function.outputParameters)

        return if (result.isEmpty()) {
            "" // Return empty string if there is no data
        } else {
            result[0].value.toString()
        }
    }

    private fun executeCallFunction(function: Function): String {
        val encodedFunction = FunctionEncoder.encode(function)
        val ethCall = web3j.ethCall(
            Transaction.createEthCallTransaction(
                credentials.address,
                contractAddress,
                encodedFunction
            ),
            DefaultBlockParameterName.LATEST
        ).send()

        return ethCall.result
    }
}
