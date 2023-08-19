// import { useEffect } from "react"
import Navbar from "../Components/Navbar"
import { useState, useEffect } from 'react'
import contractABI from "./abi.json"
import {ethers, BigNumber} from "ethers";


export default function Rewards() {

    //The mintAmount can be set according to seller's choice later on.
    //It is taken as 240 for demo purpose.
    const [account , setAccount] = useState("")
    const [mintAmount, setMintAmount] = useState(240)
    const contractAddress = "0xda25c1d3c9fad934c8cc5d4cd74643fe1fefae1a"

    //This function is used to connect the user's metamask account to the website.
    async function web3Handler() {
        if (typeof window.ethereum !== 'undefined') {
            window.ethereum.request({ method: 'eth_requestAccounts' })
                .then((accounts) => {
                    setAccount(accounts[0])
                })
                .catch((err) => {
                    console.log(err)
            })
        }
    }
    //This useEffect is used to call the web3Handler function only once when the page is loaded.
    useEffect(() => {
        web3Handler()
    }, [])

    //This function is used to mint the tokens to the user's account and the amount cannot be changed by the user.
    async function claimHandler() {
        if(window.ethereum) {
            const provider = new ethers.providers.Web3Provider(window.ethereum)
            const signer = provider.getSigner()
            const contract = new ethers.Contract(contractAddress, contractABI, signer)
            if(mintAmount === 0) return alert("Please enter a valid amount")
            try {
                let amount = BigNumber.from(mintAmount).mul(BigNumber.from(10).pow(18)).toString()
                const response = await contract.mintTokens(account, amount)
                console.log("response :", response)
            } catch (err) {
                console.log("error :", err)
            }
        }
    }

    return (
        <div className="bg-gray-300 h-screen">
            <Navbar />
            <div className="flex justify-center h-3/5 w-auto" >
                <div className="flex flex-col justify-between w-full mt-20 max-w-md bg-white border-gray-400 border-8 rounded-3xl shadow-lg">
                    <div className="px-5 pb-5 text-center text-blue-500 text-3xl pt-4 font-bold shadow bg-gray-200 rounded-2xl">
                        You are eligible to receive:
                    </div>
                    <div className="px-5 pb-5 text-center text-blue-500 text-3xl pt-4 font-bold shadow bg-gray-200 rounded-2xl">
                        240 FLIP
                    </div>
                    <button className="px-5 pb-5 text-center text-blue-500 text-3xl pt-4 font-bold shadow bg-yellow-400 hover:bg-yellow-500 rounded-2xl"
                    onClick={claimHandler}
                    >
                        Claim now
                    </button>
                </div>
            </div>
        </div>
    )
}