import Navbar from "../Components/Navbar"
// import { useState, useEffect } from 'react'


export default function Rewards() {

    return (
        <div className="bg-gray-300 h-screen">
            <Navbar />
            <div className="flex justify-center h-3/5 w-auto" >
                <div className="flex flex-col justify-between w-full mt-20 max-w-md bg-white border-gray-400 border-8 rounded-3xl shadow-lg">
                    <div className="px-5 pb-5 text-center text-blue-500 text-3xl pt-4 font-bold shadow bg-gray-200 rounded-2xl">
                        You are eligible to receive:
                    </div>
                    <div className="px-5 pb-5 text-center text-blue-500 text-3xl pt-4 font-bold shadow bg-gray-200 rounded-2xl">
                        240 FLP
                    </div>
                    <button className="px-5 pb-5 text-center text-blue-500 text-3xl pt-4 font-bold shadow bg-yellow-400 hover:bg-yellow-500 rounded-2xl">
                        Claim now
                    </button>
                </div>
            </div>
        </div>
    )
}