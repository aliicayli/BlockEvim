package com.msku.example.myapplication

import SimpleStorageContract
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import androidx.appcompat.app.AppCompatActivity
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch

class MainActivity : AppCompatActivity() {
    private lateinit var editText: EditText
    private lateinit var saveButton: Button
    private lateinit var simpleStorageContract: SimpleStorageContract

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        editText = findViewById(R.id.editText)
        saveButton = findViewById(R.id.saveButton)

        val web3jUrl = "http://10.0.2.2:7545" // Replace with your Ganache URL
        val contractAddress = "0xe2899890F4B8Fff934c834428537E098C6F69225" // Replace with your deployed contract address
        val privateKey = "0x1daccc535564c562762a7a93a03781997d3df9f8b5c5bf22ccd0756607c469de" // Replace with your private key

        simpleStorageContract = SimpleStorageContract(web3jUrl, contractAddress, privateKey)

        saveButton.setOnClickListener {
            val data = editText.text.toString()

            GlobalScope.launch(Dispatchers.IO) {
                val transactionHash = simpleStorageContract.setData(data)
                println("Transaction Hash: $transactionHash")
            }
        }
    }
}
